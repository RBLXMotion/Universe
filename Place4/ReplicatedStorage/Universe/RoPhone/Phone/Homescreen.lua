-- @ScriptType: ModuleScript

local CONFIG = require(script.Parent.Parent:WaitForChild("CONFIG"))
local Spring = require(script.Parent:WaitForChild("Spring"))

local dependencies = script.Parent:WaitForChild("Dependencies")
local Grid = require(dependencies:WaitForChild("Grid"))
local Signal = require(dependencies:WaitForChild("GoodSignal"))

local Page = require(script:WaitForChild("Page"))
local Dock = require(script:WaitForChild("Dock"))
local InfoBar = require(script:WaitForChild("InfoBar"))

local Homescreen = {}
Homescreen.__index = Homescreen

function Homescreen.new()
	local self = setmetatable({}, Homescreen)

	self.Frame = Instance.new("CanvasGroup")
	self.Frame.Name = "Homescreen"
	self.Frame.AnchorPoint = Vector2.new(.5,.5)
	self.Frame.Position = UDim2.new(.5,0,.5,0)
	self.Frame.Size = UDim2.new(1,0,1,0)
	self.Frame.BackgroundTransparency = 1
	
	self.Background = Instance.new("ImageLabel", self.Frame)
	self.Background.Name = "Background"
	self.Background.AnchorPoint = Vector2.new(.5,.5)
	self.Background.Position = UDim2.new(.5,0,.5,0)
	self.Background.Size = UDim2.new(2,0,1,0)
	self.Background.ScaleType = Enum.ScaleType.Crop
	self.Background.Image = "rbxassetid://"..CONFIG.WALLPAPER_ID
	
	self.Dock = Dock.new()
	self.Dock.Frame.Parent = self.Frame
	self.Dock.ButtonsFrame.Parent = self.Frame
	
	self.InfoBar = InfoBar.new()
	self.InfoBar.Button.Parent = self.Frame

	self.Pages = {} :: {[number]: {["Page"]: typeof(Page.new()), ["Grid"]: typeof(Grid.new())}}
	self.PageAdded = Signal.new()
	
	self.AppButtonAdded = Signal.new()
	self.AppButtonDocked = Signal.new()

	return self
end

function Homescreen:AddPage()
	local page = Page.new()
	page.Frame.Parent = self.Frame
	
	local index = #self.Pages + 1
	
	self.Pages[index] = page
	
	self.InfoBar:AddPageDot()
	
	self.PageAdded:Fire(self.Pages[index])
end

function Homescreen:AddAppButton(appButton: GuiButton)
	local page = self.Pages[#self.Pages]
	
	local added = page:AddAppButton(appButton)
	
	if not added then
		self:AddPage()
		self:AddAppButton(appButton)
		return
	end
	
	self.AppButtonAdded:Fire(appButton)
	
	appButton.MouseButton2Click:Once(function()
		local originalSize = appButton.Size
		local originalPos = appButton.Position
		
		local added = self.Dock:AddAppButton(appButton)
		
		if added then
			page:RemoveAppButton(appButton)

			self.AppButtonDocked:Fire(appButton)
			return true
		end
		
		appButton.Size = originalSize
		appButton.Position = originalPos
		
		return false
	end)
end

return Homescreen
