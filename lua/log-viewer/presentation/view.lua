---@class log-viewer.View
---@field buf integer
---@field win integer
View = {}
View.__index = View

function View.new()
  local buf = vim.api.nvim_create_buf(false, true)
  if not buf then
    error("Failed to create buffer")
  end

  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  return setmetatable({ buf = buf, win = win }, View)
end

---@param content string
function View:set_content(content)
  vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, vim.fn.split(content, "\n"))
  vim.api.nvim_set_option_value("modifiable", false, { buf = self.buf })
end

return View
