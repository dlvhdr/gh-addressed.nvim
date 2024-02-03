-- All credit to https://github.com/f-person/lua-timeago

local language = {
  justnow = "now",
  minute = "m ago",
  hour = "h ago",
  day = "d ago",
  week = "w ago",
  month = "mo ago",
  year = "y ago",
}

local M = {}

---@param num number
---@return number
local function round(num)
  return math.floor(num + 0.5)
end

---@param time integer
---@return string
function M.format(time)
  local now = os.time(os.date("!*t"))
  local diff_seconds = os.difftime(now, time)
  if diff_seconds < 45 then
    return language.justnow
  end

  local diff_minutes = diff_seconds / 60
  if diff_minutes < 59.5 then
    return round(diff_minutes) .. language.minute
  end

  local diff_hours = diff_minutes / 60
  if diff_hours < 23.5 then
    return round(diff_hours) .. language.hour
  end

  local diff_days = diff_hours / 24
  if diff_days < 7.5 then
    return round(diff_days) .. language.day
  end

  local diff_weeks = diff_days / 7
  if diff_weeks < 4.5 then
    return round(diff_weeks) .. language.week
  end

  local diff_months = diff_days / 30
  if diff_months < 11.5 then
    return round(diff_months) .. language.month
  end

  local diff_years = diff_days / 365.25
  return round(diff_years) .. language.year
end

M.format_from_iso_date = function(date)
  local year, month, day, hour, min, sec = date:match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z")

  local timestamp = os.time({ year = year, month = month, day = day, hour = hour, min = min, sec = sec })
  return M.format(timestamp)
end

return M
