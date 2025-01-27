local ParseFile = require("log-viewer.usecase.parse_file")
local View = require("log-viewer.presentation.view")
local M = {}

function M.show()
  local file_path = vim.lsp.get_log_path()
  local content = ParseFile:new():execute(file_path)
  local view = View:new()
  view:set_content(content)
end

return M
