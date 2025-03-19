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

	self.PageDots = Instance.new("CanvasGroup", self.Button)
	self.PageDots.Size = UDim2.new(1,0,1,0)
	self.PageDots.Position = UDim2.new(.5,0,.5,0)
	self.PageDots.AnchorPoint = Vector2.new(.5,.5)
	self.PageDots.BackgroundTransparency = 1

	self.PageDotsButtonSize = UDim2.new(1/CONFIG.MAX_PAGES)
	
	return self
end

return InfoBar
