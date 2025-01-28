local Record = require("lsp-dev.domain.record")

---@class lsp-dev.ParseFile
local ParseFile = {}
ParseFile.__index = ParseFile

function ParseFile.new()
  return setmetatable({}, ParseFile)
end

---@param file_path string
---@return string
local function read_file(file_path)
  local file = io.open(file_path, "r")
  if not file then
    error("Could not open file: " .. file_path)
  end
  local content = file:read("*a")
  file:close()
  return content
end

---@param file_path string
---@return string
function ParseFile:execute(file_path)
  local content = read_file(file_path)
  local lines = vim.split(content, "\n")
  local records = {}
  for _, line in ipairs(lines) do
    table.insert(records, Record:new(line):get_parsed_text())
    table.insert(records, "---------------")
  end
  return table.concat(records, "\n")
end

return ParseFile
