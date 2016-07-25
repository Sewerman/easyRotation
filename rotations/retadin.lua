 easyRotation.rotations.retadin = {}

function easyRotation.rotations.retadin.init()
  local _,playerClass = UnitClass("player") 
  if not easyRotationVars.AOE then easyRotationVars.AOE = "Single Target" end
  --if not easyRotationVars.seal then easyRotationVars.seal = true end
  if not easyRotationVars.wings then easyRotationVars.wings = false end
  if not easyRotationVars.storm then easyRotationVars.storm = false end
  return playerClass == "PALADIN" and GetSpecialization() == 3 
end

function easyRotation.rotations.retadin.Slash(cmd,val)
  if (cmd == 'AOE' and easyRotationVars.AOE == "Single Target") then
    easyRotationVars.AOE = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE",0,1,0)
    return true
 elseif (cmd == 'AOE' and easyRotationVars.AOE  == "AOE") then
   easyRotationVars.AOE = "Single Target"
   DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target",1,0,0)
    return true
  elseif (cmd == 'wings' and not easyRotationVars.wings) then
    easyRotationVars.wings = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Avenging Wrath",0,1,0)
    return true
  elseif (cmd == 'wings' and easyRotationVars.wings) then
    easyRotationVars.wings = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Avenging Wrath",1,0,0)
    return true
elseif (cmd == 'storm' and not easyRotationVars.storm) then
    easyRotationVars.storm = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Divine Storm",0,1,0)
    return true
  elseif (cmd == 'storm' and easyRotationVars.storm) then
    easyRotationVars.storm = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Divine Storm",1,0,0)
    return true
  else
    return false
  end
end

function easyRotation.rotations.retadin.DecideBuffs()
end
function easyRotation.rotations.retadin.DecideSpells()
  if easyRotationVars.AOE == "Single Target" then
    easyRotation.rotations.retadin.DecideSingleTargetSpells()
 elseif easyRotationVars.AOE == "AOE" then
    easyRotation.rotations.retadin.DecideAOESpells() 
elseif easyRotationVars.wings == "wings" then
     easyRotation.rotations.retadin.AvengingWrath()
  end
end

function easyRotation.rotations.retadin.DecideSingleTargetSpells()

if easyRotation:UnitHasBuff("player","Thorasus")
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
     and easyRotation:PlayerTimeInCombat()>1
     and easyRotation:GetRange("target")< 6  
     or easyRotationVars.wings 
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 1 
     and not easyRotation:UnitHasBuff("player","Avenging Wrath")  
     or  easyRotation:UnitHealthPercent("Target")< 35 
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
     and not easyRotation:UnitHasBuff("player","Avenging Wrath")
     or  easyRotationVars.wings      
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 0   
       then easyRotation:UpdateRotationHinterIcon("Avenging Wrath")

  elseif easyRotation:PlayerCanCastSpell("Justicar's Vengeance")
        and easyRotation:UnitHasBuff("player","Divine Purpose")
        and easyRotation:GetRange("target") < 6
       then easyRotation:UpdateRotationHinterIcon("Justicar's Vengeance")

  elseif easyRotation:PlayerCanCastSpell("Judgment")
      and easyRotation:GetRange("target")< 30
      and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
      and not easyRotation:UnitHasBuff("player","Divine Purpose")        
       then easyRotation:UpdateRotationHinterIcon("Judgment")

  elseif easyRotation:PlayerCanCastSpell("Templar's Verdict")
       and not easyRotation:UnitHasBuff("player","Divine Purpose")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
       and easyRotation:GetRange("target")< 10
       and easyRotationVars.AOE
      then easyRotation:UpdateRotationHinterIcon("Templar's Verdict")

  elseif easyRotation:PlayerCanCastSpell("Divine Storm")
       and not easyRotation:UnitHasBuff("player","Divine Purpose")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
       and easyRotation:GetRange("target")< 10
       and not easyRotationVars.AOE
      then easyRotation:UpdateRotationHinterIcon("Divine Storm")
  
  elseif easyRotation:PlayerCanCastSpell("Templar's Verdict")
       and not easyRotation:UnitHasBuff("player","Divine Purpose")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)>3
       and easyRotation:UnitHasBuff("player","The Fires of Justice")
       and easyRotation:GetRange("target")< 10
      then easyRotation:UpdateRotationHinterIcon("Templar's Verdict")

  elseif easyRotation:PlayerCanCastSpell("Execution Sentence")
      and easyRotation:GetRange("target")< 40
        then easyRotation:UpdateRotationHinterIcon("Execution Sentence")

   elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
        and easyRotation:GetRange("target")< 5
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 0
        or easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) ==3 
        and not easyRotation:PlayerCanCastSpell("Blade of Wrath")       
       then easyRotation:UpdateRotationHinterIcon("Crusader Strike")

  elseif easyRotation:PlayerCanCastSpell("Blade of Wrath")
        and easyRotation:GetRange("target")< 12
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 1
        or easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 3
        and not easyRotation:PlayerCanCastSpell("Crusader Strike")
       then easyRotation:UpdateRotationHinterIcon("Blade of Wrath")
  
  elseif easyRotation:PlayerCanCastSpell("Blade of Wrath")
       then easyRotation:UpdateRotationHinterIcon("Blade of Wrath")

  elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
       then easyRotation:UpdateRotationHinterIcon("Crusader Strike")
 

   end
 end
 
