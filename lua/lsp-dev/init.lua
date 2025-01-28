--- *lsp-dev* Help language server developers
---
--- ==============================================================================
--- Table of Contents                                  *lsp-dev-table-of-contents*
---@toc

local LspDev = {}

LspDev.config = {
  word = "Hello!",
}

---@toc_entry Setup
---@text
--- No setup argument is required.
---
LspDev.setup = function(args)
  LspDev.config = vim.tbl_deep_extend("force", LspDev.config, args or {})
  require("lsp-dev.presentation.command")
end

---open lsp log viewer
LspDev.show = function()
  require("lsp-dev.presentation.show_log.show_log").show_log()
end

return LspDev
