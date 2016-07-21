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
  elseif (cmd == 'seal' and easyRotationVars.seal) then
    easyRotationVars.seal = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking seals",1,0,0)
    return true
  elseif (cmd == 'seal' and not easyRotationVars.seal) then
    easyRotationVars.seal = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking seals",0,0,1)
    return true
  elseif (cmd == 'HW' and easyRotationVars.HolyWrath) then
    easyRotationVars.HolyWrath = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Holy Wrath",1,0,0)
    return true
  elseif (cmd == 'HW' and not easyRotationVars.HolyWrath) then
    easyRotationVars.HolyWrath = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Holy Wrath",0,0,1)
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
  local base, posBuff, negBuff = UnitAttackPower("player")
  local ap = base + posBuff - negBuff
  local healthDeficit = UnitHealthMax("player") - UnitHealth("player")
  local Impseals = easyRotation:IsPassiveSpell("Empowered Seals")

  -- taunt or salv
--  if easyRotation.currentTauntTarget ~= nil then
--    print("taunt "..UnitName(easyRotation.currentTauntTarget))
--  end
--  if easyRotation.currentTauntTarget ~= nil then
--    print("salv "..UnitName(easyRotation.currentSalvTarget))
  --end
  --     or

  if easyRotationVars.mode == "Single Target" then
