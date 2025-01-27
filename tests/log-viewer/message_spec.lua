local Message = require("log-viewer.domain.message")

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

  it("new normal", function()
    local text =
      [[.../vim/lsp/rpc.lua:408	"rpc.receive"	{  id = 5,  jsonrpc = "2.0",  method = "workspace/workspaceFolders"}]]
    local result = Message:new(text)
    local expected = {
      kind = "rpc.receive",
      source = ".../vim/lsp/rpc.lua:408",
      body = vim.inspect([[{  id = 5,  jsonrpc = "2.0",  method = "workspace/workspaceFolders"}]]),
    }
    assert.are.same(expected, result)
  end)

  it("new other kind with source", function()
    local text = [[...lsp/handlers.lua:627	"File created: foo.md"]]
    local result = Message:new(text)
    local expected = {
      kind = "other",
      source = "...lsp/handlers.lua:627",
      body = "File created: foo.md",
    }
    assert.are.same(expected, result)
  end)

  it("new other kind without source", function()
    local text = "LSP logging initiated"
    local result = Message:new(text)
    local expected = {
      kind = "other",
      source = "",
      body = text,
    }
    assert.are.same(expected, result)
  end)
end)
