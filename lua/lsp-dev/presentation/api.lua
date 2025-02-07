---@tag lsp-dev-api
---@toc_entry API
---@text

local M = {}

---@tag lsp-dev.show_log
---@text
---   details -> |lsp-dev-lsp-log-viewer|
M.show_log = function()
  require("lsp-dev.presentation.show_log.show_log").show_log()
end

---@tag lsp-dev.change_log_level
---@text
---   details -> |lsp-dev-change-log-level|
M.change_log_level = function()
  require("lsp-dev.presentation.change_log_level").change_log_level()
end

---@tag lsp-dev.show_capabilities
---@text
---   details -> |lsp-dev-show-capabilities|
M.show_capabilities = function()
  require("lsp-dev.presentation.show_capabilities").show_capabilities()
end

return M
