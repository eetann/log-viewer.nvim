---@class log-viewer.Parser
local Parser = {}
Parser.__index = Parser

function Parser:new()
  return setmetatable({}, Parser)
end

---@param content string
---@return integer|vim.lpeg.Pattern|nil
function Parser:capture(content)
  -- local pattern = [=[^[(.*)]=]
  local pattern = vim.re.compile([[
    "%[" (%a+) "%]"                     -- START 部分
    "%[" (%d%d%d%d%-%d%d%-%d%d)         -- 日付部分
    " " (%d%d:%d%d:%d%d) "%]"           -- 時間部分
    " " (.+)                            -- 残りのメッセージ
]])
  local match = vim.re.match(content, pattern)
  return match
end

---@param content string
---@return string
function Parser:execute(content)
  -- local lines = vim.split(content, "\n")
  local ok, result = pcall(vim.fn.json_decode, content)
  if not ok then
    error("Failed to parse JSON: " .. result)
  end
  return vim.inspect(result)
end

return Parser
