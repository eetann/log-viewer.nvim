local MiniDoc = require("mini.doc")
local hooks = vim.deepcopy(MiniDoc.default_hooks)

hooks.write_pre = function(lines)
  -- Remove first two lines with `======` and `------` delimiters to comply
  -- with `:h local-additions` template
  table.remove(lines, 1)
  table.remove(lines, 1)
  return lines
end
MiniDoc.generate({
  "lua/lsp-dev/init.lua",
  "lua/lsp-dev/presentation/show_log/show_log.lua",
  "lua/lsp-dev/presentation/delete_log/delete_log.lua",
  "lua/lsp-dev/presentation/change_log_level.lua",
  "lua/lsp-dev/presentation/show_capabilities.lua",
  "lua/lsp-dev/presentation/command.lua",
}, "doc/lsp-dev.txt", { hooks = hooks })
