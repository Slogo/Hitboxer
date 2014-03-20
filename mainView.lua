local fileHandler = require(FILE_HANDLER_PATH)
local newAnimationView = require("newAnimationView")
local animationEditorView = require("animationEditorView")

local hitsheet
local animationName

local mode

local mainView = {}

mainView.update = function()
  if mode then
    mode.update()
  end
end

mainView.draw = function()
  if mode then
    mode.draw()
  end
end

mainView.keyPressed = function(key)
  if mode and mode.keyPressed then
    mode.keyPressed(key)
  end
end

mainView.textInput = function(text)
  if mode and mode.textInput then
    mode.textInput(text)
  end
end

mainView.mousePressed = function(x, y)
  if mode and mode.mousePressed then
    mode.mousePressed(x, y)
  end
end

love.handlers.newImageSelected = function(image)
  local sprite = fileHandler.readImage(image)
  hitsheet = hitboxer.hitsheet.newHitsheet(sprite)
  mode = newAnimationView
  newAnimationView.init(sprite)
end

love.handlers.newAnimationCreated = function(name, x, y)
  animationName = name
  hitsheet.frameSize.x = x
  hitsheet.frameSize.y = y
  mode = animationEditorView
  animationEditorView.init(hitsheet)
end

return mainView