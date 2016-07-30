easyRotation.rotations.boomkin = {}

function easyRotation.rotations.boomkin.init()
  local _,playerClass = UnitClass("player")
  if not easyRotationVars.trackStarfall then easyRotationVars.trackStarfall = false end
  if not easyRotationVars.trackCelestial then easyRotationVars.trackCelestial = false end
  if not easyRotationVars.LunarStrike then easyRotationVars.LunarStrike = false end
  return playerClass == "DRUID" and GetSpecialization() == 1 
end


function easyRotation.rotations.boomkin.Slash(cmd,val)
  if (cmd == 'sf' and not easyRotationVars.trackStarfall) then
    easyRotationVars.trackStarfall = true;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Starfall",0,1,0);
    return true
  elseif (cmd == 'sf' and easyRotationVars.trackStarfall) then
    easyRotationVars.trackStarfall = false;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Starfall",1,0,0);
    return true
elseif (cmd == 'ca' and not easyRotationVars.trackCelestial) then
    easyRotationVars.trackCelestial = true;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Celestial Alignment",0,1,0);
    return true
  elseif (cmd == 'ca' and easyRotationVars.trackCelestial) then
    easyRotationVars.trackCelestial = false;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Celestial Alignment",1,0,0);
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",1,0,0)
    return true
elseif (cmd == 'ls' and not easyRotationVars.LunarStrike) then
    easyRotationVars.LunarStrike = true;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Lunar Strike",0,1,0);
    return true
  elseif (cmd == 'ls' and easyRotationVars.LunarStrike) then
    easyRotationVars.LunarStrike = false;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Lunar Strike",1,0,0);
    return true
  else
    return false
  end
end

function easyRotation.rotations.boomkin:MoonkinForm()
  return GetShapeshiftForm() == easyRotationVars.moonkinForm
end

function easyRotation.rotations.boomkin.DecideBuffs()

if not (easyRotation:UnitHasBuff("player","Dash") and easyRotation:UnitHasBuff("player", "Cat Form"))
   and not (easyRotation:UnitHasBuff("player","Moonkin Form"))
   and easyRotation:PlayerInCombat()    
  then
   easyRotation:UpdateRotationHinterIcon("Moonkin Form")
  end
end

  
function easyRotation.rotations.boomkin.DecideSpells()
  if easyRotationVars.mode == "Single Target" then
    easyRotation.rotations.boomkin.DecideSingleTargetSpells()
  elseif easyRotationVars.mode == "AOE" then
    easyRotation.rotations.boomkin.DecideAOESpells()
  end
end

function easyRotation.rotations.boomkin.DecideSingleTargetSpells()

if not easyRotation:IsMoving() 
   and easyRotation:PlayerCanCastSpell("Lunar Strike")
   and not easyRotationVars.LunarStrike
   and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment") > 0
  or easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment")>2
  or easyRotationVars.LunarStrike
     and not easyRotation:SpellNotCastRecently("Lunar Strike") 
     and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment")>0 
  then easyRotation:UpdateRotationHinterIcon("Lunar Strike") 

elseif easyRotationVars.trackCelestial 
   and easyRotation:UnitHasYourDebuff("target","Moonfire")
   and easyRotation:UnitHasYourDebuff("target","Sunfire")
   and easyRotation:UnitHasYourDebuff("target","Stellar Flare")
   and easyRotation:PlayerCanCastSpell("Celestial Alignment")
  then easyRotation:UpdateRotationHinterIcon("Celestial Alignment")
   
elseif easyRotation:PlayerCanCastSpell("Moonfire")
   and (easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment")>0 
            and not easyRotation:SpellNotCastRecently("Lunar Strike"))
   and not easyRotation:UnitHasYourDebuff("target","Moonfire")
    or easyRotation:UnitHasYourDebuffRemaining("target", "Moonfire") < 4
    or easyRotation:IsMoving() 
  then easyRotation:UpdateRotationHinterIcon("Moonfire")

