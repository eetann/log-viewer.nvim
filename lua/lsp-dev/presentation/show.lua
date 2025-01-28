local View = require("log-viewer.presentation.view")
local M = {}

function M.show()
  local view = View:new()
  view:set_content()
  view:set_scroll()
end

return M
