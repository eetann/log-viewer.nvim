local Message = require("log-viewer.domain.message")

---@class log-viewer.Record
---@field raw string
---@field level string
---@field date string
---@field time string
---@field message string
local Record = {}
Record.__index = Record

---@param line string
---@return log-viewer.Record
function Record:new(line)
  local capture = self:capture(line)
  local message = Message:new(capture[4]):get_parsed_text()
  local record = { raw = line, level = capture[1], date = capture[2], time = capture[3], message = message }
  return setmetatable(record, Record)
end

---@param line string
---@return table<string>
function Record:capture(line)
  local pattern = [[\v\[(\w+)]\[(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2})] (.+)]]
  local match = vim.fn.matchlist(line, pattern)
  return #match > 0 and { unpack(match, 2) } or vim.fn["repeat"]({ "" }, 9)
end

function Record:get_parsed_text()
  return string.format(
    [[
level = %s
datetime = %s %s
%s]],
    self.level,
    self.date,
    self.time,
    self.message
  )
end

return Record
