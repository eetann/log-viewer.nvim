local DeleteLog = require("lsp-dev.usecase.delete_log")

describe("DeleteLog", function()
  it("parseDate", function()
    local content = [[
[START][2025-01-24 13:09:06] foo
[START][2077-07-07 19:00:00] bar
]]
    local result = DeleteLog:parse_date("2025-01-24", "13:09:06")
    local expected = {
      year = 2025,
      month = 1,
      day = 24,
      hour = 13,
      min = 9,
      sec = 6,
    }
    assert.is.same(expected, result)
  end)

  it("delete_lines", function()
    local content = [[
[START][2025-01-24 13:09:00] hello
[START][2025-01-24 13:09:06] foo
[START][2077-07-07 19:00:00] bar
]]
    local delete_end = os.date("*t") --[[@as osdate]]
    local result = DeleteLog:delete_lines(delete_end, content)
    local expected = "[START][2077-07-07 19:00:00] bar"
    assert.is.same(expected, result)
  end)
end)
