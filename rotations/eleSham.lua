easyRotation.rotations.eleSham = {}

function easyRotation.rotations.eleSham.init()
  local _,playerClass = UnitClass("player") 
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
  return playerClass == "SHAMAN" and GetSpecialization() == 1 
end

function easyRotation.rotations.eleSham.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
 elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
   easyRotationVars.mode = "Single Target"
   DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true

  end
end


function easyRotation.rotations.eleSham.DecideBuffs()
    
  end


function easyRotation.rotations.eleSham.DecideSpells()
  if easyRotationVars.mode == "Single Target" then
    easyRotation.rotations.eleSham.DecideSingleTargetSpells()
  elseif easyRotationVars.mode == "AOE" then
    easyRotation.rotations.eleSham.DecideAOESpells()
  end
end

function easyRotation.rotations.eleSham.DecideSingleTargetSpells()
 --/dump easyRotation:PlayerCanDropTotem(TOTEM_FIRE)
  
 if easyRotation:PlayerCanCastSpell("Lightning Shield")
     and easyRotation:UnitHasBuffRemaining("Player","Lightning Shield") < 5
    then 
      easyRotation:UpdateRotationHinterIcon("Lightning Shield")
   elseif easyRotation:IsPassiveSpell("Unleashed Fury") and easyRotation:PlayerCanCastSpell("Unleashed Flame")
    then easyRotation:UpdateRotationHinterIcon("Unleashed Flame")
   elseif easyRotation:TotemTimeRemaining(TOTEM_FIRE)< 5
      and easyRotation:PlayerCanCastSpell("Searing Totem")     
    then
      easyRotation:UpdateRotationHinterIcon("Searing Totem")
   elseif easyRotation:PlayerCanCastSpell("Ascendance")
       and (easyRotation:UnitHasBuffRemaining("Player","Heroism") > 20
        or easyRotation:UnitHasBuffRemaining("target","Blood Lust") > 20)
      and easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") > 20
    then 
       easyRotation:UpdateRotationHinterIcon("Ascendance")
   elseif easyRotation:PlayerCanCastSpell("Flame Shock")
      and easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") < 10
       or (not easyRotation:UnitHasYourDebuff("target","Flame Shock"))       
    then 
       easyRotation:UpdateRotationHinterIcon("Flame Shock")
   elseif easyRotation:PlayerCanCastSpell("Unleash Flames")
    then
      easyRotation:UpdateRotationHinterIcon("Unleash Flames")
   elseif easyRotation:PlayerCanCastSpell("Lava Burst")
      and easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") > 1
       or easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") > 1
      and easyRotation:UnitHasBuff("player", "Lava Surge")
    then
       easyRotation:UpdateRotationHinterIcon("Lava Burst")
   elseif easyRotation:PlayerCanCastSpell("Earth Shock")
       and easyRotation:UnitHasYourBuffStacks("Player","Lightning Shield") >14
    then
       easyRotation:UpdateRotationHinterIcon("Earth Shock")
   elseif easyRotation:PlayerCanCastSpell("Earhtquake")
    then 
       easyRotation:UpdateRotationHinterIcon("Earthquake")
   elseif easyRotation:PlayerCanCastSpell("Elemental Blast")
    then
       easyRotation:UpdateRotationHinterIcon("Elemental Blast")
   elseif easyRotation:PlayerCanCastSpell("Lightning Bolt")
    then
       easyRotation:UpdateRotationHinterIcon("Lightning Bolt")
  end
end

 function easyRotation.rotations.eleSham.DecideAOESpells()
-- If the enemies are spread out, simply maintain Flame Shock on as many targets as possible
-- while performing your single target rotation on one of them.

--If enemies are in the same area, proceed as follows
-- Cast Earthquke
-- Cast Lava Beam, during Ascendance
-- Cast Earth Shock on the highest priority target when you reach 15 charges of Lightning Shield
-- Cast Thunder Storm, if there are more than 10 enemies
-- Keep Searing Totem up
-- Cast Chain Lightning as a filler.


 if easyRotation:PlayerCanCastSpell("Lightning Shield")
     and easyRotation:UnitHasBuffRemaining("Player","Lightning Shield") < 5
    then 
      easyRotation:UpdateRotationHinterIcon("Lightning Shield")
   elseif easyRotation:TotemTimeRemaining(TOTEM_FIRE)< 5
      and easyRotation:PlayerCanCastSpell("Searing Totem")     
    then
      easyRotation:UpdateRotationHinterIcon("Searing Totem")
   elseif easyRotation:PlayerCanCastSpell("Ascendance")
      and (easyRotation:UnitHasBuffRemaining("Player","Heroism") > 20
        or easyRotation:UnitHasBuffRemaining("target","Blood Lust") > 20)
      and easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") > 20
    then 
       easyRotation:UpdateRotationHinterIcon("Ascendance")
   elseif easyRotation:PlayerCanCastSpell("Earhtquake")
    then 
       easyRotation:UpdateRotationHinterIcon("Earthquake")
   elseif easyRotation:PlayerCanCastSpell("Lava Beam")
      and easyRotation:UnitHasBuffRemaining("Player","Lightning Shield") > 3
    then
      easyRotation:UpdateRotationHinterIcon("Lava Beam")
   elseif easyRotation:PlayerCanCastSpell("Unleash Flames")
    then
      easyRotation:UpdateRotationHinterIcon("Unleash Flames")
   elseif easyRotation:PlayerCanCastSpell("Flame Shock")
      and easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") < 10
    then 
       easyRotation:UpdateRotationHinterIcon("Flame Shock")
   elseif easyRotation:PlayerCanCastSpell("Lava Burst")
      and easyRotation:UnitHasYourDebuffRemaining("target","Flame Shock") > 10
    then
       easyRotation:UpdateRotationHinterIcon("Lava Burst")
   elseif easyRotation:PlayerCanCastSpell("Earth Shock")
       and easyRotation:UnitHasBuffStacks("Player","Lightning Shield") > 12
    then
       easyRotation:UpdateRotationHinterIcon("Earth Shock")
   elseif easyRotation:PlayerCanCastSpell("Thunderstrom")
    then
       easyRotation:UpdateRotationHinterIcon("Thunderstorm")
   elseif easyRotation:PlayerCanCastSpell("Chain Lightning")
    then
       easyRotation:UpdateRotationHinterIcon("Chain Lightning")
  end
end
  