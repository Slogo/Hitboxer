FILE_HANDLER_PATH = "internalFileHandler"

require("hitboxes")
require("uimanager")

local imageListing = require("imageListing")
-- local mainView = require("mainView")

love.load = function()
  imageListing.initialize()
end

love.update = function(dt)
  uimanager.update(dt)
end

love.draw = function()
  uimanager.draw()
end

love.mousepressed = function(x, y, button)
  uimanager.mousepressed(x, y, button)
  --mainView.mousePressed(x, y, button)
end

love.keypressed = function(key)
  uimanager.keypressed(key)
  --mainView.keyPressed(key)
end

love.textinput = function(text)
  uimanager.textinput(text)
  --mainView.textInput(text)
end