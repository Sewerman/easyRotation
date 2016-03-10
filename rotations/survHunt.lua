easyRotation.modules.survHunter = {}

function easyRotation.modules.survHunter.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "HUNTER" and GetSpecialization() == 3
end

function easyRotation.modules.survHunter.initializeVariables()
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
end

function easyRotation.modules.survHunter.Slash(cmd,val)
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

function easyRotation.modules.survHunter.DecideSpells()


end
