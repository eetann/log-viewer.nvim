vim.api.nvim_create_user_command("LogViewerLsp", require("log-viewer").show_lsp, {})
