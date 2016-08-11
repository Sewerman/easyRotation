easyRotation.rotations.havocDemon = {}

function easyRotation.rotations.havocDemon.init()
  local _,playerClass = UnitClass("player")
    if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
    

  return playerClass == "DEMON HUNTER" and GetSpecialization() == 2
end

function easyRotation.rotations.havocDemon.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",1,0,0)
    return true
  else
    return false
  end
end

function easyRotation.rotations.havocDemon.DecideSpells()
  if easyRotationVars.mode == "Single Target" then
    easyRotation.rotations.havocDemon.DecideSingleTargetSpells()
  elseif easyRotationVars.mode == "AOE" then
    easyRotation.rotations.havocDemon.DecideAOESpells()
  end
end

function easyRotation.rotations.havocDemon.DecideSingleTargetSpells()
end
function easyRotation.rotations.protPally.DecideAOESpells()
end