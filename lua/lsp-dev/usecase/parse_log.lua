local Record = require("lsp-dev.domain.record")

---@class LspDev.ParseLog
local ParseLog = {}
ParseLog.__index = ParseLog

function ParseLog.new()
  return setmetatable({}, ParseLog)
end

---@param content string
---@return string
function ParseLog:execute(content)
  local lines = vim.split(content, "\n")
  local records = {}
  for _, line in ipairs(lines) do
    if line == "" then
      goto continue
    end
    table.insert(records, Record:new(line):get_parsed_text())
    table.insert(records, "---------------")
    ::continue::
  end
  return table.concat(records, "\n")
end

return ParseLog
