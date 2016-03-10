easyRotation.rotations.boomkin = {}

function easyRotation.rotations.boomkin.init()
  local _,playerClass = UnitClass("player")
  if not easyRotationVars.trackStarfall then easyRotationVars.trackStarfall = false end
  if not easyRotationVars.trackCelestial then easyRotationVars.trackCelestial = false end
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
  else
    return false
  end
end

function easyRotation.rotations.boomkin:MoonkinForm()
  return GetShapeshiftForm() == easyRotationVars.moonkinForm
end

function easyRotation.rotations.boomkin.DecideBuffs()
if not (easyRotation:UnitHasBuff("player","Mark of the Wild")or easyRotation:UnitHasBuff("player","Blessing of Kings")) 
    --or not (easyRotation:EveryoneHasBuff("Mark of the Wild") or easyRotation:EveryoneHasBuff("Blessing of Kings"))     
    then
      easyRotation:UpdateRotationHinterIcon("Mark of the Wild")
elseif not (easyRotation:UnitHasBuff("player","Dash") and easyRotation:UnitHasBuff("player", "Cat Form"))
   and not (easyRotation:UnitHasBuff("player","Moonkin Form"))
   and easyRotation:PlayerInCombat()    
  then
   easyRotation:UpdateRotationHinterIcon("Moonkin Form")
  end
end

  
function easyRotation.rotations.boomkin.DecideSpells()
  -- macro Celestial Alignment and blessing of elune (mega boomkin) together
  -- both of these should be used on cooldown

  local eclipse_power = UnitPower("player",SPELL_POWER_ECLIPSE) -- MOON = 0 TO -100, SUN = 0 TO 100
  local direction = GetEclipseDirection()
if easyRotation:PlayerTimeInCombat()<1 and easyRotation:PlayerCanCastSpell("Starfire")
  then easyRotation:UpdateRotationHinterIcon("Starfire")
-- CELESTIAL ALIGNMENT
elseif easyRotationVars.trackCelestial and easyRotation:PlayerCanCastSpell("Celestial Alignment")
   and eclipse_power < -85
   and not easyRotation:IsMoving()
  then
   easyRotation:UpdateRotationHinterIcon("Celestial Alignment")
-- NATURES VIGIL
elseif easyRotation:PlayerCanCastSpell("Nature's Vigil")
   and not easyRotation:PlayerCanCastSpell("Celestial Alignment")
  then
   easyRotation:UpdateRotationHinterIcon("Nature's Vigil") 
-- STELLAR FLARE
elseif easyRotation:PlayerCanCastSpell("Stellar Flare") 
   and ((eclipse_power > -5 and eclipse_power < 5)
   and not easyRotation:UnitHasDebuff("target", "Stellar Flare"))
   or easyRotation:PlayerCanCastSpell("Stellar Flare") and easyRotation:UnitHasDebuffRemaining("target", "Stellar Flare") < 5 
 then 
   easyRotation:UpdateRotationHinterIcon("Stellar Flare")
--Starsurge
 elseif (easyRotation:GetPlayerSpellCharges("Starsurge")> 2 and easyRotation:IsMoving())
    or (eclipse_power <-80 and easyRotation:PlayerCanCastSpell("Starsurge")and easyRotation:GetPlayerSpellCharges("Starsurge")>1 and not easyRotation:UnitHasBuff("player","Lunar Empowerment"))
    or (eclipse_power > 80 and easyRotation:PlayerCanCastSpell("Starsurge")and easyRotation:GetPlayerSpellCharges("Starsurge")>1 and not easyRotation:UnitHasBuff("player","Solar Empowerment")) 
    or (easyRotation:GetPlayerSpellCharges("Starsurge")> 2 and easyRotation:PlayerCanCastSpell("Starsurge")) 
    then 
    easyRotation:UpdateRotationHinterIcon("Starsurge")
-- MOONFIRE   
elseif (easyRotation:IsMoving() and eclipse_power < -1) 
    or (easyRotation:UnitHasBuff("player", "Lunar Peak") or easyRotation:IsMoving() or (eclipse_power <-1 and not (easyRotation:UnitHasDebuff("target", "Moonfire"))))
    or (easyRotation:UnitHasDebuffRemaining("target","Moonfire")<-5 and eclipse_power >-10 and direction == sun)
    then  
    easyRotation:UpdateRotationHinterIcon("Moonfire")
