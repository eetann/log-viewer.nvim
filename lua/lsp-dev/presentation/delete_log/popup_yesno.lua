local Popup = require("nui.popup")

---@class LspDev.PopupYesno
local PopupYesno = {}
PopupYesno.__index = PopupYesno

function PopupYesno:new()
  return setmetatable({}, PopupYesno)
end

---@param dateTimeStr string
---@param delete_line_count integer
---@param callback fun()
function PopupYesno:execute(dateTimeStr, delete_line_count, callback)
  local content =
    { "Do you want to delete log until " .. dateTimeStr, delete_line_count .. " lines will remain.", "[y/N]" }

  local popup = Popup({
    position = "50%",
    size = {
      width = 50,
      height = 3,
    },
    border = {
      padding = {
        top = 1,
        bottom = 1,
        left = 1,
        right = 1,
      },
      style = "rounded",
    },
    enter = true,
  })
  popup:mount()

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, content)
  vim.bo[popup.bufnr].modifiable = false
  vim.bo[popup.bufnr].readonly = true

  popup:map("n", "<esc>", function()
    popup:unmount()
  end)
  popup:map("n", "q", function()
    popup:unmount()
  end)
  popup:map("n", "<C-c>", function()
    popup:unmount()
  end)
  popup:map("n", "n", function()
    popup:unmount()
  end)
  popup:map("n", "<CR>", function()
    popup:unmount()
  end)
  popup:map("n", "y", function()
    popup:unmount()
    callback()
  end)
end

return PopupYesno
