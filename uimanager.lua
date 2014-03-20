if uimanager == nil then
  uimanager = {layer = {}, control = {}, keyboard = {}, keypress = {},}
end

--Input Types

local inputType = {x = 0, y = 0, width = 0, height = 0}

inputType.onHover = function(input)
  input.hover = true
end

inputType.lostHover = function(input)
  input.hover = false
end

inputType.onFocus = function(input)
  input.focus = true
end

inputType.onBlur = function(input)
  input.focus = false
end

inputType.onPress = function(input)
  if input.callback then
    input.callback()
  end
end

inputType.onRelease = function(input)

end

inputType.enable = function(input)
  input.enabled = true
end

inputType.disable = function(input)
  input.enabled = true
end

inputType.update = function(dt)

end

inputType.draw = function(button)

end

inputType = {__index = inputType}

--Button Type
local buttonType = {title = "", activated = false}
setmetatable(buttonType, inputType)

buttonType.onPress = function(input)
  input.activated = true
end

buttonType.onRelease = function(input)
  if input.activated and input.callback then
    input.callback()
  end
end

buttonType = {__index = buttonType}

--Layers
uimanager.layer.DEFAULT_LAYER_NAME = "default"

local internal = {
  layers = {}
}

uimanager.layer.newLayer = function(name)
  return {name = name, enabled = true, visible = true, controls = {}}
end

uimanager.layer.addLayer = function(name)
  table.insert(internal.layers, uimanager.layer.newLayer(name))
end

uimanager.layer.removeLayer = function(name)
  local layer, i = uimanager.layer.getLayer(name)
  table.remove(internal.layers, i)
end

uimanager.layer.getLayer = function(name)
  for i, layer in ipairs(internal.layers) do 
    if layer.name == name then
      return layer, i
    end
  end
end

uimanager.layer.enableLayer = function(name)
  local layer = uimanager.layer.getLayer(name)
  if layer then
    layer.enabled = true
  end
end

uimanager.layer.disableLayer = function(name)
  local layer = uimanager.layer.getLayer(name)
  if layer then
    layer.enabled = false
  end
end

uimanager.layer.showLayer = function(name)
  local layer = uimanager.layer.getLayer(name)
  if layer then
    layer.visible = true
  end
end

uimanager.layer.hideLayer = function(name)
  local layer = uimanager.layer.getLayer(name)
  if layer then
    layer.visible = false
    layer.enabled = false
  end
end

uimanager.layer.addControl = function(name, control)
  local layer = uimanager.layer.getLayer(name)
  if layer then
    table.insert(layer.controls, control)
  end
end

uimanager.layer.addControls = function(name, controls)
  local layer = uimanager.layer.getLayer(name)
  if layer then
    for i, control in ipairs(controls) do
      table.insert(layer.controls, control)
    end
  end
end

-- Create default layer
uimanager.layer.newLayer(uimanager.layer.DEFAULT_LAYER_NAME)

-- Buttons

uimanager.control.newButton = function(options)
  local button = {}
  setmetatable(button, buttonType)
  
  for key, value in pairs(options) do
    button[key] = options[key]
  end
  return button
end

-- Text Input
uimanager.control.newTextInput = function(text, validation, callback, x, y, width, height)

end


--UI Manager Methods
uimanager.getSelectedControl = function()
  local x, y = love.mouse.getPosition()
  for i, layer in ipairs(internal.layers) do
    for j, control in ipairs(layer.controls) do
      if x > control.x and x < control.x + control.width and
         y > control.y and y < control.y + control.height then
        return control
      end
    end
  end
  return nil
end

uimanager.update = function(dt)
  local control = uimanager.getSelectedControl()
  if control then
    control.hover = true
  end
end

uimanager.draw = function()
  for i, layer in ipairs(internal.layers) do
    for j, control in ipairs(layer.controls) do
      control:draw()
    end
  end
end

uimanager.keypressed = function(key, isRepeat)

end

uimanager.mousepressed = function(x, y, button)

end

uimanager.textinput = function(text)

end