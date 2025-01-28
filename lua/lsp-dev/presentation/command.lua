---@class LspDev.Subcommand
---@field impl fun(args:string[], opts: table) The comand implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional) Command completions callback, taking the lead of the subcommand's arguments

---@type table<string, LspDev.Subcommand>
local subcmd_tbl = {
  showLog = {
    impl = function()
      require("lsp-dev.presentation.show").show()
    end,
  },
}

---@param opts table :h lua-guide-commands-create
local function lsp_dev_cmd(opts)
  local fargs = opts.fargs
  local subcmd_key = fargs[1]

  local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
  local subcmd = subcmd_tbl[subcmd_key]

  if not subcmd then
    vim.notify("LspDev: Unknown command: " .. subcmd_key, vim.log.levels.ERROR)
    return
  end
  subcmd.impl(args, opts)
end

vim.api.nvim_create_user_command("LspDev", lsp_dev_cmd, {
  nargs = "+",
  desc = "LspDev command with sub command completions",
  complete = function(arg_lead, cmdline, _)
    local subcmd_key, subcmd_arg_lead = cmdline:match("^['<,'>]*LspDev[!]*%s(%S+)%s(.*)$")
    if subcmd_key and subcmd_arg_lead and subcmd_tbl[subcmd_key] and subcmd_tbl[subcmd_key].complete then
      return subcmd_tbl[subcmd_key].complete(subcmd_arg_lead)
    end
    if cmdline:match("^['<,'>]*LspDev[!]*%s+%w*$") then
      local subcmd_keys = vim.tbl_keys(subcmd_tbl)
      return vim
        .iter(subcmd_keys)
        :filter(function(key)
          return key:find(arg_lead) ~= nil
        end)
        :totable()
    end
  end,
  bang = false,
})
