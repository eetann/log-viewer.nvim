local M = {}

---@tag lsp-dev-show_capabilities
---@toc_entry Show language server capabilities
---@text
--- Show language server capabilities ~
--- Select Language server and display the selected capabilities as a buffer.
function M.show_capabilities()
  require("lsp-dev.usecase.show_capabilities"):new():execute()
end

return M
