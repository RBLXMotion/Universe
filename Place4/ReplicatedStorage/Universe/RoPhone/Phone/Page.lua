-- @ScriptType: ModuleScript

local CONFIG = require(script.Parent.Parent:WaitForChild("CONFIG"))

local Page = {}
Page.__index = Page

function Page.new(homescreen: CanvasGroup)
	local self = setmetatable({}, Page)
		
	self.Frame = Instance.new("Frame", homescreen)
	self.Frame.Position = UDim2.new(.5,0,.5,0)
	self.Frame.Size = UDim2.new(1,0,1,0)
	self.Frame.AnchorPoint = Vector2.new(.5,.5)
	self.Frame.Transparency = 1

	self.GridFrame = Instance.new("Frame", self.Frame)
	self.GridFrame.Position = UDim2.new(.5,0, (CONFIG.ISLAND_SIZE.Y + CONFIG.ISLAND_MARGIN), 0)
	self.GridFrame.Size = UDim2.new(.9,0, 1 - (CONFIG.ISLAND_SIZE.Y + CONFIG.ISLAND_MARGIN + CONFIG.GESTURE_SIZE.Y + CONFIG.GESTURE_MARGIN + CONFIG.DOCK_SIZE.Y + CONFIG.DOCK_MARGIN + CONFIG.PAGE_DOT_SIZE.Y), 0)
	self.GridFrame.AnchorPoint = Vector2.new(.5,0)
	self.GridFrame.Transparency = 1

	self.Apps = {}

	return self
end

return Page
