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
      table.insert(qf_items, {
        filename = vim.fn.getcwd() .. "/" .. thread.path,
        lnum = startLine,
        end_lnum = startLine,
        type = comment.outdated and "W" or "I",
        text = string.format(
          "%s@%s (%s)%s\n  │  %s",
          (num_comments > 1 and "#" .. i .. " ") or "",
          comment.author.login,
          time_ago.format_from_iso_date(comment.updatedAt),
          comment.outdated and " [OUTDATED]" or "",
          comment.bodyText:gsub("\n", "\n  │  ")
        ),
      })
    end
  end

  local qfopts = {
    items = qf_items,
    title = "Comments",
  }
  vim.fn.setqflist({}, "r", qfopts)
  trouble.open("quickfix")
end

-- sort threads?
-- local threads = pr.reviewThreads.nodes
-- table.sort(threads, function(a, b)
--   vim.print("comparing", a.path, b.path)
--   if a.path == b.path then
--     return get_start_line(a) > get_start_line(b)
--   end
--   return a.path < b.path
-- end)
--
-- vim.print(threads)

return M
