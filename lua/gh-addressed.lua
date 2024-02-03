local gh = require("gh-addressed.gh")
local trouble = require("gh-addressed.trouble")

---@class Config
local config = {}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.list_pr_comments = function()
  vim.notify("Fetching PR comments...", vim.log.levels.INFO, {
    title = "GhAddressed",
  })

  vim.schedule(function()
    GITHUB_TOKEN = vim.env["GITHUB_TOKEN"]

    local url = gh.get_pr_url()
    if url == nil then
      -- TODO: print branch name
      vim.notify("No PR found", vim.log.levels.WARN, { title = "GhAddressed" })
      return
    end

    local pr = gh.get_pr_comments(url)
    trouble.open_comments(pr)
  end)
end

return M
