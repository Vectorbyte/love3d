# LÖVE3D for LÖVE 0.11.0

Enables the user to control depth testing, depth writing and face culling in LÖVE so they can render 3D objects and scenes.

# Usage

```lua
local l3d = require "love3d"

function renderer_initialize()
  -- Here we enable depth testing and writing
  l3d.set_depth_state(true)

  -- We can use l3d.new_canvas() to create a canvas table that holds both color and depth data
  -- It can be passed into love.graphics.setCanvas()
  local canvas = l3d.new_canvas(1920, 1080, { rgba8, depth24 }, 0)
end

function renderer_draw()
  -- And with these functions we can enable or disable, or just modify depth testing or depth writing individually
  l3d.set_depth_write(false)
  l3d.set_depth_test("greater")

  -- We can also cull faces accordingly. LÖVE uses the default OpenGL face winding (which is CCW)
  l3d.set_culling("back")
end
```
