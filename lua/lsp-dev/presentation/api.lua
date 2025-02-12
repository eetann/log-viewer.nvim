local M = {}

M.show_log = function()
  require("lsp-dev.presentation.show_log.show_log").show_log()
end

M.delete_log = function()
  require("lsp-dev.presentation.delete_log.delete_log").delete_log()
end

M.change_log_level = function()
  require("lsp-dev.presentation.change_log_level").change_log_level()
end

M.show_capabilities = function()
  require("lsp-dev.presentation.show_capabilities").show_capabilities()
end

return M
