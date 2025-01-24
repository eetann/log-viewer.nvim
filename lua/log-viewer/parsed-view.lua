local M = {}

local function read_file(file_path)
  local file = io.open(file_path, "r")
  if not file then
    error("Could not open file: " .. file_path)
  end
  local content = file:read("*a")
  file:close()
  return content
end

local function parse_json(content)
  local ok, result = pcall(vim.fn.json_decode, content)
  if not ok then
    error("Failed to parse JSON: " .. result)
  end
  return vim.inspect(result)
end

local function create_buffer_with_content(content)
  local buf = vim.api.nvim_create_buf(false, true)
  if not buf then
    error("Failed to create buffer")
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
  vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = 80,
    height = 20,
    row = 10,
    col = 10,
    style = "minimal",
  })
end

M.parsed_view = function()
  vim.print("parsed_view")
  local file_path = vim.fn.expand("~/ghq/dev/foo.json")
  local content = read_file(file_path)
  local parsed_content = parse_json(content)
  create_buffer_with_content(parsed_content)
end

return M
