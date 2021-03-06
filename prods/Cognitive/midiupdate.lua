function midiUpdate()
  if fugue.playing == true then
    if fugue.currnote <= #fugue.lines[1] then
      if fugue.p1On == true then
        local note = fugue.lines[1][fugue.currnote]
        local midiNote = fugue.makeMidiNote(note)
        --print(fugue.currnote, midiNote)

        midiSelectInstrument(fugue.inst1)
        midiNoteOff(fugue.lastNote1)
        midiNoteOn(midiNote)
        
        -- play note in the other line.
        
        -- local duration = 100 * fugue.rhythms[2][((fugue.currnote - 1) % 4) + 1]
        -- print(duration)
        
        -- the duration needs to be constant for now
        local duration = note.duration
        
        midiLaunchNextEvent(duration)
        
        fugue.lastNote1 = midiNote
        fugue.currnote = fugue.currnote + 1
      end
    else
      midiNoteOff(fugue.lastNote1)
      print("no more notes!")
      fugue.playing = false
    end
  end
end
