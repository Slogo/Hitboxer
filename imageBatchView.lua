local fileHandler = require(FILE_HANDLER_PATH)

local image = nil
local sizeSelected = true
local spriteX = 0
local spriteY = 0

uimanager.addLayer("imageBatch")

love.handler.show = function()

end

love.handler.hide = function()

end

love.handlers.newImageSelected = function(newImage)
  image = fileHandler.readImage(newImage)
  sizeSelected = false
  spriteX = 0
  spriteY = 0
end

local imageBatchView = {}

imageBatchView.draw = function()
  if image ~= nil then
    if sizeSelected then
      -- Display Size selection
    else
      love.graphics.draw(image, 300, 300)
    end
  end
end

return imageBatchView