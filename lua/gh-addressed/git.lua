local utils = require("gh-addressed.utils")

local M = {}

M.get_line_addressed_sha = function(file, lnum)
  local addressed_output = utils.run_job("git", {
    args = { "addressed", file, "-L" .. lnum .. ",+1", "--incremental" },
    cwd = vim.fn.expand("%:p:h"),
  }, "sync")

  local lines = vim.split(addressed_output, "\n")
  if #lines < 1 then
    return
  end
  return vim.split(lines[1], " ")[1]
end

return M
