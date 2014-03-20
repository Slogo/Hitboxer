if hitboxer == nil then
  hitboxer = {hitsheet = {}, hitframe = {}, hitbox = {}}
elseif hitboxer.hitsheet == nill then
  hitboxer.hitsheet = {}
end

hitboxer.hitsheet.newHitsheet = function(image, x, y)
  return { sprite = image,
           frameSize = {x = x or 0, y = y or 0},
           frames = {} }
end

hitboxer.hitframe.newHitframe = function()
  return { frame = 0, collisions = {}, attacks = {}, flags = {}}
end

hitboxer.hitbox.newHitbox = function()
  return { x = 0, y = 0, width = 0, height = 0 }
end