if Impseals 
        and not easyRotation:UnitHasBuff("player","Liadrin's Righteousness")
        and easyRotation:UnitHealthPercent("player") > 50
        and (easyRotation:GetShapeshiftForm()>1
        or easyRotation:GetShapeshiftForm()<1)
        and easyRotation:PlayerInCombat()
        or easyRotation:UnitHasBuffRemaining("player", "Liadrin's Righteousness") < 10
        and (easyRotation:GetShapeshiftForm()>1
        or easyRotation:GetShapeshiftForm()<1)
        and easyRotation:PlayerInCombat()
      then easyRotation:UpdateRotationHinterIcon("Seal of Righteousness") 
   
   elseif Impseals
        and easyRotation:UnitHasBuff("player","Liadrin's Righteousness")
        and easyRotation:UnitHealthPercent("player") < 50
        and (easyRotation:GetShapeshiftForm()>2
        or easyRotation:GetShapeshiftForm()<2)
        and easyRotation:PlayerInCombat()
        or easyRotation:UnitHasBuffRemaining("player", "Liadrin's Righteousness") < 10
        and (easyRotation:GetShapeshiftForm()>1
        or easyRotation:GetShapeshiftForm()<1)
        and easyRotation:PlayerInCombat()
      then easyRotation:UpdateRotationHinterIcon("Seal of Insight") 

   elseif easyRotation:PlayerCanCastSpell("Word of Glory")
        and UnitPower("player",SPELL_POWER_HOLY_POWER) >= 4
        and easyRotation:UnitHealthPercent("player") < 50
        and easyRotation:UnitHasBuff("player","Bastion of Glory")
      then  
      easyRotation:UpdateRotationHinterIcon("Word of Glory") 
   
   elseif (UnitPower("player",SPELL_POWER_HOLY_POWER) >= 4 
        and easyRotationVars.wog 
        and easyRotation:UnitHealthPercent("player") < 30) 
      then
      easyRotation:UpdateRotationHinterIcon("Word of Glory") 
 
   elseif not easyRotation:UnitHasYourBuff("player","Sacred Shield")
        and easyRotation:PlayerCanCastSpell("Sacred Shield") 
       then
      easyRotation:UpdateRotationHinterIcon("Sacred Shield")
  
   elseif easyRotationVars.AvengersShield 
        and easyRotation:PlayerCanCastSpell("Avenger's Shield")
        and easyRotation:GetRange("target") < 29 
       then
      easyRotation:UpdateRotationHinterIcon("Avenger's Shield") 
  
   elseif easyRotation:PlayerCanCastSpell("Shield of the Righteous") 
        and UnitPower("player",SPELL_POWER_HOLY_POWER) >= 5
        and easyRotation:UnitHealthPercent("player") > 35
        and easyRotation:GetRange("target") < 6 
       then
      easyRotation:UpdateRotationHinterIcon("Shield of the Righteous")

   elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
        and easyRotation:GetRange("target") < 6 
       then
      easyRotation:UpdateRotationHinterIcon("Crusader Strike") 

   elseif easyRotation:UnitHealthPercent("target") < 20 
       and easyRotation:PlayerCanCastSpell("Hammer of Wrath")                   
       and easyRotation:GetRange("target") < 29 
      then
      easyRotation:UpdateRotationHinterIcon("Hammer of Wrath") 
    
   elseif easyRotation:PlayerCanCastSpell("Execution Sentence")
      then
      easyRotation:UpdateRotationHinterIcon("Execution Sentence")

   elseif easyRotation:PlayerCanCastSpell("Light's Hammer")
      then
      easyRotation:UpdateRotationHinterIcon("Light's Hammer")

   elseif easyRotation:PlayerCanCastSpell("Holy Prism")
       and easyRotation:GetRange("target") < 40
      then
      easyRotation:UpdateRotationHinterIcon("Holy Prism")

   elseif easyRotation:PlayerCanCastSpell("Holy Wrath")
        and easyRotationVars.HolyWrath
        and easyRotation:GetRange("target") < 10 
        and easyRotation:UnitManaPercent("player") > 35 
       then
      easyRotation:UpdateRotationHinterIcon("Holy Wrath")

   elseif easyRotation:PlayerCanCastSpell("Judgment")
        and easyRotation:GetRange("target") < 29 
       then
      easyRotation:UpdateRotationHinterIcon("Judgment")   
      
   elseif easyRotation:PlayerCanCastSpell("Consecration")
       and easyRotation:GetRange("target") < 6 
      then
      easyRotation:UpdateRotationHinterIcon("Consecration")

    end
   elseif easyRotationVars.mode == "AOE" then
    -- Area of Effect (AoE) 5.0 (updated)
    -- pop your shield, run in and pull with AS and JUDGE
    -- the priority system is based on the spell that does the most dps per action
    -- AS>J>SOR>HOR>HOW>C>HW
    -- macro Holy Avenger and Avenging Wrath to your major abilities
    -- HV & AW should be used always on cd, hence the macros

    -- self preservation <20% or is tracking wog <50%
 if easyRotation:PlayerCanCastSpell("Word of Glory")
        and UnitPower("player",SPELL_POWER_HOLY_POWER) >= 4
        and easyRotation:UnitHealthPercent("player") < 35
          and easyRotation:UnitHasBuff("player","Bastion of Glory")
      then
      easyRotation:UpdateRotationHinterIcon("Word of Glory")

   elseif (UnitPower("player",SPELL_POWER_HOLY_POWER) >= 4 
        and easyRotationVars.wog 
        and easyRotation:UnitHealthPercent("player") < 30) 
      then
      easyRotation:UpdateRotationHinterIcon("Word of Glory") 

   elseif easyRotationVars.AvengersShield  
        and easyRotation:PlayerCanCastSpell("Avenger's Shield")
        and easyRotation:GetRange("target") < 29
         or easyRotationVars.AvengersShield 
         and easyRotation:UnitHasBuff("player","Grand Crusader")
         and easyRotation:GetRange("target") < 29
         and UnitPower("player",SPELL_POWER_HOLY_POWER) <5
       then
      easyRotation:UpdateRotationHinterIcon("Avenger's Shield")

   elseif easyRotation:PlayerCanCastSpell("Shield of the Righteous") 
        and UnitPower("player",SPELL_POWER_HOLY_POWER) >= 5
        and easyRotation:UnitHealthPercent("player") > 35
        and easyRotation:GetRange("target") < 6 
       then
      easyRotation:UpdateRotationHinterIcon("Shield of the Righteous")

   elseif not easyRotation:UnitHasYourBuff("player","Sacred Shield")
        and easyRotation:PlayerCanCastSpell("Sacred Shield")
       then
      easyRotation:UpdateRotationHinterIcon("Sacred Shield")

   elseif easyRotation:PlayerCanCastSpell("Consecration")
        and easyRotation:GetRange("target") < 6 
       then
      easyRotation:UpdateRotationHinterIcon("Consecration")

   elseif easyRotation:PlayerCanCastSpell("Hammer of the Righteous")
        and easyRotation:GetRange("target") < 6 
       then
      easyRotation:UpdateRotationHinterIcon("Hammer of the Righteous")

   elseif easyRotation:PlayerCanCastSpell("Holy Wrath")
        and easyRotationVars.HolyWrath
        and easyRotation:GetRange("target") < 10 
        --and easyRotation:UnitManaPercent("player") > 35 
       then
      easyRotation:UpdateRotationHinterIcon("Holy Wrath")
 
   elseif easyRotation:UnitHealthPercent("target") < 20 
        and easyRotation:PlayerCanCastSpell("Hammer of Wrath")                   
        and easyRotation:GetRange("target") < 29 
      then
      easyRotation:UpdateRotationHinterIcon("Hammer of Wrath") 
    
   elseif easyRotation:PlayerCanCastSpell("Judgment")
        and easyRotation:GetRange("target") < 29 
      then
      easyRotation:UpdateRotationHinterIcon("Judgment") 

   elseif easyRotation:PlayerCanCastSpell("Holy Prism")
        and easyRotation:GetRange("target") < 40        
      then
      easyRotation:UpdateRotationHinterIcon("Holy Prism")

   elseif easyRotation:PlayerCanCastSpell("Execution Sentence")
      then
      easyRotation:UpdateRotationHinterIcon("Execution Sentence")

   elseif easyRotation:PlayerCanCastSpell("Light's Hammer")
          and easyRotation:IsMouseOverCenterOfScreen()
          and easyRotation:GetRange("target") < 6
      then
      easyRotation:UpdateRotationHinterIcon("Light's Hammer")    
 
   elseif easyRotation:PlayerCanCastSpell("Hammer of the Righteous")
          and easyRotation:GetRange("target") < 6 
       then
      easyRotation:UpdateRotationHinterIcon("Hammer of the Righteous")      

    end
   end
  end


