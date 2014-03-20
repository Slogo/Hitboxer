local MAX_SPRITE_VIEW_WIDTH = 300
local SPRITE_VIEW_X = 200
local SPRITE_VIEW_Y = 0
local BUTTON_WIDTH = 16
local BUTTON_HEIGHT = 32

local hitsheet
local columns = 0
local rows = 0
local offset = 0

local frames
local displayNumber
local quads = {}

local spriteView = {}
spriteView.init = function(data)
  hitsheet = data
  
  if hitsheet.sprite == nil then
    love.errhand("spriteView recieved nil value for image")
    return
  end
  
  if hitsheet.frameSize.x == nil then
    love.errhand("spriteView recieved nil value for spriteX")
  end
  
  if hitsheet.frameSize.y == nil then
    love.errhand("spriteView recieved nil value for spriteX")
  end
  
  quads = {}
  x = hitsheet.frameSize.x
  y = hitsheet.frameSize.y
  columns = math.floor(hitsheet.sprite:getWidth() / x)
  rows = math.floor(hitsheet.sprite:getHeight() / y)
  frames = columns * rows
  displayNumber = math.floor((MAX_SPRITE_VIEW_WIDTH - 2 * BUTTON_WIDTH) / (x+3))

  for i = 1, rows, 1 do
    for j = 1, columns, 1 do
      table.insert(quads, love.graphics.newQuad( (j-1)*x, (i-1)*y, x, y, hitsheet.sprite:getWidth(), hitsheet.sprite:getHeight()))
    end
  end
end

spriteView.draw = function()
  local numberToDisplay = math.min(frames - offset, displayNumber)
  for i = 1, numberToDisplay, 1 do
    love.graphics.draw(hitsheet.sprite, quads[i + offset], i * (x+3) + SPRITE_VIEW_X + BUTTON_WIDTH, y)
  end
  love.graphics.print(offset, 300, 300)
  love.graphics.rectangle( "line", SPRITE_VIEW_X, SPRITE_VIEW_Y, BUTTON_WIDTH, BUTTON_HEIGHT)
  love.graphics.rectangle( "line", SPRITE_VIEW_X + MAX_SPRITE_VIEW_WIDTH - BUTTON_WIDTH, SPRITE_VIEW_Y, BUTTON_WIDTH, BUTTON_HEIGHT)
end

spriteView.mousePressed = function(x, y)
 if x >= SPRITE_VIEW_X and x <= SPRITE_VIEW_X + BUTTON_WIDTH and 
    y > SPRITE_VIEW_Y and y < BUTTON_HEIGHT then
    if offset > 0 then
      offset = offset - 1
    end
 elseif x > MAX_SPRITE_VIEW_WIDTH + SPRITE_VIEW_X - BUTTON_WIDTH and x < MAX_SPRITE_VIEW_WIDTH + SPRITE_VIEW_X and 
    y > SPRITE_VIEW_Y and y < BUTTON_HEIGHT then
    if offset <= (frames - displayNumber) then
      offset = offset + 1
    end
  end
end

return spriteView