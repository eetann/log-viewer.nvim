local MiniDoc = require("mini.doc")
MiniDoc.generate({
  "lua/lsp-dev/init.lua",
  "lua/lsp-dev/presentation/command.lua",
  "lua/lsp-dev/presentation/show_log/show_log.lua",
  "lua/lsp-dev/presentation/change_log_level.lua",
}, "doc/lsp-dev.txt", {})
