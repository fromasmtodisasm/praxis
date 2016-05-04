
textshader = {}

textshader.docshader    = {}

function compiletextshader()
  local g = textshader
  
  g.docshader.prog,shadres = glCreateProgram(
    shaderpassthruvertex330,
    assembleshadersource330("textshader-image-uinttexture.glsl"))
    --shaderpassthruvertex300es,
    --assembleshadersource300es("textshader-image-uinttexture.glsl"))
  assertglshader(shadres)
  
  gather_shader_uniforms(g.docshader)
end

function maketextshaderfbos()
  local g = textshader
  local sz = 512
  fbotest = makefbo(sz,sz, GL_NEAREST)
end

function updatetextshadertext(s)
  stringtex = glStringToTexture(
    s,
    GL_RGBA8UI_EXT,
    GL_RGBA_INTEGER_EXT,
    GL_UNSIGNED_BYTE)
end

function loadfonttexture()
  glLoadStringTexture("test2.bin")
  fonttex = glCreateTexture(GL_RGBA32F_ARB, GL_RGBA, GL_FLOAT)
end

compiletextshader()
maketextshaderfbos()

updatetextshadertext("hello there")
loadfonttexture()

setMaxFramerate(30)
enableStdMouseCam()

function prerender()
  local g = textshader
  render_to_fbo_with_input(fbotest, g.docshader, { texId = fonttex }, { texId = stringtex })
end