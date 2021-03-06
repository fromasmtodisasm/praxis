function render()
  
  WidgetLib.renderAll()
  --WidgetLib.callAll("render")
  
  renderGears()
  renderGearBots()
  fugue.render()

  colorGL(255,255,255,255)
  
  drawText2D("" .. getEditorLineStart() .. "," .. getEditorLineEnd() .. ": " .. getEditorLineText(), 50,10)

  --renderSlipnet()
  --renderWorkspace()
  
  --testGLColorFunc()
  
  -- colorGL(255,255,0,255)
  
  -- local rpos,wpos,rtot,wtot = getSampleMarkers()
  
  -- drawText2D("" .. rtot, 10,15)
  -- drawText2D("" .. wtot, 10,10)
  
  -- drawText2D("" .. lpfEffNode.samplesLastFrame, 10,5)
  
  SynthNode.renderInputs(sineConNode)
  SynthNode.renderInputs(sineConNode2)
  SynthNode.renderInputs(sineGenNode)
  SynthNode.renderInputs(lpfEffNode)
  SynthNode.renderInputs(sinkNode)
  
  SynthNode.render(lpfEffNode, vec2d(0,0), vec2d(100,30))
  
  --ttestrender()
  
end
