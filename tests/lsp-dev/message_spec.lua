local Message = require("lsp-dev.domain.message")

describe("message", function()
  it("capture normal", function()
    local text =
      [[.../vim/lsp/rpc.lua:408	"rpc.receive"	{  id = 5,  jsonrpc = "2.0",  method = "workspace/workspaceFolders"}]]
    local result = Message:capture(text)
    local expected = {
      ".../vim/lsp/rpc.lua:408",
      "rpc.receive",
      [[{  id = 5,  jsonrpc = "2.0",  method = "workspace/workspaceFolders"}]],
    }
    assert.are.same(expected, { unpack(result, 1, 3) })
  end)

  it("capture empty", function()
    local text = [[LSP logging initiated]]
    local result = Message:capture(text)
    local expected = {
      "LSP logging initiated",
      "",
    }
    assert.are.same(expected, { unpack(result, 1, 2) })
  end)

  it("new() with parsed body", function()
    local text =
      [[.../vim/lsp/rpc.lua:408	"rpc.receive"	{  id = 5,  jsonrpc = "2.0",  method = "workspace/workspaceFolders"}]]
    local result = Message:new(text)
    local expected = {
      kind = "rpc.receive",
      source = ".../vim/lsp/rpc.lua:408",
      body = vim.inspect({ id = 5, jsonrpc = "2.0", method = "workspace/workspaceFolders" }),
    }
    assert.are.same(expected, result)
  end)

  it("new() other kind with source", function()
    local text = [[...lsp/handlers.lua:627	"File created: foo.md"]]
    local result = Message:new(text)
    local expected = {
      kind = "",
      source = "...lsp/handlers.lua:627",
      body = "File created: foo.md",
    }
    assert.are.same(expected, result)
  end)

  it("new() other kind without source", function()
    local text = "LSP logging initiated"
    local result = Message:new(text)
    local expected = {
      kind = "",
      source = "",
      body = text,
    }
    assert.are.same(expected, result)
  end)

  it("new() with error message", function()
    local text =
      [[.../vim/lsp/rpc.lua:770	"rpc"	"/usr/local/bin/node"	"stderr"	"node:fs:563\n  return binding.open(\n                 ^\n\nError: ENOENT: no such file or directory, open ''\n    at Object.openSync (node:fs:563:18)\n    at readFileSync (node:fs:447:35)\n    at getDict (/Users/eetann/ghq/github.com/eetann/markdown-language-server/packages/server/dist/index.cjs:36721:51)\n    at InstanceCreator.initialize (/Users/eetann/ghq/github.com/eetann/markdown-language-server/packages/server/dist/index.cjs:37082:25) {\n  errno: -2,\n  code: 'ENOENT',\n  syscall: 'open',\n  path: ''\n}\n\nNode.js v23.6.1\n"]]
    local result = Message:new(text)
    local expected = {
      kind = "",
      source = ".../vim/lsp/rpc.lua:770",
      body = [[
rpc
/usr/local/bin/node
stderr
node:fs:563
  return binding.open(
                 ^

Error: ENOENT: no such file or directory, open ''
    at Object.openSync (node:fs:563:18)
    at readFileSync (node:fs:447:35)
    at getDict (/Users/eetann/ghq/github.com/eetann/markdown-language-server/packages/server/dist/index.cjs:36721:51)
    at InstanceCreator.initialize (/Users/eetann/ghq/github.com/eetann/markdown-language-server/packages/server/dist/index.cjs:37082:25) {
  errno: -2,
  code: 'ENOENT',
  syscall: 'open',
  path: ''
}

Node.js v23.6.1
]],
    }
    assert.are.same(expected, result)
  end)
end)
