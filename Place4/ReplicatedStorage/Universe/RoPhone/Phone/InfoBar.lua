-- @ScriptType: ModuleScript

local CONFIG = require(script.Parent.Parent:WaitForChild("CONFIG"))

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
	
	return self
end

return InfoBar
