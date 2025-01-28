--- *lsp-dev* Help language server developers
---
--- ==============================================================================
--- Table of Contents                                  *lsp-dev-table-of-contents*
---@toc
---@text

local LspDev = {}

LspDev.config = {
  word = "Hello!",
}

---@tag lsp-dev.setup
---@toc_entry Setup
---@text
--- No setup argument is required.
---
LspDev.setup = function(args)
  LspDev.config = vim.tbl_deep_extend("force", LspDev.config, args or {})
  require("lsp-dev.presentation.command")
end

---@tag lsp-dev.show_log
---@text
---   details -> |lsp-dev-lsp-log-viewer|
LspDev.show_log = function()
  require("lsp-dev.presentation.show_log.show_log").show_log()
end

---@tag lsp-dev.change_log_level
---@text
---   details -> |lsp-dev-change-log-level|
LspDev.change_log_level = function()
  require("lsp-dev.presentation.change_log_level").change_log_level()
end

return LspDev
