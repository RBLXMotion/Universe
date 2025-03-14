-- @ScriptType: ModuleScript

local dependencies = script.Parent:WaitForChild("Dependencies")
local Spr = require(dependencies:WaitForChild("Spr"))

local Media = require(script:WaitForChild("Media"))

type IslandSize = "Small" | "Large" | "Square"

local Island = {}
Island.__index = Island

function Island.new(notificationDuration: number)
	local self = setmetatable({}, Island)
	
	self.Frame = Instance.new("CanvasGroup")
	self.Frame.Name = "Island"
	self.Frame.AnchorPoint = Vector2.new(.5,0)
	self.Frame.Position = UDim2.new(.5,0,.015,0)
	self.Frame.Size = UDim2.new(.375,0,.06,0)
	self.Frame.ZIndex = 200
	self.Frame.BackgroundColor3 = Color3.new(0,0,0)
	
	self.IslandCorner = Instance.new("UICorner", self.Frame)
	self.IslandCorner.CornerRadius = UDim.new(1,0)
	
	self.NotificationDuration = notificationDuration or 2
	
	return self
end

function Island:Notify(app, title: string, description: string, imageId: string, islandSize: IslandSize)
	if islandSize == "Large" then
		local completed = false
		
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.95,0,.2,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(.25,0)})
		task.wait(self.NotificationDuration)
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.375,0,.06,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(1,0)})
		
		Spr.completed(self.Frame, function()
			completed = true
		end)
		
		repeat task.wait() until completed
	elseif islandSize == "Small" then
		local completed = false
		
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.85,0,.06,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(1,0)})
		task.wait(self.NotificationDuration)
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.375,0,.06,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(1,0)})
		
		Spr.completed(self.Frame, function()
			completed = true
		end)

		repeat task.wait() until completed
	elseif islandSize == "Square" then
		local completed = false
		
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.375,0,.175,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(.25,0)})
		task.wait(self.NotificationDuration)
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.375,0,.06,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(1,0)})
		
		Spr.completed(self.Frame, function()
			completed = true
		end)

		repeat task.wait() until completed
	end
end

function Island:AddMedia()
	local media = Media.new()
end

return Island
