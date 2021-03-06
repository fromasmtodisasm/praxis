-- editor.lua

keymap = {}

keymap2 = {}
keymap2up = {}

function getKeyHandler(keymap,k,mods)
  local handler = nil
  if keymap[k] ~= nil then
    if keymap[k][mods] ~= nil then
      handler = keymap[k][mods]
    end
  end
  if handler ~= nil then
    if handler.fn == nil then
      handler.fn = loadstring(handler.program)
    end
    return handler.fn
  else
    return nil
  end
end

function setKeyHandler(keymap,k,mods,fn)
  if keymap[k] == nil then
    keymap[k] = {}
  end
  if keymap[k][mods] == nil then
    keymap[k][mods] = {}
  end
  keymap[k][mods].fn = fn
end

function setKeyHandlerProgram(keymap,k,mods,prog)
  local fn = loadstring(prog)
  setKeyHandler(keymap, k, mods, fn)
  keymap[k][mods].program = prog
end

function edTab()
  for i = 1,2,1 do
    edInsertTextAt(" ", edGetPosition())
    edSetPosition(edGetRight(edGetPosition()))
  end
end

function edTypeString(c)
  edInsertTextAt(c, edGetPosition())
  local l = string.len(c)
  for i=1,l,1 do
    edSetPosition(edGetRight(edGetPosition()))
  end
end

function edGetKeyModifiers()
  local n = 0
  if isShiftDown()  then n = n + 1 end
  if isCtrlDown()   then n = n + 2 end
  if isAltDown()    then n = n + 4 end
  return n
end

edEchoKeys = false

function onKeyDown(k)
  local m = edGetKeyModifiers()
  if keyrecorder then keyrecorder:onKeyDown(k,m) end
  onKeyDownWithMods(k,m)
end
  
function onKeyDownWithMods(k,mods)
  if edEchoKeys then
    print("onKeyDown " .. k)
  end
  --local mods = edGetKeyModifiers()
  if editorVisible() then
    local action = getKeyHandler(keymap, k, mods)
    if action ~= nil then
      onKeyDownSpecial = onKeyDownSpecial_Plain
      action()
    else
      if edEchoKeys then
        print("Missing key handler for " .. k .. ", mods = " .. mods)
      end
      replaceFunction("onKeyDownSpecial", onKeyDownSpecial_Plain,
        function (k2)
          print("  Setting key handler for " .. k .. ", mods " .. mods)
          print("  to print " .. string.char(k2) .. " (" .. k2 .. ")")
          local stringrep = string.char(k2)
          if string.char(k2) == "\\" then
            stringrep = "\\\\"
          end
          if string.char(k2) == "\"" then
            stringrep = "\\\""
          end
          setKeyHandlerProgram(keymap, k, mods,
            [[edTypeString("]]..stringrep .. [[")]])
        end, 1)
    end
  else
    -- Separate key handler table.
    local action = getKeyHandler(keymap2, k, mods)
    if action ~= nil then
      action()
    end
  end
end

function onKeyUp(k)
  if edEchoKeys then
    print("onKeyUp   " .. k)
  end
  if not editorVisible() then
    local mods = edGetKeyModifiers()
    local action = getKeyHandler(keymap2up, k, mods)
    if action ~= nil then
      action()
    end
  end
end

function onKeyDownSpecial_Plain(k)
  if edEchoKeys then
    print("  onKeyDownSpecial " .. k)
  end
end

onKeyDownSpecial = onKeyDownSpecial_Plain

function onKeyUpSpecial(k)
  if edEchoKeys then
    print("  onKeyUpSpecial " .. k)
  end
end

--newBuffer()
--setBufferText("")
clearError()
clearTrace()

print("Loaded editor.lua")


