-- Utils.lua
-- Shared utility functions
-- Place in ReplicatedStorage

local Utils = {}

-- Format large numbers with commas
function Utils.FormatNumber(number)
	local formatted = tostring(number)
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

-- Shorten large numbers (1000 -> 1K, 1000000 -> 1M)
function Utils.ShortenNumber(number)
	local suffixes = {"", "K", "M", "B", "T", "Q"}
	local suffixIndex = 1
	
	while number >= 1000 and suffixIndex < #suffixes do
		number = number / 1000
		suffixIndex = suffixIndex + 1
	end
	
	return string.format("%.1f%s", number, suffixes[suffixIndex])
end

-- Lerp between two numbers
function Utils.Lerp(a, b, t)
	return a + (b - a) * t
end

-- Clamp a value between min and max
function Utils.Clamp(value, min, max)
	return math.max(min, math.min(max, value))
end

-- Check if a player is alive
function Utils.IsPlayerAlive(player)
	local character = player.Character
	if not character then return false end
	
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return false end
	
	return humanoid.Health > 0
end

-- Get distance between two positions
function Utils.GetDistance(pos1, pos2)
	return (pos1 - pos2).Magnitude
end

-- Wait for child with timeout
function Utils.WaitForChildWithTimeout(parent, childName, timeout)
	local startTime = tick()
	while not parent:FindFirstChild(childName) do
		if tick() - startTime > timeout then
			return nil
		end
		wait(0.1)
	end
	return parent:FindFirstChild(childName)
end

return Utils
