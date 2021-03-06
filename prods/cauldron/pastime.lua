-- pastime.lua

function dofornext(fn, ntimes)
  local c = 0
  local ufn = function ()
    fn()
    c = c + 1
    if c >= ntimes then
      updatefns.timedtask = nil
    end
  end
  updatefns.timedtask = ufn
end

function renderfornext(fn, ntimes)
  local c = 0
  local ufn = function ()
    fn()
    c = c + 1
    if c >= ntimes then
      renderfns.timedtask = nil
    end
  end
  renderfns.timedtask = ufn
end
