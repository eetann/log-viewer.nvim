---@tag lsp-dev-lsp-log-viewer
---@toc_entry LSP log viewer
---@text
--- LSP log viewer ~
--- View parsed and easy-to-read LSP logs.
--- When the log is updated, the view is also updated.
--- If the cursor is on the last line, it will automatically scroll to the end.
---
--- default mappings:
--- - `q`: close

local View = require("lsp-dev.presentation.show_log.view")
local M = {}

function M.show_log()
  local view = View:new()
  view:set_content()
  view:set_scroll()
end

return M
