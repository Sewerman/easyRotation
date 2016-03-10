easyRotation.modules.beastHunter = {}

function easyRotation.modules.beastHunter.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "HUNTER" and GetSpecialization() == 1
end

function easyRotation.modules.beastHunter.initializeVariables()
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
end

function easyRotation.modules.beastHunter.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true
  else
    return false
  end
end

function easyRotation.modules.beastHunter.DecideSpells()


end