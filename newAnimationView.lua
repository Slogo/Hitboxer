local INPUT_NAME = 1
local INPUT_X = 2
local INPUT_Y = 3

local LAYER_NAME = "newAnimation"
local image

local selectedInput = 1
local inputs = {"","",""}

local buttons = {{x = 202, y = 100,
                  width = 50, height = 20,
                  onClick = function()
                    selectedInput = INPUT_NAME
                  end
                 },
                 {x = 202, y = 120,
                   width = 50, height = 20,
                   onClick = function()
                    selectedInput = INPUT_X
                   end
                 },
                 {x = 202, y = 140,
                  width = 50, height = 20,
                  onClick = function()
                   selectedInput = INPUT_Y
                  end
                 },
                 {x = 202, y = 160,
                  width = 50, height = 20,
                  onClick = function()
                   newAnimationView.submit()
                  end
                 },
                }

uimanager.layer.addLayer(LAYER_NAME)

local newAnimationView = {}

newAnimationView.show = function()
  uimanager.layer.enableLayer(LAYER_NAME)
  uimanager.layer.showLayer(LAYER_NAME)
end

newAnimationView.hide = function()
  uimanager.layer.hideLayer(LAYER_NAME)
end

newAnimationView.submit = function()
  local x = 0
  local y = 0
  if inputs[INPUT_X] then
    x = tonumber(inputs[INPUT_X])
  else
    love.errhand("X value not provided")
  end
  
  if inputs[INPUT_Y] then
    y = tonumber(inputs[INPUT_Y])
  else
    love.errhand("Y value not provided")
  end
  love.event.push("newAnimationCreated", inputs[INPUT_NAME], x, y)
end

newAnimationView.init = function(newImage)
  image = newImage
end

newAnimationView.draw = function()
  
  if selectedInput == INPUT_NAME then
    love.graphics.print("name: [".. inputs[INPUT_NAME].."]", buttons[1].x, buttons[1].y)
  else
    love.graphics.print("name: " .. inputs[INPUT_NAME], buttons[1].x, buttons[1].y)
  end
  
  if selectedInput == INPUT_X then
    love.graphics.print("x: ["..inputs[INPUT_X].."]", buttons[2].x, buttons[2].y)
  else
    love.graphics.print("x:" .. inputs[INPUT_X], buttons[2].x, buttons[2].y)
  end
  
  if selectedInput == INPUT_Y then
    love.graphics.print("y: ["..inputs[INPUT_Y].."]", buttons[3].x, buttons[3].y)
  else
    love.graphics.print("y:" .. inputs[INPUT_Y], buttons[3].x, buttons[3].y)
  end
  
  love.graphics.print("Submit", buttons[4].x, buttons[4].y)
  
  if image ~= nil then
    love.graphics.draw(image, 300, 300)
  end
end

newAnimationView.mousePressed = function(x, y)
  for index, button in ipairs(buttons) do
    if x > button.x and x < button.x + button.width and
       y > button.y and y < button.y + button.height then
      button.onClick()
    end
  end
end

newAnimationView.keyPressed = function(key)
  if key == "tab" or key == "return" then
    if key == "return" and selectedInput <= 0 then
      newAnimationView.submit()
    elseif selectedInput < 3 then
      selectedInput = selectedInput + 1
    else
      selectedInput = 0
    end
  elseif key == "backspace" then
    inputs[selectedInput] = string.sub(inputs[selectedInput], 1, #inputs[selectedInput] - 1)
  end
end

newAnimationView.textInput = function(text)
  if selectedInput == INPUT_NAME then
    inputs[INPUT_NAME] = inputs[INPUT_NAME] .. text
  elseif selectedInput == INPUT_X then
    inputs[INPUT_X] = inputs[INPUT_X] .. text
  elseif selectedInput == INPUT_Y then
    inputs[INPUT_Y] = inputs[INPUT_Y] .. text
  end
end

return newAnimationView