function easyRotation.rotations.retadin.DecideAOESpells()

if easyRotation:UnitHasBuff("player","Thorasus")
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
     and easyRotation:PlayerTimeInCombat()>1
     and easyRotation:GetRange("target")< 6  
     or easyRotationVars.wings 
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 1 
     and not easyRotation:UnitHasBuff("player","Avenging Wrath")  
     or  easyRotation:UnitHealthPercent("Target")< 35 
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
     and not easyRotation:UnitHasBuff("player","Avenging Wrath")
     or  easyRotationVars.wings      
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 0   
       then easyRotation:UpdateRotationHinterIcon("Avenging Wrath")

  elseif easyRotation:PlayerCanCastSpell("Consecration")
        and not easyRotation:UnitHasBuff("player","Divine Purpose")
        and easyRotation:GetRange("target") < 6
       then easyRotation:UpdateRotationHinterIcon("Consecration")

  elseif easyRotation:PlayerCanCastSpell("Justicar's Vengeance")
        and easyRotation:UnitHasBuff("player","Divine Purpose")
        and easyRotation:GetRange("target") < 6
       then easyRotation:UpdateRotationHinterIcon("Justicar's Vengeance")

  elseif easyRotation:PlayerCanCastSpell("Judgment")
      and easyRotation:GetRange("target")< 30
      and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
      and not easyRotation:UnitHasBuff("player","Divine Purpose")        
       then easyRotation:UpdateRotationHinterIcon("Judgment")

  elseif easyRotation:PlayerCanCastSpell("Divine Storm")
       and not easyRotation:UnitHasBuff("player","Divine Purpose")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
       and easyRotation:GetRange("target")< 10
      then easyRotation:UpdateRotationHinterIcon("Divine Storm")
  
  elseif easyRotation:PlayerCanCastSpell("Divine Storm")
       and not easyRotation:UnitHasBuff("player","Divine Purpose")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)>3
       and easyRotation:UnitHasBuff("player","The Fires of Justice")
       and easyRotation:GetRange("target")< 10
      then easyRotation:UpdateRotationHinterIcon("Divine Storm")
  
   elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
        and easyRotation:GetRange("target")< 5
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 0
        or easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) ==3 
        and not easyRotation:PlayerCanCastSpell("Blade of Wrath")       
       then easyRotation:UpdateRotationHinterIcon("Crusader Strike")

  elseif easyRotation:PlayerCanCastSpell("Blade of Wrath")
        and easyRotation:GetRange("target")< 12
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 1
        or easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 3
        and not easyRotation:PlayerCanCastSpell("Crusader Strike")
       then easyRotation:UpdateRotationHinterIcon("Blade of Wrath")
  
  elseif easyRotation:PlayerCanCastSpell("Blade of Wrath")
       then easyRotation:UpdateRotationHinterIcon("Blade of Wrath")

  elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
       then easyRotation:UpdateRotationHinterIcon("Crusader Strike")
 
 end
end

 