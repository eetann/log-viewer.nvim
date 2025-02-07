---@tag lsp-dev-show-capabilities
---@toc_entry Show language server capabilities
---@text
--- Select Language server and display the selected capabilities as a buffer.

local M = {}

function M.show_capabilities()
  require("lsp-dev.usecase.show_capabilities"):new():execute()
end

return M
