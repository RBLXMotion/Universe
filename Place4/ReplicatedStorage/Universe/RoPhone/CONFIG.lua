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
CONFIG.APP_GRID_X = 5 							-- Default number of apps per row
CONFIG.APP_GRID_Y = 5 							-- Default number of apps per column
CONFIG.APP_GRID_SPACING = .2 					-- Padding between apps

CONFIG.MEDIA_PLAY_ID = 91627705357741			-- Play button image ID (Island media)
CONFIG.MEDIA_PAUSE_ID = 105425577870678			-- Pause button image ID (Island media)
CONFIG.MEDIA_SKIP_ID = 131609719356033			-- Skip button image ID (Island media)

-- Device defaults
CONFIG.DEFAULT_VOLUME = .5 						-- Default volume of the device

CONFIG.NOTIFICATION_ID = 0						-- Default notification sound
CONFIG.NOTIFICATION_DURATION = 2				-- Time, in seconds, that notifications are displayed
CONFIG.ANIMATION_SPEED = 1						-- Default animation speed

CONFIG.MEDIA_TIMEOUT = 30						-- Time, in seconds, that media needs to be paused to close the media player

-- Customizables
CONFIG.WALLPAPER_ID = 116568521810438			-- Default wallpaper image ID

return CONFIG
