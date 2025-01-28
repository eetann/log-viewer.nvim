local ParseFile = require("lsp-dev.usecase.parse_file")

local file_path = vim.lsp.get_log_path()

---@class LspDev.View
---@field buf integer
---@field win integer
---@field is_last_line boolean
View = {}
View.__index = View

function View:new()
  local buf = vim.api.nvim_create_buf(false, true)
  if not buf then
    error("Failed to create buffer")
  end
  vim.api.nvim_buf_set_name(buf, "nvim-lsp-log")

  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.cmd("setfiletype nvim-lsp-log")
  vim.keymap.set("n", "q", ("<CMD>bdelete %d<CR>"):format(buf))

  return setmetatable({ buf = buf, win = win, is_last_line = false }, View)
end

function View:set_content()
  vim.bo[self.buf].modifiable = true
  local content = ParseFile:new():execute(file_path)
  vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, vim.fn.split(content, "\n"))
  vim.bo[self.buf].modifiable = false
end

function View:set_scroll()
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = self.buf,
    callback = function()
      vim.print(self.buf)
      local line_count = vim.api.nvim_buf_line_count(self.buf)
      self.is_last_line = vim.api.nvim_win_get_cursor(self.win)[1] == line_count
    end,
  })

  local watch = vim.uv.new_fs_event()
  if not watch then
    return
  end
  watch:start(file_path, {}, function(err)
    vim.schedule(function()
      if err then
        vim.print(err)
      else
        self:set_content()
        if self.is_last_line then
          vim.api.nvim_win_call(self.win, function()
            vim.cmd("normal! G")
          end)
        end
      end
    end)
  end)

  vim.api.nvim_create_autocmd("BufUnload", {
    buffer = self.buf,
    callback = function()
      watch:stop()
      watch:close()
    end,
  })
end

return View
