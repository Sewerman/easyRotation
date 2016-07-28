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

--function easyRotation:BurnphaseBoomkin()
--if easyRotationVars.LunarStrike == false then
--    return nil
--   else   
 --   local _start = easyRotationVars.LunarStrike and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment") ==3
--    local _end = easyRotationVars.LunarStrike and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment") ==0
--     for i=3,1 do
--      easyRotation:UpdateRotationHinterIcon("Lunar Strike")
--  end 
-- end

  
function easyRotation.rotations.boomkin.DecideSpells()
local dumpStacks = false

-- begin if logic
if not dumpStacks and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment") > 2 then
 dumpStacks = true
elseif dumpStacks and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment") < 1 then
 dumpStacks = false
elseif dumpStacks then
   easyRotation:UpdateRotationHinterIcon("Lunar Strike") 

elseif easyRotation:PlayerCanCastSpell("Lunar Strike")
   and not easyRotationVars.LunarStrike
   and easyRotation:UnitHasBuffStacks("player", "Lunar Empowerment") > 0
  then easyRotation:UpdateRotationHinterIcon("Lunar Strike")      
   
elseif easyRotation:PlayerCanCastSpell("Moonfire")
   and not easyRotation:UnitHasDebuff("target","Moonfire")
    or easyRotation:UnitHasDebuffRemaining("target", "Moonfire") < 4
  then easyRotation:UpdateRotationHinterIcon("Moonfire")

elseif easyRotation:PlayerCanCastSpell("Sunfire")
   and not easyRotation:UnitHasDebuff("target","Sunfire")
    or easyRotation:UnitHasDebuffRemaining("target", "Sunfire") < 4
  then easyRotation:UpdateRotationHinterIcon("Sunfire")

elseif easyRotation:PlayerCanCastSpell("Stellar Flare")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 150
   and not easyRotation:UnitHasDebuff("target","Stellar Flare")
    or easyRotation:UnitHasDebuffRemaining("target", "Stellar Flare") < 4
    and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 150
  then easyRotation:UpdateRotationHinterIcon("Stellar Flare")

elseif easyRotation:PlayerCanCastSpell("Starsurge")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)> 550
  then easyRotation:UpdateRotationHinterIcon("Starsurge")

elseif easyRotation:PlayerCanCastSpell("Solar Wrath")
   and easyRotation:GetPlayerResource(SPELL_POWER_LUNAR_POWER)< 550
  then easyRotation:UpdateRotationHinterIcon("Solar Wrath")




  
end
end
