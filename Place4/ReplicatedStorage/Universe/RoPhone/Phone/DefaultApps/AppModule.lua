-- @ScriptType: ModuleScript

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Universe = ReplicatedStorage:WaitForChild("Universe")
local Phone = require(Universe:WaitForChild("RoPhone"):WaitForChild("Phone"))

local AppModule = {}

function AppModule.RegisterApp(appName: string, appFrame: CanvasGroup, imageId: number)

	AppModule.App = Phone.RegisterApp(appName, appFrame, imageId, "Dark")
	AppModule.AppName = appName
	AppModule.AppFrame = appFrame

end

return AppModule
