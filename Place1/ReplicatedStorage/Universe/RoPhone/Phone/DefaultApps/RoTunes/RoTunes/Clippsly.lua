-- @ScriptType: ModuleScript
-- @ScriptType: ModuleScript
local AssetService = game:GetService("AssetService")
local OpenCloudService = game:GetService("OpenCloudService")

local Clippsly = {}

function Clippsly.GetSongIds(): {number}
	local songs = {}
	
	local searchParams = Instance.new("AudioSearchParams")
	searchParams.SearchKeyword = "Clippsly"
	
	local success, result = pcall(function()
		return AssetService:SearchAudio(searchParams)
	end)
	
	if success then		
		local pages = {}
		
		local currentPage = result:GetCurrentPage()
		for _, audio in currentPage do
			print(audio.Title)
		end
		
		--[[
		while true do
			table.insert(pages, result:GetCurrentPage())
			
			for i, v in result:GetCurrentPage() do
				table.insert(songs, v.Id)
			end
			
			if result.IsFinished then
				break
			end
			
			result:AdvanceToNextPageAsync()
		end
		--]]
	end
	
	return songs
end

return Clippsly