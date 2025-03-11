-- @ScriptType: ModuleScript
local ENABLE_CLIPPSLY_LINK = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Phone = require(ReplicatedStorage:WaitForChild("Phone"))

local Song = require(script:WaitForChild("Song"))
local Clippsly = require(script:WaitForChild("Clippsly"))

local RoTunes = {}

function RoTunes.RegisterApp(appName: string, appFrame: CanvasGroup, imageId: number)

	RoTunes.App = Phone.RegisterApp(appName, appFrame, imageId, "Dark")
	RoTunes.AppName = appName
	RoTunes.AppFrame = appFrame
	
	RoTunes.RegisteredSongs = {}
	
	if ENABLE_CLIPPSLY_LINK then
		local songs = Clippsly.GetSongIds()
		
		for i, v in songs do
			RoTunes.RegisterSong(v)
		end
	end

end

function RoTunes.GetSongPage(): AudioPages
	
end

function RoTunes.RegisterSong(songId: number)
	local song = Song.new(songId)
	
	RoTunes.RegisteredSongs[song.Name] = song
end

function RoTunes.SearchSong()

end

return RoTunes