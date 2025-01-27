local Record = require("log-viewer.domain.record")

describe("record", function()
  it("capture normal", function()
    local content = "[START][2025-01-24 13:09:06] LSP logging initiated"
    local result = Record:capture(content)
    local expected = { "START", "2025-01-24", "13:09:06", "LSP logging initiated" }
    assert.are.same(expected, { unpack(result, 1, 4) })
  end)

  it("incorrect strings", function()
    local content = "fooooooo"
    local result = Record:capture(content)
    local expected = vim.fn["repeat"]({ "" }, 9)
    assert.are.same(expected, result)
  end)

  it("empty", function()
    local content = ""
    local result = Record:capture(content)
    local expected = vim.fn["repeat"]({ "" }, 9)
    assert.are.same(expected, result)
  end)

  it("new", function()
    local content = "[START][2025-01-24 13:09:06] LSP logging initiated"
    local result = Record:new(content)
    local expected =
      { raw = content, level = "START", date = "2025-01-24", time = "13:09:06", message = "LSP logging initiated" }
    assert.are.same(expected, result)
  end)

  it("get_parsed_text", function()
    local content = "[START][2025-01-24 13:09:06] LSP logging initiated"
    local result = Record:new(content):get_parsed_text()
    local expected = [[
level = START
datetime = 2025-01-24 13:09:06
message = LSP logging initiated]]
    assert.are.same(expected, result)
  end)
end)
