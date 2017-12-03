-- OpenGL functions
local ffi = require("ffi")
local bin = (love.filesystem.isFused() and love.filesystem.getInfo("bin/SDL2.dll")) and "bin/SDL2" or "SDL2"
local sdl = (love.system.getOS() == "Windows") and ffi.load(bin) or ffi.C
ffi.cdef("void *SDL_GL_GetProcAddress(const char *proc);")

-- GL table
local GL = {
    EQUAL      = 0x0202,
    LEQUAL     = 0x0203,
    GEQUAL     = 0x0206,
    ALWAYS     = 0x0207,
    FRONT      = 0x0404,
    BACK       = 0x0405,
    CULL_FACE  = 0x0B44,
    DEPTH_TEST = 0x0B71,
}

-- GL functions
local gl_functions = {
    { "DepthMask", "unsigned char" },
    { "Disable"  , "unsigned int"  },
    { "DepthFunc", "unsigned int"  },
    { "Enable"   , "unsigned int"  },
    { "CullFace" , "unsigned int"  },
}

-- Register functions
for _, info in ipairs(gl_functions) do
    local name = info[1]
    local proc = ("gl%s"):format(name)
    ffi.cdef(("typedef void(*%s)(%s);"):format(proc, info[2]))
    GL[name] = ffi.cast(proc, sdl.SDL_GL_GetProcAddress(proc))
end

return GL