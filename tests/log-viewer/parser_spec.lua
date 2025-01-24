local Parser = require("log-viewer.domain.parser")

describe("parser", function()
  local parser = Parser:new()
  it("capture", function()
    local content = "[START][2025-01-24 13:09:06] LSP logging initiated"
    local result = parser:capture(content)
    assert.equal("foo", result)
  end)
end)
