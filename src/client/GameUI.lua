-- GameUI.lua
-- Client-side UI controller
-- Place in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local GameUI = {}

function GameUI:Initialize()
	print("Game UI Initialized for " .. Player.Name)
	self:CreateMainUI()
	self:UpdateUI()
end

function GameUI:CreateMainUI()
	-- Create ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "GameUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = PlayerGui
	
	-- Create coin counter
	local coinFrame = Instance.new("Frame")
	coinFrame.Name = "CoinFrame"
	coinFrame.Size = UDim2.new(0, 200, 0, 60)
	coinFrame.Position = UDim2.new(0, 10, 0, 10)
	coinFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	coinFrame.BorderSizePixel = 0
	coinFrame.Parent = screenGui
	
	-- Add corner radius
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = coinFrame
	
	-- Coin icon (emoji)
	local coinIcon = Instance.new("TextLabel")
	coinIcon.Name = "CoinIcon"
	coinIcon.Size = UDim2.new(0, 50, 1, 0)
	coinIcon.Position = UDim2.new(0, 5, 0, 0)
	coinIcon.BackgroundTransparency = 1
	coinIcon.Text = "🪙"
	coinIcon.TextSize = 30
	coinIcon.Parent = coinFrame
	
	-- Coin text
	local coinText = Instance.new("TextLabel")
	coinText.Name = "CoinText"
	coinText.Size = UDim2.new(1, -60, 1, 0)
	coinText.Position = UDim2.new(0, 55, 0, 0)
	coinText.BackgroundTransparency = 1
	coinText.Text = "0 Coins"
	coinText.TextColor3 = Color3.fromRGB(255, 255, 255)
	coinText.TextSize = 24
	coinText.Font = Enum.Font.GothamBold
	coinText.TextXAlignment = Enum.TextXAlignment.Left
	coinText.Parent = coinFrame
	
	-- Game status label
	local statusLabel = Instance.new("TextLabel")
	statusLabel.Name = "StatusLabel"
	statusLabel.Size = UDim2.new(0, 300, 0, 40)
	statusLabel.Position = UDim2.new(0.5, -150, 0, 10)
	statusLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	statusLabel.BorderSizePixel = 0
	statusLabel.Text = "Welcome to the Game!"
	statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	statusLabel.TextSize = 20
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.Parent = screenGui
	
	local statusCorner = Instance.new("UICorner")
	statusCorner.CornerRadius = UDim.new(0, 10)
	statusCorner.Parent = statusLabel
	
	self.ScreenGui = screenGui
end

function GameUI:UpdateUI()
	spawn(function()
		local coinText = self.ScreenGui.CoinFrame.CoinText
		
		while true do
			wait(0.1)
			
			if Player.leaderstats and Player.leaderstats.Coins then
				local coins = Player.leaderstats.Coins.Value
				coinText.Text = coins .. " Coins"
			end
		end
	end)
end

function GameUI:ShowMessage(message, duration)
	local statusLabel = self.ScreenGui.StatusLabel
	statusLabel.Text = message
	
	if duration then
		wait(duration)
		statusLabel.Text = ""
	end
end

-- Initialize
GameUI:Initialize()

return GameUI
