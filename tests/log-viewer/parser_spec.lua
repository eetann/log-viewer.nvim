local Parser = require("log-viewer.domain.parser")

describe("parser", function()
  local parser = Parser:new()
  it("capture", function()
    local content = "[START][2025-01-24 13:09:06] LSP logging initiated"
    local result = parser:capture(content)
    local expected = { "START", "2025-01-24", "13:09:06", "LSP logging initiated" }
    assert.are.same(expected, { table.unpack(result, 1, 4) })
  end)
end)