elseif easyRotation:PlayerCanCastSpell("Sunfire")
   and (easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment")>0 
          and not easyRotation:SpellNotCastRecently("Lunar Strike"))
   and not easyRotation:UnitHasYourDebuff("target","Sunfire")
    or easyRotation:UnitHasYourDebuffRemaining("target", "Sunfire") < 4
  then easyRotation:UpdateRotationHinterIcon("Sunfire")

elseif not easyRotation:IsMoving() 
   and easyRotation:PlayerCanCastSpell("Stellar Flare")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 150
   and not easyRotation:UnitHasYourDebuff("target","Stellar Flare")
   and easyRotation:SpellNotCastRecently("Stellar Flare")
    or easyRotation:UnitHasYourDebuffRemaining("target", "Stellar Flare") < 4
    and easyRotation:SpellNotCastRecently("Stellar Flare")
    and (easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment")>0
          and not easyRotation:SpellNotCastRecently("Lunar Strike"))
    and not easyRotation:IsMoving()  
    and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 150
  then easyRotation:UpdateRotationHinterIcon("Stellar Flare")

elseif easyRotation:PlayerCanCastSpell("Starsurge")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 500
  or easyRotation:IsMoving() 
   and easyRotation:PlayerCanCastSpell("Starsurge")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 500
  then easyRotation:UpdateRotationHinterIcon("Starsurge")

elseif not easyRotation:IsMoving() 
   and easyRotation:PlayerCanCastSpell("Solar Wrath")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)< 500
  then easyRotation:UpdateRotationHinterIcon("Solar Wrath")

 end
end


 function easyRotation.rotations.boomkin.DecideAOESpells()

if easyRotationVars.trackCelestial 
   and easyRotation:UnitHasYourDebuff("target","Moonfire")
   and easyRotation:UnitHasYourDebuff("target","Sunfire")
   and easyRotation:UnitHasYourDebuff("target","Stellar Flare")
   and easyRotation:PlayerCanCastSpell("Celestial Alignment")
  then easyRotation:UpdateRotationHinterIcon("Celestial Alignment")
   
elseif easyRotation:PlayerCanCastSpell("Moonfire")
   and not easyRotation:UnitHasYourDebuff("target","Moonfire")
    or easyRotation:UnitHasYourDebuffRemaining("target", "Moonfire") < 4
    or easyRotation:IsMoving() 
  then easyRotation:UpdateRotationHinterIcon("Moonfire")

elseif easyRotation:PlayerCanCastSpell("Sunfire")
    and not easyRotation:UnitHasYourDebuff("target","Sunfire")
    or easyRotation:UnitHasYourDebuffRemaining("target", "Sunfire") < 4
  then easyRotation:UpdateRotationHinterIcon("Sunfire")

elseif not easyRotation:IsMoving() 
   and easyRotation:PlayerCanCastSpell("Stellar Flare")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 150
   and not easyRotation:UnitHasYourDebuff("target","Stellar Flare")
   and easyRotation:SpellNotCastRecently("Stellar Flare")
    or easyRotation:UnitHasYourDebuffRemaining("target", "Stellar Flare") < 4
    and easyRotation:SpellNotCastRecently("Stellar Flare")
    and not easyRotation:IsMoving()  
    and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 150
  then easyRotation:UpdateRotationHinterIcon("Stellar Flare")

elseif easyRotation:IsMouseOverTarget()
       and easyRotation:GetRange("target")<=45 
   and easyRotation:PlayerCanCastSpell("Starfall")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 600
  or easyRotation:IsMoving()
   and easyRotation:IsMouseOverTarget()
   and easyRotation:GetRange("target")<=45 
   and easyRotation:PlayerCanCastSpell("Starfall")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 600
  then easyRotation:UpdateRotationHinterIcon("Starfall")

elseif not easyRotation:IsMoving() 
   and easyRotation:PlayerCanCastSpell("Lunar Strike")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)< 600
  then easyRotation:UpdateRotationHinterIcon("Lunar Strike")

  end
 end