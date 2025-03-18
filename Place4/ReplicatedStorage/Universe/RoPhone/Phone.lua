-- @ScriptType: ModuleScript

-- TYPES
type PhoneSettings = {
	Size: UDim2,
	Position: UDim2,
	AnchorPoint: Vector2,
	CornerRadius: UDim,
	AspectRatio: number,
	PhoneColor: Color3,
	CaseThickness: number,
	PowerColor: Color3,
	VolumeColor: Color3,
}

-- VARIABLES
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local CONFIG = require(script.Parent:WaitForChild("CONFIG"))

local Page = require(script:WaitForChild("Page"))
local App = require(script:WaitForChild("App"))
local Island = require(script:WaitForChild("Island"))
local Gesture = require(script:WaitForChild("Gesture"))
local Volume = require(script:WaitForChild("Volume"))

local defaultApps = script:WaitForChild("DefaultApps")

local OS = {}

local dependencies = script:WaitForChild("Dependencies")
local Spr = require(dependencies:WaitForChild("Spr"))
local Grid = require(dependencies:WaitForChild("Grid"))
local Signal = require(dependencies:WaitForChild("GoodSignal"))

local viewport = Workspace.CurrentCamera.ViewportSize

-- FUNCTIONS
function OS.Initialize(player: Player, phoneSettings: PhoneSettings?, dataRemote: RemoteEvent?)	

	defaultApps.Parent = player.PlayerScripts

	-- Create a settings table
	if phoneSettings == nil then
		phoneSettings = {
			Size = CONFIG.SIZE,
			Position = CONFIG.POSITION,
			AnchorPoint = CONFIG.ANCHOR_POINT,
			CornerRadius = CONFIG.CORNER_RADIUS,
			AspectRatio = CONFIG.ASPECT_RATIO,
			PhoneColor = CONFIG.PHONE_COLOR,
			CaseThickness = CONFIG.CASE_THICKNESS,
			PowerColor = CONFIG.POWER_COLOR,
			VolumeColor = CONFIG.VOLUME_COLOR
		}
	end

	OS.Player = player
	OS.DataRemote = dataRemote or nil

	-- Create phone GUI
	OS.Gui = Instance.new("ScreenGui", player.PlayerGui)
	OS.Gui.Name = "PhoneGui"
	OS.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- Manage added sound instances
	OS.Gui.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("Sound") then
			descendant.Volume = OS.Volume.Level
			table.insert(OS.Volume.Instances, descendant)
		end
	end)

	-- Set up phone frame (case)
	OS.Frame = Instance.new("Frame", OS.Gui)
	OS.Frame.Name = "PhoneFrame"

	OS.Frame.Size = phoneSettings.Size
	OS.Frame.Position = phoneSettings.Position
	OS.Frame.AnchorPoint = phoneSettings.AnchorPoint
	OS.Frame.BackgroundColor3 = phoneSettings.PhoneColor

	OS.FrameCorner = Instance.new("UICorner", OS.Frame)
	OS.FrameCorner.CornerRadius = phoneSettings.CornerRadius

	OS.FrameRatio = Instance.new("UIAspectRatioConstraint", OS.Frame)
	OS.FrameRatio.AspectRatio = phoneSettings.AspectRatio

	OS.FrameThick = Instance.new("UIStroke", OS.Frame)
	OS.FrameThick.Thickness = phoneSettings.CaseThickness
	OS.FrameThick.Color = phoneSettings.PhoneColor
	
	-- Set up volume and power buttons
	OS.Volume = Volume.new(CONFIG.DEFAULT_VOLUME)
	OS.Volume.ButtonUp.Parent = OS.Frame
	OS.Volume.ButtonDown.Parent = OS.Frame
		
	local posX = (phoneSettings.CaseThickness/OS.Gui.AbsoluteSize.X) / OS.Frame.Size.X.Scale
	
	OS.Volume.ButtonUp.AnchorPoint = Vector2.new(.5,.5)
	OS.Volume.ButtonUp.Position = UDim2.new(1+posX,0,.25,0)
	OS.Volume.ButtonUp.Size = UDim2.new(posX,0,0.1,0)
	OS.Volume.ButtonUp.BackgroundColor3 = phoneSettings.VolumeColor
	OS.Volume.ButtonUp.Text = ""
	
	local cornerUp = Instance.new("UICorner", OS.Volume.ButtonUp)
	cornerUp.CornerRadius = UDim.new(1,0)

	OS.Volume.ButtonDown.AnchorPoint = Vector2.new(.5,.5)
	OS.Volume.ButtonDown.Position = UDim2.new(1+posX,0,.365,0)
	OS.Volume.ButtonDown.Size = UDim2.new(posX,0,.1,0)
	OS.Volume.ButtonDown.BackgroundColor3 = phoneSettings.VolumeColor
	OS.Volume.ButtonDown.Text = ""
	
	local cornerDown = Instance.new("UICorner", OS.Volume.ButtonDown)
	cornerDown.CornerRadius = UDim.new(1,0)

	OS.PowerButton = Instance.new("TextButton", OS.Frame)
	OS.PowerButton.AnchorPoint = Vector2.new(.5,.5)
	OS.PowerButton.Position = UDim2.new(0-posX,0,.25,0)
	OS.PowerButton.Size = UDim2.new(posX,0,.1,0)
	OS.PowerButton.BackgroundColor3 = phoneSettings.PowerColor
	OS.PowerButton.Text = ""
	
	local cornerPower = Instance.new("UICorner", OS.PowerButton)
	cornerPower.CornerRadius = UDim.new(1,0)

	-- Set up phone screen
	OS.Screen = Instance.new("CanvasGroup", OS.Frame)
	OS.Screen.Name = "Screen"
	OS.Screen.AnchorPoint = Vector2.new(.5,.5)
	OS.Screen.Position = UDim2.new(.5,0,.5,0)
	OS.Screen.Size = UDim2.new(1,0,1,0)
	OS.Screen.BackgroundColor3 = Color3.new(1,1,1)

	OS.ScreenCorner = Instance.new("UICorner", OS.Screen)
	OS.ScreenCorner.CornerRadius = phoneSettings.CornerRadius

	-- Create homescreen frame
	OS.Homescreen = Instance.new("CanvasGroup", OS.Screen)
	OS.Homescreen.Name = "Homescreen"
	OS.Homescreen.AnchorPoint = Vector2.new(.5,.5)
	OS.Homescreen.Position = UDim2.new(.5,0,.5,0)
	OS.Homescreen.Size = UDim2.new(1,0,1,0)
	OS.Homescreen.BackgroundTransparency = 1

	OS.HomeBackground = Instance.new("ImageLabel", OS.Homescreen)
	OS.HomeBackground.Name = "Background"
	OS.HomeBackground.AnchorPoint = Vector2.new(.5,.5)
	OS.HomeBackground.Position = UDim2.new(.5,0,.5,0)
	OS.HomeBackground.Size = UDim2.new(2,0,1,0)
	OS.HomeBackground.ScaleType = Enum.ScaleType.Crop
	OS.HomeBackground.Image = "rbxassetid://"..CONFIG.WALLPAPER_ID

	OS.PageDotsFrame = Instance.new("CanvasGroup", OS.Homescreen)
	OS.PageDotsFrame.Name = "PageDots"
	OS.PageDotsFrame.Position

	-- Set up island (pill at top of screen)
	OS.Island = Island.new(CONFIG.NOTIFICATION_DURATION, CONFIG.MEDIA_PLAY_ID, CONFIG.MEDIA_PAUSE_ID, CONFIG.MEDIA_SKIP_ID, CONFIG.MEDIA_TIMEOUT)
	OS.Island.Frame.Parent = OS.Screen

	OS.IslandInset = OS.Island.Frame.Position.Y.Scale + OS.Island.Frame.Size.Y.Scale

	-- Set up gesture bar (home button at bottom of screen)
	OS.Gesture = Gesture.new()
	OS.Gesture.Button.Parent = OS.Screen

	OS.GestureInset = 1 - OS.Gesture.Button.Position.Y.Scale + OS.Gesture.Button.Size.Y.Scale

	OS.Gesture.GestureClicked:Connect(function()
		for i, v in OS.Apps do
			v:CloseApp()
			OS.Spring(OS.Gesture.Button, 1, 1, {BackgroundColor3 = OS.MainGestureColor})
		end
	end)

	-- Create a homescreen page
	OS.Pages = {
		[1] = Page.new(OS.Homescreen, OS.IslandInset, OS.GestureInset)
	}
	
	OS.CurrentPage = 1

	OS.Grids = {
		[1] = Grid.new(OS.Pages[1].Frame, Vector2.new(CONFIG.APP_GRID_X,CONFIG.APP_GRID_Y), CONFIG.APP_GRID_SPACING, OS.Pages[1].GridFrame)
	}

	-- Create table for all registered apps
	OS.Apps = {}
	
	-- Device variables
	OS.DeviceAspectRatio = phoneSettings.AspectRatio
	OS.MainGestureColor = Color3.new(1,1,1)
