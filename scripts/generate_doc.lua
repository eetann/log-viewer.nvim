local function format_signature(line)
  -- Try capture function signature
  local name, args = line:match("(%S-)(%b())")
  -- Otherwise pick first word
  name = name or line:match("(%S+)")

  if not name then
    return ""
  end

  -- Tidy arguments
  if args and args ~= "()" then
    local arg_parts = vim.split(args:sub(2, -2), ",")
    local arg_list = {}
    for _, a in ipairs(arg_parts) do
      -- Enclose argument in `{}` while controlling whitespace
      table.insert(arg_list, ("{%s}"):format(vim.trim(a)))
    end
    args = ("(%s)"):format(table.concat(arg_list, ", "))
  end

  return ("`%s`%s"):format(name, args or "")
end

local function visual_text_width(text)
  -- Ignore concealed characters (usually "invisible" in 'help' filetype)
  local _, n_concealed_chars = text:gsub("([*|`])", "%1")
  return vim.fn.strdisplaywidth(text) - n_concealed_chars
end

local function align_text(text, width, direction)
  if type(text) ~= "string" then
    return
  end
  text = vim.trim(text)
  width = width or 78
  direction = direction or "left"

  -- Don't do anything if aligning left or line is a whitespace
  if direction == "left" or text:find("^%s*$") then
    return text
  end

  local n_left = math.max(0, 78 - visual_text_width(text))
  if direction == "center" then
    n_left = math.floor(0.5 * n_left)
  end

  return (" "):rep(n_left) .. text
end

local MiniDoc = require("mini.doc")
MiniDoc.generate(
  {
    "lua/lsp-dev/init.lua",
  },
  "doc/lsp-dev.txt",
  {
    hooks = {
      sections = {
        ["@signature"] = function(s)
          for i, _ in ipairs(s) do
            -- Add extra formatting to make it stand out
            s[i] = format_signature(s[i])

            -- Align accounting for concealed characters
            s[i] = align_text(s[i], 78, "left")
          end
        end,
      },
    },
  }
)
