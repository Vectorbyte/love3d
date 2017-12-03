--- LÖVE3D
-- Utilities for working in 3D with LÖVE
local l3d, GL = {}, require((...):gsub("init", "") .. "/opengl")

-- Depth buffer functions
function l3d.set_depth_state(arg)
    local arg = (arg == nil) and false or arg
    assert(type(arg) == "boolean", "expected one parameter of type 'boolean'")
    ;(arg and GL.Enable or GL.Disable)(GL.DEPTH_TEST)
end

function l3d.set_depth_write(arg)
    local arg = (arg == nil) and true or arg
    assert(type(arg) == "boolean", "expected one parameter of type 'boolean'")
	GL.DepthMask(arg and 1 or 0)
end

function l3d.set_depth_test(method)
    local methods = {
        greater = GL.GEQUAL,
        equal   = GL.EQUAL,
        less    = GL.LEQUAL,
        none    = GL.ALWAYS,
    }
    assert(methods[method], "Invalid culling method: Parameter must be one of: 'greater', 'equal', 'less' or 'none'")
    GL.DepthFunc(methods[method])
end

-- Set culling method
function l3d.set_culling(method)
    if not method then
        GL.Disable(GL.CULL_FACE)
        return end
    local methods = {
        back  = GL.BACK,
        front = GL.FRONT,
    }
    assert(methods[method], "Invalid culling method: Parameter must be one of: 'front', 'back' or unspecified")
    GL.Enable(GL.CULL_FACE)
    GL.CullFace(methods[method])
end

--- Create a canvas with a depth buffer.
function l3d.new_canvas(width, height, format, msaa)
    local w, h = width or love.graphics.getWidth(), height or love.graphics.getHeight()
    local c = love.graphics.newCanvas(w, h, {format = format[1], msaa = msaa})
    local d = love.graphics.newCanvas(w, h, {format = format[2], msaa = msaa})
    return {c, depthstencil = d}
end

return l3d