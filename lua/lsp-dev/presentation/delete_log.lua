local File = require("lsp-dev.infrastructure.file")
local DeleteLogUseCase = require("lsp-dev.usecase.delete_log")
local M = {}

function M.delete_log()
  local file_path = vim.lsp.get_log_path()
  local file = File:new(file_path)
  DeleteLogUseCase:new(file):execute()
end

return M
