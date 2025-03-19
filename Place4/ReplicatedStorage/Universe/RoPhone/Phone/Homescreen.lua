-- @ScriptType: ModuleScript

local CONFIG = require(script.Parent.Parent:WaitForChild("CONFIG"))
local Spring = require(script.Parent:WaitForChild("Spring"))

local dependencies = script.Parent:WaitForChild("Dependencies")
local Grid = require(dependencies:WaitForChild("Grid"))
local Signal = require(dependencies:WaitForChild("GoodSignal"))

local Page = require(script:WaitForChild("Page"))

local Homescreen = {}
Homescreen.__index = Homescreen

function Homescreen.new()
  local self = setmetatable({}, Homescreen)

  self.Frame = Instance.new("CanvasGroup")
  
  self.Pages = {} :: {[number]: {["Page"]: Page.new(), ["Grid"]: Grid.new()}}
  self.PageAdded = Signal.new()
  
  return self
end

function Homescreen:AddPage()
  
end

return Homescreen
