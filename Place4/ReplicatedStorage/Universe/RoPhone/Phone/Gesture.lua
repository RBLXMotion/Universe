-- @ScriptType: ModuleScript
-- @ScriptType: ModuleScript
-- @ScriptType: ModuleScript
local Gesture = {}
Gesture.__index = Gesture

function Gesture.new()
	local self = setmetatable({}, Gesture)
	
	self.Button = Instance.new("TextButton")
	self.Button.Name = "GestureBar"
	self.Button.AnchorPoint = Vector2.new(.5,.5)
	self.Button.Position = UDim2.new(.5,0,.98,0)
	self.Button.Size = UDim2.new(.6,0,.015,0)
	self.Button.ZIndex = 100
	self.Button.BackgroundColor3 = Color3.new(1,1,1)
	self.Button.Text = ""
	self.Button.AutoButtonColor = false
	
	self.Corner = Instance.new("UICorner", self.Button)
	self.Corner.CornerRadius = UDim.new(1,0)
	
	self.GestureClicked = self.Button.MouseButton1Click
	
	return self
end

return Gesture