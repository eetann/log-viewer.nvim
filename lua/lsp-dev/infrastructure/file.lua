---@class File: IFile
local File = {}
File.__index = File

function File:new(path)
  return setmetatable({ path = path }, File)
end

---@return string
function File:read()
  local file = io.open(self.path, "r")
  if not file then
    error("Could not open file: " .. self.path)
  end
  local content = file:read("*a")
  file:close()
  return content
end

---@param content string
function File:write(content)
  local file = io.open(self.path, "w")
  if not file then
    error("Could not open file: " .. self.path)
  end
  file:write(content)
  file:close()
end

return File
