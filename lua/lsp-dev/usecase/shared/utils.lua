local M = {}

---@param file_path string
---@return string
function M.read_file(file_path)
  local file = io.open(file_path, "r")
  if not file then
    error("Could not open file: " .. file_path)
  end
  local content = file:read("*a")
  file:close()
  return content
end

return M
