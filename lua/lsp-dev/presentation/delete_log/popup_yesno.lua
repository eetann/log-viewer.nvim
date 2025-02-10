local Popup = require("nui.popup")

---@class LspDev.PopupYesno
local PopupYesno = {}
PopupYesno.__index = PopupYesno

function PopupYesno:new()
  return setmetatable({}, PopupYesno)
end

---@param dateTimeStr string
---@param remain_count integer
---@param callback fun()
function PopupYesno:execute(dateTimeStr, remain_count, callback)
  local content = {}
  if remain_count == 0 then
    table.insert(content, "Do you want to delete ALL logs?")
    table.insert(content, "Really???")
  else
    table.insert(content, "Do you want to delete logs until " .. dateTimeStr)
    table.insert(content, remain_count .. " lines will remain.")
  end
  table.insert(content, "[y/N]")

  local popup = Popup({
    position = "50%",
    size = {
      width = 70,
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
