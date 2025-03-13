-- @ScriptType: ModuleScript
-- @ScriptType: ModuleScript

local Media = {}
Media.__index = Media

function Media.new(title: string, subtitle: string, audioId: number, duration: number, sound: Sound)
	local self = setmetatable({}, Media)

	self.Title = title
	self.Subtitle = subtitle
	self.AudioId = "rbxassetid://"..audioId

	self.Sound = sound
	self.Sound.SoundId = self.AudioId

	return self
end

function Media:Play()
	self.Sound:Play()
end

function Media:Stop()
	self.Sound:Stop()
end

return Media
