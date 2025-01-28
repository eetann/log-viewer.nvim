local View = require("lsp-dev.presentation.show-log.view")
local M = {}

function M.show_log()
  local view = View:new()
  view:set_content()
  view:set_scroll()
end

return M
