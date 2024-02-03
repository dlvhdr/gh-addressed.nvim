local M = {}

local time_ago = require("gh-addressed.time-ago")
local trouble = require("trouble")

local function get_start_line(thread)
  local startLine = thread.startLine
  if startLine == vim.NIL then
    startLine = thread.line
  end
  if startLine == vim.NIL then
    startLine = thread.originalLine
  end
  if startLine == vim.NIL then
    startLine = 1
  end

  return startLine
end

M.open_comments = function(pr)
  local qf_items = {}

  for _, thread in ipairs(pr.reviewThreads.nodes) do
    local startLine = get_start_line(thread)
    local num_comments = #thread.comments.nodes

    for i, comment in ipairs(thread.comments.nodes) do
      local item = {
        filename = vim.fn.getcwd() .. "/" .. thread.path,
        lnum = startLine,
        end_lnum = startLine,
        col = i,
        type = comment.outdated and "W" or "I",
        text = string.format(
          "%s@%s (%s)%s\n  │  %s",
          (num_comments > 1 and "#" .. i .. " ") or "",
          comment.author.login,
          time_ago.format_from_iso_date(comment.updatedAt),
          comment.outdated and " [OUTDATED]" or "",
          comment.bodyText:gsub("\n", "\n  │  ")
        ),
      }
      table.insert(qf_items, item)
    end
  end
  table.sort(qf_items, function(a, b)
    if a.filename == b.filename and a.lnum == b.lnum then
      return a.text < b.text
    end
    if a.filename == b.filename then
      return a.lnum < b.lnum
    end

    return a.filename < b.filename
  end)

  local qfopts = {
    items = qf_items,
    title = "Comments",
  }
  vim.fn.setqflist({}, "r", qfopts)
  trouble.open("quickfix")
end

return M