--SUNFIRE
elseif (easyRotation:IsMoving() and eclipse_power > 1)      
    or (easyRotation:UnitHasBuff("player","Solar Peak") or easyRotation:IsMoving() or (eclipse_power > 1 and not (easyRotation:UnitHasDebuff("target", "Sunfire"))))
    or (easyRotation:UnitHasDebuffRemaining("target", "Sunfire")<5 and eclipse_power < 10 and direction == moon)
    then  
    easyRotation:UpdateRotationHinterIcon("Sunfire")
-- STARFALL
elseif easyRotationVars.mode == "AOE" 
    and (eclipse_power >= 85
      or eclipse_power <= -85)
    and easyRotation:PlayerCanCastSpell("Starfall")
    and not easyRotation:UnitHasBuff("player", "Starfall")
    or (((easyRotation:UnitHasBuff("player", "Lunar Empowerment") and eclipse_power <-1) or (easyRotation:UnitHasBuff("player", "Solar Empowerment")and eclipse_power >1)) 
         and easyRotation:GetPlayerSpellCharges("Starsurge")>1 and easyRotationVars.mode == "AOE" and not (easyRotation:UnitHasBuff("player","Starfall")
         or easyRotation:UnitHasBuff("player","Sunfall")))
    then 
    easyRotation:UpdateRotationHinterIcon("Starfall")

-- STARFIRE
elseif (easyRotation:IsPassiveSpell("Euphoria") 
        and (eclipse_power <-50 and direction == "sun" or eclipse_power < 50 and direction == "moon"))
    or not easyRotation:IsPassiveSpell("Euphoria") and (eclipse_power <-40 and direction == "sun" or eclipse_power < 20 and direction == "moon")    
    or not easyRotation:IsPassiveSpell("Euphoria") and (easyRotation:UnitHasYourBuffStacks("player", "Lunar Empowerment")>0 and eclipse_power <-70 and direction == "sun")
    or not easyRotation:IsPassiveSpell("Euphoria") and (easyRotation:UnitHasYourBuffStacks("player", "Lunar Empowerment")>0 and eclipse_power < 70 and direction == "moon") 
    then
    easyRotation:UpdateRotationHinterIcon("Starfire")
-- WRATH
elseif (easyRotation:IsPassiveSpell("Euphoria") 
        and (eclipse_power >-50 and direction == "sun" or eclipse_power > 70 and direction == "moon"))
    or not easyRotation:IsPassiveSpell("Euphoria") and (eclipse_power > -40 and direction == "sun" or eclipse_power > 33 and direction == "moon")
    or not easyRotation:IsPassiveSpell("Euphoria") and (easyRotation:UnitHasYourBuffStacks("player", "Solar Empowerment")>0 and eclipse_power > -70 and direction == "sun")
    or not easyRotation:IsPassiveSpell("Euphoria") and (easyRotation:UnitHasYourBuffStacks("player", "Solar Empowerment")>0 and eclipse_power > 70 and direction == "moon")
    then
    easyRotation:UpdateRotationHinterIcon("Wrath")
-- STARSURGE You need to spend  Starsurge charges often. Remember that you have two sources of charges for  Starsurge:
 --Starsurge naturally recharges one charge every thirty seconds.
--Shooting Stars procs from  Moonfire and  Sunfire refresh one charge each.
--If Shooting Stars procs and caps you at three charges, your natural recharge stops and resets when you cast  Starsurge again. 
--You want to keep yourself at one charge by:
--Casting  Starsurge right before natural recharge puts you at two, if you do not have  Lunar Empowerment or  Solar Empowerment active.
--Casting  Starsurge when you proc Shooting Stars but do not have  Lunar Empowerment or  Solar Empowerment.
--If you do cap on  Starsurge, immediately cast it if you have no empowerments.
--If you cap on  Starsurge but have either  Lunar Empowerment or  Solar Empowerment active, you'll instead want to cast  Starfall.
--If at any time you should cast  Starsurge but cannot, use  Starfall in its place.

--Going beyond this, you'll want to maximize  Starsurge usage during  Celestial Alignment and trinket procs, like so:
--Let yourself reach two charges of  Starsurge right before you have  Celestial Alignment off cooldown during a lunar phase. 
--This means you may be waiting on  Celestial Alignment to come off or you may simply be waiting to get out of solar. 
--Dump all charges on  Starfire.
--Dump all  Starsurge charges during trinkets, unless  Celestial Alignment is going to come off Cooldown (see above). 
--This is unnecessary for a haste proc. Mastery or Spell Power procs should be preferred.
end
end
