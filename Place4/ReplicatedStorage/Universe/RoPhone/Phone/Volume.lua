local Volume = {}
Volume.__index = Volume

function Volume.new(defaultVolume: number)
    local self = setmetatable({}, Volume)
    
    self.ButtonUp = Instance.new("TextButton")
    self.ButtonDown = Instance.new("TextButton")

    self.Level = defaultVolume or .5
    self.Instances = {Sound}

    return self
end

function Volume:Up()

end

function Volume:Down()

end

return Volume
