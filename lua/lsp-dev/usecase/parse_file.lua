local Record = require("lsp-dev.domain.record")
local utils = require("lsp-dev.usecase.shared.utils")

---@class LspDev.ParseFile
local ParseFile = {}
ParseFile.__index = ParseFile

function ParseFile.new()
  return setmetatable({}, ParseFile)
end

---@param file_path string
---@return string
function ParseFile:execute(file_path)
  local content = utils.read_file(file_path)
  local lines = vim.split(content, "\n")
  local records = {}
  for _, line in ipairs(lines) do
    table.insert(records, Record:new(line):get_parsed_text())
    table.insert(records, "---------------")
  end
  return table.concat(records, "\n")
end

return ParseFile
