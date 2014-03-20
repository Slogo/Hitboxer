local spriteView = require("spriteView")
local animationEditorView = {}

animationEditorView.init = function(hitsheet)
  spriteView.init(hitsheet)
end

animationEditorView.draw = function()
  spriteView.draw()
end

animationEditorView.mousePressed = function(x, y)
  spriteView.mousePressed(x, y)
end

return animationEditorView