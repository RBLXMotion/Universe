-- @ScriptType: ModuleScript

local Page = {}
Page.__index = Page

function Page.new(homescreen: CanvasGroup, islandInset: number, gestureInset: number)
	local self = setmetatable({}, Page)

	local verticalPadding = .1
	
	print(islandInset, gestureInset)
	
	self.Frame = Instance.new("Frame", homescreen)
	self.Frame.Position = UDim2.new(.5,0,.5,0)
	self.Frame.Size = UDim2.new(1,0,1,0)
	self.Frame.AnchorPoint = Vector2.new(.5,.5)
	self.Frame.Transparency = 1

	self.GridFrame = Instance.new("Frame", self.Frame)
	self.GridFrame.Position = UDim2.new(.5,0, (islandInset + verticalPadding/2), 0)
	self.GridFrame.Size = UDim2.new(.9,0, 1 - (islandInset + gestureInset + verticalPadding), 0)
	self.GridFrame.AnchorPoint = Vector2.new(.5,0)
	self.GridFrame.Transparency = 1

	self.Apps = {}

	return self
end

return Page
