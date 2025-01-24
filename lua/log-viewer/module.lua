---@class CustomModule
local M = {}

local log_refresh_timer = nil
local log_state = {
  is_last_line = false,
  bufnr = nil,
  window = nil,
}

M.show_lsp = function()
  local logfile = vim.lsp.get_log_path()

  vim.cmd("botright split " .. logfile)
  vim.cmd("resize 10")
  log_state.bufnr = vim.api.nvim_get_current_buf()
  log_state.window = vim.api.nvim_get_current_win()

  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = log_state.bufnr,
    callback = function()
      local line_count = vim.api.nvim_buf_line_count(log_state.bufnr)
      log_state.is_last_line = vim.api.nvim_win_get_cursor(0)[1] == line_count
      vim.print(log_state.is_last_line)
    end,
  })

  if log_refresh_timer then
    log_refresh_timer:stop()
  end

  log_refresh_timer = vim.uv.new_timer()
  if log_refresh_timer then
    log_refresh_timer:start(
      0,
      1000,
      vim.schedule_wrap(function()
        vim.cmd("checktime " .. logfile)
        if log_state.is_last_line then
          vim.api.nvim_win_call(log_state.window, function()
            vim.cmd("normal! G")
          end)
        end
      end)
    )
  end
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if log_refresh_timer then
      log_refresh_timer:stop()
      log_refresh_timer:close()
    end
  end,
})

return M
