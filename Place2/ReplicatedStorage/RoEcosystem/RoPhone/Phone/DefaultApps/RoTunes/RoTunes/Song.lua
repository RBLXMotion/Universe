-- @ScriptType: ModuleScript
local AssetService = game:GetService("AssetService")
local MarketplaceService = game:GetService("MarketplaceService")

local Song = {}
Song.__index = Song

function Song.new(songId: number)
	local self = setmetatable({}, Song)
	
	local songPage = MarketplaceService:GetProductInfo(songId, Enum.InfoType.Asset)

	self.Name = songPage.Name
	self.Artist = songPage.Creator.Name
	self.SongId = songId
	self.CoverId = songPage.IconImageAssetId
	
	print(songPage)

	return self
end

return Song