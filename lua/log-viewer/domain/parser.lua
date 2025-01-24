---@class log-viewer.Parser
local Parser = {}
Parser.__index = Parser

function Parser:new()
  return setmetatable({}, Parser)
end

---@param content string
---@return string
function Parser:execute(content)
  local ok, result = pcall(vim.fn.json_decode, content)
  if not ok then
    error("Failed to parse JSON: " .. result)
  end
  return vim.inspect(result)
end

return Parser
