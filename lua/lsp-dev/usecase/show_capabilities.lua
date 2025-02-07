---@class LspDev.ShowCapabilities
local ShowCapabilities = {}
ShowCapabilities.__index = ShowCapabilities

---@param name string
---@param content string
local function create_buffer(name, content)
  local buf = vim.api.nvim_create_buf(false, true)
  if not buf then
    error("Failed to create buffer")
  end
  vim.api.nvim_buf_set_name(buf, name .. ": capabilities")

  vim.cmd("split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  vim.keymap.set("n", "q", ("<CMD>bdelete %d<CR>"):format(buf))
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.split(content, "\n"))

  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "delete"
end

---@param client vim.lsp.Client
local function show_on_buffer(client)
  local capabilities = vim.inspect(client.capabilities)
  create_buffer(client.name, capabilities)
end

function ShowCapabilities:new()
  return setmetatable({}, ShowCapabilities)
end

function ShowCapabilities:execute()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    vim.notify("No LSP clients attached")
    return
  elseif #clients == 1 then
    show_on_buffer(clients[1])
    return
  end

  vim.ui.select(clients, {
    prompt = "Select Language Server",
    ---@param client vim.lsp.Client
    ---@return string
    format_item = function(client)
      return client.name
    end,
  }, show_on_buffer)
end

return ShowCapabilities
