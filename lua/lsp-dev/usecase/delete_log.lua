local Record = require("lsp-dev.domain.record")

---@class LspDev.DeleteLog
---@field file IFile
local DeleteLog = {}
DeleteLog.__index = DeleteLog

---@param file IFile
---@return LspDev.DeleteLog
function DeleteLog:new(file)
  return setmetatable({ file = file }, DeleteLog)
end

---@param dateStr string
---@param timeStr string
---@return osdateparam
function DeleteLog:parse_date(dateStr, timeStr)
  local s_year, s_month, s_day = dateStr:match("(%d+)-(%d+)-(%d+)")
  local year = tonumber(s_year)
  local month = tonumber(s_month)
  local day = tonumber(s_day)
  local s_hour, s_minute, s_second = timeStr:match("(%d+):(%d+):(%d+)")
  local hour = tonumber(s_hour)
  local minute = tonumber(s_minute)
  local second = tonumber(s_second)
  return {
    year = year,
    month = month,
    day = day,
    hour = hour,
    min = minute,
    sec = second,
  }
end

function DeleteLog:execute()
  local content = self.file:read()
  -- TODO: 引数で範囲を指定
  local delete_end = os.date("*t") --[[@as osdate]]
  -- TODO: yes / no
  content = self:delete_lines(delete_end, content)
  self.file:write(content)
end

---@param delete_end osdate
---@param content string
---@return string
function DeleteLog:delete_lines(delete_end, content)
  local lines = vim.split(content, "\n")

  delete_end.day = delete_end.day - 1
  local delete_end_unixtime = os.time(delete_end --[[@as osdateparam]])

  local records = {}
  for _, line in ipairs(lines) do
    local capture = Record:capture(line)
    local date = capture[2]
    local time = capture[3]
    if date == "" or time == "" then
      goto continue
    end
    local datetime = self:parse_date(date, time)
    if datetime == {} then
      goto continue
    end
    local record_unixtime = os.time(datetime)
    if delete_end_unixtime < record_unixtime then
      table.insert(records, line)
    end
    ::continue::
  end
  return table.concat(records, "\n")
end

return DeleteLog
