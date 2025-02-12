local InputDatetime = require("lsp-dev.presentation.delete_log.input_datetime")
local PopupYesno = require("lsp-dev.presentation.delete_log.popup_yesno")
local File = require("lsp-dev.infrastructure.file")
local DeleteLogUseCase = require("lsp-dev.usecase.delete_log")

local M = {}

---@tag lsp-dev-delete_log
---@toc_entry Delete LSP log
---@text
--- Delete LSP log ~
--- Delete logs from the beginning of the file to the date and time you entered.
--- On the dialog to decide until when to delete,
---  enter `all` and all logs will be deleted.
function M.delete_log()
  InputDatetime:new():execute(function(dateTimeStr)
    local file_path = vim.lsp.get_log_path()
    local file = File:new(file_path)
    local records = DeleteLogUseCase:new(file):execute(dateTimeStr)
    if records == nil then
      return
    end
    local content = table.concat(records, "\n")
    PopupYesno:new():execute(dateTimeStr, #records, function()
      file:write(content)
      vim.notify("Finished: DeleteLog until " .. dateTimeStr)
    end)
  end)
end

return M