end

function OS.RegisterApp(name: string, frame: CanvasGroup, imageId: number, theme: "Light" | "Dark"): typeof(App.new())
	local app = App.new(name, frame, imageId, theme, CONFIG.ASPECT_RATIO)

	local timeout = CONFIG.APP_TIMEOUT

	repeat
		if timeout < CONFIG.APP_TIMEOUT then
			task.wait(1)
		end
		
		timeout -= 1
		
		if timeout <= 0 and not OS.Apps then
			warn("Could not add app. App table not found.")
			return
		end
	until OS.Apps

	table.insert(OS.Apps, app)

	local foundGrid = false

	for i, v in OS.Grids do
		app.Button.Size = UDim2.fromScale((1/v.X), 1/v.Y)

		local added = v:AddObject(app.Button)
		if added then			
			app.Button.Parent = OS.Pages[i].Frame
			foundGrid = true
			break
		end
	end

	if not foundGrid then
		local pageNum = #OS.Pages + 1
		local gridNum = #OS.Grids + 1
		
		local page = OS.Pages[pageNum] = Page.new(OS.Homescreen, OS.IslandInset, OS.GestureInset)
		local grid = OS.Grids[gridNum] = Grid.new(OS.Pages[pageNum].Frame, Vector2.new(CONFIG.APP_GRID_X, CONFIG.APP_GRID_Y), CONFIG.APP_GRID_SPACING, OS.Pages[pageNum].GridFrame)

		grid:AddObject(app.Button)
	end

	app.DefaultSize = app.Button.Size
	app.DefaultPos = app.Button.Position

	frame.Parent = OS.Screen
	frame.Visible = false

	app.ButtonClicked:Connect(function()
		if app.Theme == "Dark" then
			OS.Spring(OS.Gesture.Button, 1, 1, {BackgroundColor3 = Color3.new(1,1,1)})
		else
			OS.Spring(OS.Gesture.Button, 1, 1, {BackgroundColor3 = Color3.new(0, 0, 0)})			
		end
	end)

	return app
