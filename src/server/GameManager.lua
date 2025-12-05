-- GameManager.lua
-- Main server-side game manager
-- Place in ServerScriptService

local GameManager = {}
GameManager.GameState = "Waiting" -- States: Waiting, Playing, Ended

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local MIN_PLAYERS = 1
local GAME_LENGTH = 300 -- 5 minutes in seconds

function GameManager:Initialize()
	print("Game Manager Initialized")
	self:SetupPlayerEvents()
	self:StartGameLoop()
end

function GameManager:SetupPlayerEvents()
	Players.PlayerAdded:Connect(function(player)
		self:OnPlayerJoined(player)
	end)
	
	Players.PlayerRemoving:Connect(function(player)
		self:OnPlayerLeft(player)
	end)
end

function GameManager:OnPlayerJoined(player)
	print(player.Name .. " has joined the game!")
	
	-- Create leaderstats
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 0
	coins.Parent = leaderstats
	
	local level = Instance.new("IntValue")
	level.Name = "Level"
	level.Value = 1
	level.Parent = leaderstats
	
	-- Check if we can start the game
	if #Players:GetPlayers() >= MIN_PLAYERS and self.GameState == "Waiting" then
		self:StartGame()
	end
end

function GameManager:OnPlayerLeft(player)
	print(player.Name .. " has left the game!")
end

function GameManager:StartGameLoop()
	while true do
		self.GameState = "Waiting"
		print("Waiting for players...")
		
		-- Wait for minimum players
		while #Players:GetPlayers() < MIN_PLAYERS do
			wait(1)
		end
		
		self:StartGame()
		
		-- Game duration
		wait(GAME_LENGTH)
		
		self:EndGame()
	end
end

function GameManager:StartGame()
	self.GameState = "Playing"
	print("Game Started!")
	
	-- Notify all players
	for _, player in pairs(Players:GetPlayers()) do
		-- You can fire remote events here to update client UI
	end
end

function GameManager:EndGame()
	self.GameState = "Ended"
	print("Game Ended!")
	
	-- Determine winner
	local winner = self:GetWinner()
	if winner then
		print("Winner: " .. winner.Name)
	end
	
	wait(5) -- Brief pause before restarting
end

function GameManager:GetWinner()
	local players = Players:GetPlayers()
	local highestCoins = 0
	local winner = nil
	
	for _, player in pairs(players) do
		if player.leaderstats and player.leaderstats.Coins.Value > highestCoins then
			highestCoins = player.leaderstats.Coins.Value
			winner = player
		end
	end
	
	return winner
end

-- Initialize the game manager
GameManager:Initialize()

return GameManager
