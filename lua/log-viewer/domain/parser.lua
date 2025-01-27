---@class log-viewer.Parser
local Parser = {}
Parser.__index = Parser

function Parser:new()
  return setmetatable({}, Parser)
end

---@param content string
---@return table
function Parser:capture(content)
  local pattern = [[\v\[(\w+)]\[(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2})] (.+)]]
  local match = vim.fn.matchlist(content, pattern)
  return #match > 0 and { table.unpack(match, 2) } or {}
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
