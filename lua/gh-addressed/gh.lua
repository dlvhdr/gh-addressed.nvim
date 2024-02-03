local utils = require("gh-addressed.utils")
local Job = require("plenary.job")

local M = {}

function M.run(opts)
  if not Job then
    return
  end
  opts = opts or {}
  local mode = opts.mode or "async"
  if opts.headers then
    for _, header in ipairs(opts.headers) do
      table.insert(opts.args, "-H")
      table.insert(opts.args, header)
    end
  end
  return utils.run_job("gh", opts, mode)
end

---@return string | nil
M.get_pr_url = function()
  local data = M.run({
    args = { "pr", "view", "--json", "url", "-q", ".url" },
    mode = "sync",
  })

  if data == nil or data == "" then
    return nil
  end

  return tostring(data)
end

---@return string | nil
M.get_repo_name_with_owner = function()
  return M.run({
    args = { "repo", "view", "--json", "nameWithOwner", "-q", ".nameWithOwner" },
    mode = "sync",
  })
end

M.open_pr_popup = function(pr)
  vim.notify("Got PR with " .. #pr.reviewThreads.nodes .. " threads", vim.log.levels.INFO, { title = "GhAddressed" })
end

M.get_pr_comments = function(url)
  local query = [[
query ReviewThreads($url: URI!) {
  resource(url: $url) {
    ... on PullRequest {
      id
      reviewThreads(last: 50) {
        totalCount
        nodes {
          id
          isOutdated
          originalLine
          startLine
          line
          path
          comments(first: 50, ) {
            nodes {
              author {
								login
              }
              bodyText
              startLine
              outdated
              updatedAt
              diffHunk
              line
            }
          }
        }
      }
    }
  }
}
]]

  local res = M.run({
    args = { "api", "graphql", "-f", "query=" .. query, "-f", "url=" .. url },
    mode = "sync",
  })
  if res == nil then
    return nil
  end

  -- parse json results
  local json = vim.fn.json_decode(res)

  if
    json == nil
    or json.data == nil
    or json.data.resource == nil
    or json.data.resource.reviewThreads == nil
    or json.data.resource.reviewThreads.nodes == nil
  then
    return nil
  end

  return json.data.resource
end

return M
