-- @ScriptType: ModuleScript

local CONFIG = require(script.Parent.Parent:WaitForChild("CONFIG"))

local Dock = {}
Dock.__index = Dock

function Dock.new(homescreen: CanvasGroup)
	local self = setmetatable({}, Dock)

	local verticalPadding = .1
		
	self.Frame = Instance.new("Frame", homescreen)
	self.Frame.Position = UDim2.new(.5,0,1 - (CONFIG.DOCK_MARGIN + CONFIG.DOCK_SIZE.Y/2),0)
	self.Frame.Size = UDim2.new(CONFIG.DOCK_SIZE.X,0,CONFIG.DOCK_SIZE.Y,0)
	self.Frame.AnchorPoint = Vector2.new(.5,.5)
	self.Frame.Transparency = .3
	self.Frame.BackgroundColor3 = CONFIG.DOCK_COLOR
	
	self.Corner = Instance.new("UICorner", self.Frame)
	self.Corner.CornerRadius = CONFIG.DOCK_CORNER_RADIUS

	self.Apps = {}

	return self
end

return Dock
