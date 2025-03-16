-- @ScriptType: ModuleScript

local dependencies = script.Parent:WaitForChild("Dependencies")
local Spr = require(dependencies:WaitForChild("Spr"))

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
	
	self.Container = Instance.new("CanvasGroup", self.Frame)
	self.Container.Name = "Notification"
	self.Container.AnchorPoint = Vector2.new(.5,.5)
	self.Container.Position = UDim2.new(.5,0,.5,0)
	self.Container.Size = UDim2.new(1,0,1,0)
	self.Container.GroupTransparency = 1
	self.Container.BackgroundTransparency = 1
	self.Container.Visible = false
	
	self.IslandCorner = Instance.new("UICorner", self.Frame)
	self.IslandCorner.CornerRadius = UDim.new(1,0)
	
	self.Title = Instance.new("TextLabel", self.Container)
	self.Title.Name = "Title"
	self.Title.AnchorPoint = Vector2.new(0,.5)
	self.Title.BackgroundTransparency = 1
	self.Title.TextColor3 = Color3.new(1,1,1)
	self.Title.TextScaled = false
	self.Title.TextXAlignment = Enum.TextXAlignment.Left
	self.Title.TextSize = 14
	self.Title.Font = Enum.Font.BuilderSansBold
	
	self.Description = Instance.new("TextLabel", self.Container)
	self.Description.Name = "Description"
	self.Description.AnchorPoint = Vector2.new(0,.5)
	self.Description.BackgroundTransparency = 1
	self.Description.TextColor3 = Color3.new(.9,.9,.9)
	self.Description.TextScaled = false
	self.Description.TextXAlignment = Enum.TextXAlignment.Left
	self.Description.TextSize = 10
	self.Description.Font = Enum.Font.BuilderSans
	
	self.Icon = Instance.new("ImageLabel", self.Container)
	self.Icon.Name = "Icon"
	self.Icon.AnchorPoint = Vector2.new(.5,.5)
	self.Icon.BackgroundColor3 = Color3.new(1,1,1)
	self.Icon.ScaleType = Enum.ScaleType.Fit
	
	self.IconRatio = Instance.new("UIAspectRatioConstraint", self.Icon)
	self.IconRatio.AspectRatio = 1
	
	self.IconCorner = Instance.new("UICorner", self.Icon)
	self.IconCorner.CornerRadius = UDim.new(.2,0)
	
	self.Click = Instance.new("TextButton", self.Frame)
	self.Click.Name = "Click"
	self.Click.Transparency = 1
	self.Click.AnchorPoint = Vector2.new(.5,.5)
	self.Click.Position = UDim2.new(.5,0,.5,0)
	self.Click.Size = UDim2.new(1,0,1,0)
	self.Click.Visible = false
	
	self.NotificationDuration = notificationDuration or 2
	
	self.Complete = true
	
	return self
end

function Island:Notify(app, title: string, description: string, imageId: number, islandSize: IslandSize, durationOverride: number?)
	if self.Completed == false then
		repeat task.wait() until self.Completed
	end
	
	self.Completed = false
	
	self.Icon.Image = "rbxassetid://"..imageId
	self.Title.Text = title
	self.Description.Text = description
	
	self.Click.Visible = true

	self.Click.MouseButton1Click:Connect(function()
		if not self.Completed then
			app:OpenApp()
		end
	end)
	
	self.Container.GroupTransparency = 1
	self.Container.Visible = true
	
	self.Icon.Visible = true
	self.Title.Visible = true
	self.Description.Visible = true
	
	if islandSize == "Large" then
		self.Icon.Size = UDim2.new(.2,0,.8,0)
		self.Icon.Position = UDim2.new(self.Icon.Size.X.Scale/2 + .05,0,.5,0)
		
		self.Title.Size = UDim2.new(.7,0,.4,0)
		self.Title.Position = UDim2.new(self.Icon.Position.X.Scale + (self.Icon.Size.X.Scale/2) + .05,0,.25,0)
		self.Title.TextYAlignment = Enum.TextYAlignment.Bottom
		
		self.Description.Size = UDim2.new(.7,0,.4,0)
		self.Description.Position = UDim2.new(self.Icon.Position.X.Scale + (self.Icon.Size.X.Scale/2) + .05,0,.75,0)
		self.Description.TextYAlignment = Enum.TextYAlignment.Top
		
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.95,0,.2,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(.25,0)})
		Spr.target(self.Container, 1, 4, {GroupTransparency = 0})
	elseif islandSize == "Small" then
		self.Icon.Size = UDim2.new(.2,0,.8,0)
		self.Icon.Position = UDim2.new(self.Icon.Size.X.Scale/2 + .05,0,.5,0)

		self.Title.Position = UDim2.new(self.Icon.Position.X.Scale + self.Icon.Size.X.Scale/2 + .05,0,.5,0)
		self.Title.Size = UDim2.new(.7,0,.8,0)
		self.Title.TextYAlignment = Enum.TextYAlignment.Center

		self.Description.Visible = false
		
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.85,0,.06,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(1,0)})
		Spr.target(self.Container, 1, 4, {GroupTransparency = 0})
	elseif islandSize == "Square" then
		self.Icon.Position = UDim2.new(.5,0,.5,0)
		self.Icon.Size = UDim2.new(.8,0,.8,.0)

		self.Title.Visible = false
		self.Description.Visible = false
		
		Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.375,0,.175,0)})
		Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(.25,0)})
		Spr.target(self.Container, 1, 4, {GroupTransparency = 0})
	end
	
	task.wait(durationOverride or self.NotificationDuration)
	
	self.Click.Visible = false
	
	Spr.target(self.Frame, .75, 4, {Size = UDim2.new(.375,0,.06,0)})
	Spr.target(self.IslandCorner, 1, 4, {CornerRadius = UDim.new(1,0)})
	Spr.target(self.Container, 1, 4, {GroupTransparency = 1})

	Spr.completed(self.Frame, function()
		self.Completed = true
		self.Container.Visible = false
	end)

	repeat task.wait() until self.Completed
end

return Island
