-- CoinSpawner.lua
-- Spawns collectible coins in the game world
-- Place in ServerScriptService

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local CoinSpawner = {}
CoinSpawner.Coins = {}

-- Configuration
local SPAWN_INTERVAL = 5 -- seconds
local MAX_COINS = 20
local COIN_VALUE = 10
local SPAWN_AREA = {
	Min = Vector3.new(-100, 5, -100),
	Max = Vector3.new(100, 5, 100)
}

function CoinSpawner:Initialize()
	print("Coin Spawner Initialized")
	self:StartSpawning()
end

function CoinSpawner:CreateCoin(position)
	-- Create coin part
	local coin = Instance.new("Part")
	coin.Name = "Coin"
	coin.Size = Vector3.new(2, 2, 0.5)
	coin.Position = position
	coin.Anchored = true
	coin.CanCollide = false
	coin.BrickColor = BrickColor.new("Bright yellow")
	coin.Material = Enum.Material.Neon
	coin.Shape = Enum.PartType.Cylinder
	
	-- Add rotation
	coin.Orientation = Vector3.new(0, 0, 90)
	
	-- Add sparkles effect
	local sparkle = Instance.new("Sparkles")
	sparkle.Parent = coin
	
	-- Touch detection
	coin.Touched:Connect(function(hit)
		self:OnCoinTouched(coin, hit)
	end)
	
	coin.Parent = Workspace
	table.insert(self.Coins, coin)
	
	return coin
end

function CoinSpawner:OnCoinTouched(coin, hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	
	if player and coin.Parent then
		-- Award coins to player
		if player.leaderstats and player.leaderstats.Coins then
			player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + COIN_VALUE
			
			-- Remove coin
			coin:Destroy()
			
			-- Remove from table
			for i, c in pairs(self.Coins) do
				if c == coin then
					table.remove(self.Coins, i)
					break
				end
			end
			
			print(player.Name .. " collected a coin! Total: " .. player.leaderstats.Coins.Value)
		end
	end
end

function CoinSpawner:GetRandomPosition()
	local x = math.random(SPAWN_AREA.Min.X, SPAWN_AREA.Max.X)
	local y = math.random(SPAWN_AREA.Min.Y, SPAWN_AREA.Max.Y)
	local z = math.random(SPAWN_AREA.Min.Z, SPAWN_AREA.Max.Z)
	
	return Vector3.new(x, y, z)
end

function CoinSpawner:StartSpawning()
	spawn(function()
		while true do
			wait(SPAWN_INTERVAL)
			
			-- Clean up destroyed coins
			for i = #self.Coins, 1, -1 do
				if not self.Coins[i].Parent then
					table.remove(self.Coins, i)
				end
			end
			
			-- Spawn new coins if under max
			if #self.Coins < MAX_COINS then
				local position = self:GetRandomPosition()
				self:CreateCoin(position)
			end
		end
	end)
end

-- Initialize
CoinSpawner:Initialize()

return CoinSpawner
