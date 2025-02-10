--- *lsp-dev* Help language server developers
---
--- ==============================================================================
--- Table of Contents                                  *lsp-dev-table-of-contents*
---@toc
---@text

local LspDev = require("lsp-dev.presentation.api")

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

return LspDev
