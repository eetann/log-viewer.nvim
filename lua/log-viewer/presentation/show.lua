local ParseFile = require("log-viewer.usecase.parse_file")
local View = require("log-viewer.presentation.view")
local M = {}

function M.show()
  local file_path = vim.fn.expand("~/ghq/dev/foo.json")
  local parsed_content = ParseFile:new():execute(file_path)
  local view = View:new()
  view:set_content(parsed_content)
end

return M
