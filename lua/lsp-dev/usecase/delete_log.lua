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

---@param dateTimeStr string
---@return osdateparam
function DeleteLog:parse_date(dateTimeStr)
  local s_year, s_month, s_day, s_hour, s_minute, s_second = dateTimeStr:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
  return {
    year = tonumber(s_year),
    month = tonumber(s_month),
    day = tonumber(s_day),
    hour = tonumber(s_hour),
    min = tonumber(s_minute),
    sec = tonumber(s_second),
  }
end

---@param dateTimeStr string
---@return string[]|nil
function DeleteLog:execute(dateTimeStr)
  if dateTimeStr:lower() == "all" then
    return {}
  end
  local delete_end = self:parse_date(dateTimeStr)
  if delete_end.sec == nil then
    vim.notify("Date and time format is wrong.")
    return nil
  end

  local content = self.file:read()
  return self:delete_lines(delete_end, content)
end

---@param delete_end osdate
---@param content string
---@return string[]
function DeleteLog:delete_lines(delete_end, content)
  local lines = vim.split(content, "\n")

  local delete_end_unixtime = os.time(delete_end --[[@as osdateparam]])

  local records = {}
  for _, line in ipairs(lines) do
    local capture = Record:capture(line)
    local date = capture[2]
    local time = capture[3]
    if date == "" or time == "" then
      goto continue
    end
    local datetime = self:parse_date(date .. " " .. time)
    if datetime == {} then
      goto continue
    end
    local record_unixtime = os.time(datetime)
    if delete_end_unixtime < record_unixtime then
      table.insert(records, line)
    end
    ::continue::
  end
  return records
end

return DeleteLog
