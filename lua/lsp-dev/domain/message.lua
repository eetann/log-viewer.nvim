local function parse_table(input)
  ---@diagnostic disable-next-line: param-type-mismatch
  local ok, result = pcall(load("return " .. input))
  return ok and vim.inspect(result) or input
end

---@param text string
---@param input string|nil
---@return string
local function parse_string_list(text, input)
  if not input or input == "" then
    return text
  end
  local result = {}
  for field in input:gmatch('"(.-)"') do
    table.insert(result, table.concat(vim.split(field, "\\n"), "\n"))
  end
  return text .. "\n" .. table.concat(result, "\n")
end

---@alias kind 'rpc' | 'server_request' | ''

---@class LspDev.Message
---@field kind kind
---@field source string
---@field body string
local Message = {}
Message.__index = Message

function Message:new(text)
  local capture = self:capture(text)
  local kind_token = capture[2]
  if kind_token == "rpc.receive" or kind_token == "rpc.send" then
    return setmetatable({
      kind = kind_token,
      source = capture[1],
      body = parse_table(capture[3]),
    }, Message)
  -- TODO: フィルター機能実装したほうが良さそう
  elseif kind_token == "exit_handler" then
    return setmetatable({
      kind = kind_token,
      source = capture[1],
      body = "table……",
    }, Message)
  elseif kind_token ~= "" then
    local parsed_body = parse_string_list(kind_token, capture[3])
    return setmetatable({
      kind = "",
      source = capture[1],
      -- inputがエラーメッセージなどで`\n`があったら改行させる
      body = parsed_body,
    }, Message)
  end
  return setmetatable({
    kind = "",
    source = "",
    body = capture[1],
  }, Message)
end

---@param text string
---@return table
function Message:capture(text)
  local pattern = [[\v^(.*\:\d+)\s+]]
  if vim.fn.match(text, pattern) ~= -1 then
    pattern = [[\v^(.*\:\d+)\s+"(.{-})"\s*(.*)]]
    local match = vim.fn.matchlist(text, pattern)
    return #match > 0 and { unpack(match, 2) } or vim.fn["repeat"]({ "" }, 9)
  end
  local result = vim.fn["repeat"]({ "" }, 8)
  table.insert(result, 1, text)
  return result
end

function Message:get_parsed_text()
  if self.source == "" then
    return string.format("\n%s", self.body)
  elseif self.kind == "" then
    return string.format("%s\n%s", self.source, self.body)
  end
  return string.format("%s %s\n%s", self.source, self.kind, self.body)
end

return Message
