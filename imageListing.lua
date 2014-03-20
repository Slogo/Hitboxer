local LAYER_NAME = "imageListing"

local activeColor = {180, 54, 54, 1}
local hoverColor = {255, 255, 255, 1}

local fileHandler = require(FILE_HANDLER_PATH)
local imageListing = {}

local images = fileHandler.readImageDirectory()

local highlighted = 0

imageListing.x = 2
imageListing.y = 2
imageListing.width = 120
imageListing.height = 24
imageListing.yStep = 10
imageListing.yMargin = 2
imageListing.xMargin = 2

imageListing.update = function()

end

uimanager.layer.addLayer(LAYER_NAME)

imageListing.initialize = function()
  local index
  local image
  local buttons = {}
  
  local buttonOptions = {
    activated = true,
    x = imageListing.x,
    y = imageListing.y,
    callback = imageListing.buttonPressed,
    width = imageListing.width,
    height = imageListing.height,
    draw = imageListing.drawButton
  }
  
  for index, image in ipairs(images) do
    buttonOptions.title = image
    table.insert(buttons, uimanager.control.newButton(buttonOptions))
    buttonOptions.y = buttonOptions.y + imageListing.yStep
  end
  
  uimanager.layer.addControls(LAYER_NAME, buttons)
end

imageListing.buttonPressed = function(button)
  love.event.push("newImageSelected", button.title)
end

imageListing.drawButton = function(button)
  local currentColor = {}
  currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
  
  if button.focus then
    love.graphics.setColor(activeColor)
  elseif button.hover then
    love.graphics.setColor(hoverColor)
  end
    
  love.graphics.rectangle( "line", button.x, button.y, button.width, button.height )
  
  if button.title then
    love.graphics.print(button.title, button.x + imageListing.xMargin, button.y + imageListing.yMargin)
  end
  
  love.graphics.setColor(currentColor)
end

return imageListing