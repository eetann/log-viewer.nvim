local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

---@class LspDev.InputDatetime
local InputDatetime = {}
InputDatetime.__index = InputDatetime

function InputDatetime:new()
  return setmetatable({}, InputDatetime)
end

---@param callback fun(value:string)
function InputDatetime:execute(callback)
  local now = vim.fn.localtime()
  local before_24h = now - (60 * 60 * 24)
  local before_24h_str = vim.fn.strftime("%Y-%m-%d %H:%M:%S", before_24h)

  local input = Input({
    position = "50%",
    size = {
      width = 50,
    },
    border = {
      style = "single",
      text = {
        top = "[When do you want to remove the until?]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "> ",
    default_value = before_24h_str,
    on_close = function()
      print("Input Closed!")
    end,
    on_submit = function(value)
      callback(value)
    end,
  })

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return InputDatetime
