-- @ScriptType: ModuleScript
-- @ScriptType: ModuleScript

local Page = {}
Page.__index = Page

function Page.new(homescreen: CanvasGroup)
	local self = setmetatable({}, Page)

	self.Frame = Instance.new("Frame", homescreen)
	self.Frame.Position = UDim2.new(.5,0,.5,0)
	self.Frame.Size = UDim2.new(1,0,1,0)
	self.Frame.AnchorPoint = Vector2.new(.5,.5)
	self.Frame.Transparency = 1

	self.Apps = {}

	return self
end

return Page