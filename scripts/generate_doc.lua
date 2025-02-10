local MiniDoc = require("mini.doc")
MiniDoc.generate({
  "lua/lsp-dev/init.lua",
  "lua/lsp-dev/presentation/show_log/show_log.lua",
  "lua/lsp-dev/presentation/delete_log/delete_log.lua",
  "lua/lsp-dev/presentation/change_log_level.lua",
  "lua/lsp-dev/presentation/show_capabilities.lua",
  "lua/lsp-dev/presentation/command.lua",
  "lua/lsp-dev/presentation/api.lua",
}, "doc/lsp-dev.txt", {})
