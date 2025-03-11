-- @ScriptType: ModuleScript
local Grid = {}
Grid.__index = Grid

function Grid.new(rows: number, columns: number, padding: Vector2, offset: Vector2)
	local self = setmetatable({}, Grid)

	self.Max = rows * columns

	self.X = columns
	self.Y = rows
	
	self.PaddingX = padding.X
	self.PaddingY = padding.Y
	
	self.OffsetX = offset.X
	self.OffsetY = offset.Y

	self.Objects = {}
	self.Grid = {}

	for i = 1, rows do
		self.Grid[i] = {}
		for j = 1, columns do
			self.Grid[i][j] = false
		end
	end

	return self
end

function Grid:CheckUnitSize(row: number, index: number, size: Vector2): boolean
	for i = 1, size.Y do
		for j = 1, size.X do	
			if self.Grid[i+row-1][j+index-1] then
				return false
			end
		end
	end

	return true
end

function Grid:FillUnits(row: number, index: number, size: Vector2)
	for i = 1, size.Y do
		for j = 1, size.X do
			self.Grid[i+row-1][j+index-1] = true
		end
	end
end

function Grid:AddObject(object: GuiObject): boolean
	local gridObject = {
		Object = object,
		Size = Vector2.new(
			math.round(self.X * object.Size.X.Scale),
			math.round(self.Y * object.Size.Y.Scale)
		),
	}
		
	for i, row in self.Grid do -- Loop each row
		for j, v in row do -- Loop each unit in row
			if not v then -- Unit open

				local fit = self:CheckUnitSize(i, j, gridObject.Size)

				if fit then
					self:FillUnits(i, j, gridObject.Size)
					gridObject.GridPos = Vector2.new(j, i)
					
					object.Size = UDim2.fromScale(
						object.Size.X.Scale - (self.PaddingX/self.X) - (self.OffsetX/self.X),
						object.Size.Y.Scale - (self.PaddingY/self.Y) - (self.OffsetY/self.Y)
					)
					
					gridObject.ScreenPos = UDim2.fromScale(
						(((j-1)/self.X) + (self.PaddingX/self.X/2) + (self.OffsetX/2) + (object.Size.X.Scale/2)) * (1-self.OffsetX),
						(((i-1)/self.Y) + (self.PaddingY/self.Y/2) + (self.OffsetY/2) + (object.Size.Y.Scale/2)) * (1-self.OffsetY)
					)
					
					object.Position = gridObject.ScreenPos
					
					self.Objects[#self.Objects + 1] = gridObject
										
					return true
				end
			end
		end
	end
	
	return false
end

return Grid