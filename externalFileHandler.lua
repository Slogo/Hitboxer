local workDirectory
local config = {
    animationDirectory = false,
    imageDirectory = false
  }

local filehandler = {}

fileHandler.init = function() {
  local line, property, value
  workDirectory = love.filesystem.getWorkingDirectory()
  
  local configFile = io.open(workDirectory .. "/hitBoxer.config")
  if configFile == nil then
    -- Could not open file
  end
  
  for line in configFile:lines() do 
    for property, value in string.gmatch(line, "(%w+)=(%w+)") do
      if config[property] != nil then
        config[property] = value
      else
        -- Could not set unidentified property
      end
    end
  end
  
  configFile:close()
  
  if not config.animationDirectory then
   -- No Animation Directory Set
  end
  
  if not config.imageDirectory then
    -- No Image Directory Set
  end 
}

fileHandler.readImage = function(imageName) {
  love.graphics.newImage(workDirectory .. "/" .. animationDirectory .. "/" .. imageName)
  
  -- io.open(workDirectory .. "/" .. animationDirectory .. "/" .. imageName)
}

return fileHandler