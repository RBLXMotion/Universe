-- @ScriptType: ModuleScript

local Grid = {}
Grid.__index = Grid

function Grid.new(parent: GuiObject, gridSize: Vector2, padding: Vector2, constraint: GuiObject)
	local self = setmetatable({}, Grid)

	self.Max = gridSize.X * gridSize.Y

	self.X = gridSize.X -- Columns
	self.Y = gridSize.Y -- Rows
	
	self.PaddingX = padding.X
	self.PaddingY = padding.Y

	self.Parent = parent
	self.Constraint = constraint

	self.Objects = {}
	self.Grid = {}

	for i = 1, self.Y do
		self.Grid[i] = {}
		for j = 1, self.X do
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
						(object.Size.X.Scale - (self.PaddingX/self.X)) * self.Constraint.Size.X.Scale,
						(object.Size.Y.Scale - (self.PaddingY/self.Y)) * self.Constraint.Size.Y.Scale
					)
					
					gridObject.ScreenPos = UDim2.fromScale(
						(((j-1)/self.X) + (self.PaddingX/self.X/2) + (object.Size.X.Scale/2)) / self.Constraint.Size.X.Scale,
						(((i-1)/self.Y) + (self.PaddingY/self.Y/2) + (object.Size.Y.Scale/2)) / self.Constraint.Size.Y.Scale
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
