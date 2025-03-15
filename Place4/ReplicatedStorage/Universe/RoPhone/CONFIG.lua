-- @ScriptType: ModuleScript

local CONFIG = {}

-- Device looks
CONFIG.SIZE = UDim2.new(.2,0,.7,0) 				-- Size of phone (Constrained by AspectRatio)
CONFIG.POSITION = UDim2.new(.5,0,.5,0) 			-- Position of phone on-screen
CONFIG.ANCHOR_POINT = Vector2.new(.5,.5) 		-- Anchor point of phone
CONFIG.CORNER_RADIUS = UDim.new(.125,0) 		-- Corner radius of the phone
CONFIG.ASPECT_RATIO = .49						-- Aspect ratio of the phone (9:16 is .52) (9:19.5 is .49)
CONFIG.PHONE_COLOR = Color3.new(0, 0, 0)		-- Color of phone case
CONFIG.CASE_THICKNESS = 3						-- Phone case thickness
CONFIG.POWER_COLOR = Color3.new(0,0,0)			-- Power button color
CONFIG.VOLUME_COLOR = Color3.new(0,0,0)			-- Volume button color

-- UI defaults
CONFIG.APP_GRID_X = 5 							-- Default number of apps per row (x)
CONFIG.APP_GRID_Y = 5 							-- Default number of apps per column (y)

CONFIG.GRID_PAD_X = .2 							-- Padding between apps (x)
CONFIG.GRID_PAD_Y = .2 							-- Padding beterrn apps (y)

CONFIG.DEFAULT_VOLUME = .5 						-- Default volume of the device

return CONFIG
