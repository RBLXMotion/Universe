-- @ScriptType: ModuleScript

local CONFIG = require(script.Parent.Parent.Parent:WaitForChild("CONFIG"))

local Spring = require(script.Parent.Parent:WaitForChild("Spring"))

local InfoBar = {}
InfoBar.__index = InfoBar

function InfoBar.new()
	local self = setmetatable({}, InfoBar)
	
	self.Button = Instance.new("TextButton")
	self.Button.Size = UDim2.new(CONFIG.INFO_BAR_SIZE.X, 0, CONFIG.INFO_BAR_SIZE.Y, 0)
	self.Button.Position = UDim2.new(.5,0, 1 - (CONFIG.DOCK_MARGIN + CONFIG.DOCK_SIZE.Y + CONFIG.INFO_BAR_MARGIN + CONFIG.INFO_BAR_SIZE.Y/2),0)
	self.Button.AnchorPoint = Vector2.new(.5,.5)
	self.Button.BackgroundTransparency = .3
	self.Button.BackgroundColor3 = CONFIG.DOCK_COLOR
	self.Button.AutoButtonColor = false
	self.Button.Text = ""
	
	self.Corner = Instance.new("UICorner", self.Button)
	self.Corner.CornerRadius = UDim.new(1,0)
	
	self.PageDots = Instance.new("CanvasGroup", self.Button)
	self.PageDots.Size = UDim2.new(1,0,1,0)
	self.PageDots.Position = UDim2.new(.5,0,.5,0)
	self.PageDots.AnchorPoint = Vector2.new(.5,.5)
	self.PageDots.BackgroundTransparency = 1
	
	self.Dots = {}
	
	self.DotsContainerSize = UDim2.new((CONFIG.INFO_BAR_SIZE.X + (.2 * CONFIG.INFO_BAR_SIZE.X)) * CONFIG.INFO_BAR_SIZE.X + CONFIG.DOT_SPACING,0,CONFIG.INFO_BAR_SIZE.Y,0)
	
	return self
end

function InfoBar:AddPageDot()
	local newDot = Instance.new("TextButton", self.PageDots)
	newDot.Size = UDim2.new(.2,0,.5,0)
	newDot.AnchorPoint = Vector2.new(.5,.5)
	newDot.BackgroundColor3 = Color3.new(1,1,1)
	newDot.Text = ""
	newDot.AutoButtonColor = false

	local corner = Instance.new("UICorner", newDot)
	corner.CornerRadius = UDim.new(1,0)

	local ratio = Instance.new("UIAspectRatioConstraint", newDot)
	ratio.AspectRatio = 1

	table.insert(self.Dots, newDot)

	for i, v in ipairs(self.Dots) do
		local initialPosX = 0
		
		for j, k in ipairs(self.Dots) do
			initialPosX = k.Size.X.Scale * (j - 1)
		end
		
		local finalPos = UDim2.new(self.Button.Position.X.Scale - initialPosX,0,.5,0)

		local posSpring = Spring.new(newDot, 1.2, 3, {Position = finalPos})
		posSpring:Play()

		local barSpring = Spring.new(self.Button, 1.2, 3, {Size = self.DotsContainerSize})
		barSpring:Play()
	end
end

return InfoBar
