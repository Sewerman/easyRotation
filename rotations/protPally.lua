easyRotation.rotations.protPally = {}

function easyRotation.rotations.protPally.init()
  local _,playerClass = UnitClass("player")
    if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
    if not easyRotationVars.seal then easyRotationVars.seal = true end
    if not easyRotationVars.AvengersShield then easyRotationVars.AvengersShield = true end
 -- if not easyRotationVars.shield then easyRotationVars.shield = true end

  return playerClass == "PALADIN" and GetSpecialization() == 2
end
  
  
function easyRotation.rotations.protPally.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true
elseif (cmd == 'AS' and easyRotationVars.AvengersShield) then
    easyRotationVars.AvengersShield = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Avenger's Shield",1,0,0)
    return true
  elseif (cmd == 'AS' and not easyRotationVars.AvengersShield) then
    easyRotationVars.AvengersShield = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Avenger's Shield",0,0,1)
    return true
  else
    return false
  end
end


function easyRotation.rotations.protPally.DecideBuffs()

end
  
function easyRotation.rotations.protPally.DecideSpells()

 
  


if easyRotation:PlayerCanCastSpell("Light of the Protector")
   and easyRotation:UnitHasBuff("player", "Consecration")
  then easyRotation:UpdateRotationHinterIcon("Light of the Protector")

elseif easyRotation:PlayerCanCastSpell("Blessed Hammer")
   and easyRotation:GetPlayerSpellCharges("Blessed Hammer") >1
  then easyRotation:UpdateRotationHinterIcon("Blessed Hammer")

elseif easyRotation:PlayerCanCastSpell( "Shield of the Righteous")
   and easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >2
  or easyRotation:UnitHealthPercent("player")<60 
   and easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >1
  or easyRotation:UnitHealthPercent("player")<40 
   and easyRotation:GetPlayerSpellCharges("Shield of the Righteous") >0
  then easyRotation:UpdateRotationHinterIcon("Shield of the Righteous")

elseif easyRotation:PlayerCanCastSpell("Judgment")
  then easyRotation:UpdateRotationHinterIcon("Judgment")

elseif easyRotation:PlayerCanCastSpell("Consecration")
  then easyRotation:UpdateRotationHinterIcon("Consecration")

elseif easyRotation:PlayerCanCastSpell("Avenger's Shield")
  then easyRotation:UpdateRotationHinterIcon("Avenger's Shield")




 end
end
