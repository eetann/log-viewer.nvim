---@class LspDev
local M = {}

---@class Config
---@field opt string Your config option
local config = {
  opt = "Hello!",
}

M.show = function()
  require("lsp-dev.presentation.show_log.show_log").show_log()
end

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  require("lsp-dev.presentation.command")
end

return M
