local M = {}

local Menu = require("nui.menu")

---@param level "TRACE" | "DEBUG" | "INFO" | "WARN" | "ERROR" | "OFF"
---@private
local function set_log_level(level)
  vim.notify("[LspDev] set LSP log level [" .. level .. "]")
  vim.lsp.set_log_level(level)
end

---@tag lsp-dev-change_log_level
---@toc_entry Change log level
---@text
--- Change log level ~
--- You can quickly switch between LSP logging level with a popup.
--- The popup also displayes the current level.
function M.change_log_level()
  local lines = {
    Menu.separator("Now: " .. vim.lsp.log.levels[vim.lsp.log.get_level()]),
    Menu.item("[T] TRACE", { key = "t", level = "TRACE" }),
    Menu.item("[D] DEBUG", { key = "d", level = "DEBUG" }),
    Menu.item("[I] INFO", { key = "i", level = "INFO" }),
    Menu.item("[W] WARN (Neovim default)", { key = "w", level = "WARN" }),
    Menu.item("[E] ERROR", { key = "e", level = "ERROR" }),
    Menu.item("[O] OFF", { key = "o", level = "OFF" }),
  }

  local menu = Menu({
    position = "50%",
    size = {
      width = 25,
    },
    border = {
      style = "single",
      padding = { 1, 2 },
      text = {
        top = "[Choose log level]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    lines = lines,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "q" },
      submit = { "<CR>", "<Space>" },
    },
    on_submit = function(item)
      set_log_level(item.level)
    end,
  })

  for _, line in ipairs(lines) do
    menu:map("n", line.key, function()
      menu:unmount()
      set_log_level(line.level)
    end)
  end

  menu:mount()
end

return M
