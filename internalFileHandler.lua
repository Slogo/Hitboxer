local workDirectory
local config = {
    hitboxesDirectory = "hitboxes",
    imagesDirectory = "images"
  }

local fileHandler = {}

fileHandler.init = function()
  if not config.animationDirectory then
   -- No Animation Directory Set
  end
  
  if not config.imageDirectory then
    -- No Image Directory Set
  end 
end

fileHandler.readImageDirectory = function()
  return love.filesystem.getDirectoryItems( config.imagesDirectory )
end

fileHandler.readHitboxDirectory = function()
  return love.filesystem.getDirectoryItems( config.hitboxesDirectory )
end

fileHandler.readImage = function(imageName)
  return love.graphics.newImage(config.imagesDirectory .. "/" .. imageName)
end

return fileHandler