end

function OS.GetApp(searchParameter: string | CanvasGroup | GuiButton): typeof(App.new())
	local searchType = typeof(searchParameter)
	
	local function GetApp()
		for i, v in OS.Apps do
			if searchType == "string" then
				if v.Name == searchParameter then
					return v
				end
			elseif searchType == "CanvasGroup" then
				if v.Frame == searchParameter then
					return v
				end
			elseif searchType == "GuiButton" then
				if v.Button == searchParameter then
					return v
				end
			end
		end
	end
	
	local app = nil
	local timer = 0
	
	repeat app = GetApp() task.wait(1) timer = 1 until app ~= nil or timer == CONFIG.APP_TIMEOUT
	
	if app == nil then
		warn("App could not be found:", searchParameter)
	end
	
	return app
end

function OS.PushNotification(app: App, title: string, description: string, imageId: number, islandSize: "Small" | "Large" | "Square")
	OS.Island:Notify(app, title, description, imageId, islandSize)
end

-- WIP
function OS.PushPermission(app: typeof(App.new()), permissionType: PermissionType)
	local frame = Instance.new("Frame", app.Frame)
	frame.Position = UDim2.new(.5,0,.5,0)
	frame.AnchorPoint = Vector2.new(.5,.5)
	frame.Size = UDim2.new(.75,0,.5,0)
	frame.ZIndex = 100000
	frame.BackgroundColor3 = Color3.new(.1,.1,.1)

	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(.15,0)

	local title = Instance.new("TextLabel", frame)
	title.AnchorPoint = Vector2.new(.5,.5)
	title.Position = UDim2.new(.5,0,.15,0)
	title.Size = UDim2.new(.9,0,.2,0)
	title.Text = "Title"

	local description = Instance.new("TextLabel", frame)
	description.AnchorPoint = Vector2.new(.5,.5)
	description.Position = UDim2.new(.5,0,.5,0)
	description.Size = UDim2.new(.9,0,.4,0)
	description.Text = `Allow {app.Name} to access {permissionType}?`

	local allowButton = Instance.new("TextButton", frame)
	allowButton.AnchorPoint = Vector2.new(.5,.5)
	allowButton.Position = UDim2.new(.5,0.6,0)
	allowButton.Size = UDim2.new(.9,0,.2,0)
	allowButton.Text = "Allow"

	local allowCorner = Instance.new("UICorner", allowButton)
	allowCorner.CornerRadius = UDim.new(.2,0)

	local declineButton = Instance.new("TextButton", frame)
	declineButton.AnchorPoint = Vector2.new(.5,.5)
	declineButton.Position = UDim2.new(.5,0.85,0)
	declineButton.Size = UDim2.new(.9,0,.2,0)
	declineButton.Text = "Decline"

	local declineCorner = Instance.new("UICorner", allowButton)
	declineCorner.CornerRadius = UDim.new(.2,0)
end

function OS.PlayMedia(title: string, author: string, iconId: number, soundId: number)
	local newSound = Instance.new("Sound", OS.Gui)
	newSound.SoundId = "rbxassetid://"..soundId
	
	OS.Island:AddMedia(title, author, iconId, newSound)
	newSound:Play()
	
	return newSound
end

function OS.Spring(instance: Instance, damping: number, frequency: number, properties: {[string]: any}): boolean
	Spr.target(instance, damping, frequency, properties)

	Spr.completed(instance, function()
		return true
	end)
end

return OS
