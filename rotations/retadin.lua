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
 -- elseif (cmd == 'seal' and easyRotationVars.seal) then
--    easyRotationVars.seal = false
--    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking seals",1,0,0)
 --   return true
 -- elseif (cmd == 'seal' and not easyRotationVars.seal) then
 --   easyRotationVars.seal = true
--    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking seals",0,0,1)
--    return true
  elseif (cmd == 'wings' and not easyRotationVars.wings) then
    easyRotationVars.wings = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Avenging Wrath",0,1,0)
    return true
  elseif (cmd == 'wings' and easyRotationVars.wings) then
    easyRotationVars.wings = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Avenging Wrath",1,0,0)
    return true
--elseif (cmd == 'Seraphim' and easyRotationVars.Seraphim) then
--    easyRotationVars.Seraphim = false
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Seraphim",1,0,0)
 --   return true
 -- elseif (cmd == 'Seraphim' and not easyRotationVars.Seraphim) then
 --   easyRotationVars.Seraphim = true
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Seraphim",0,0,1)
 --   return true
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
  --elseif easyRotationVars.wings == "wings" then
 --   easyRotation.rotations.retadin.AvengingWrath()
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
      and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 5
      and not easyRotation:UnitHasBuff("player","Divine Purpose")        
       then easyRotation:UpdateRotationHinterIcon("Judgment")

  elseif easyRotation:PlayerCanCastSpell("Templar's Verdict")
       and not easyRotation:UnitHasBuff("player","Divine Purpose")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
       and easyRotation:GetRange("target")< 10
      then easyRotation:UpdateRotationHinterIcon("Templar's Verdict")
  
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
       then easyRotation:UpdateRotationHinterIcon("Blade of Wrath")
  
  elseif easyRotation:PlayerCanCastSpell("Blade of Wrath")
       then easyRotation:UpdateRotationHinterIcon("Blade of Wrath")

  elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
       then easyRotation:UpdateRotationHinterIcon("Crusader Strike")


--Templar's Verdict Buff (recieved after casting FV), Divine Purpose Buff (gives free FV or DS and damage as if 3 holy power), 
--Divine Crusader Buff (gives free DS)
 -- elseif easyRotationVars.storm
 --       and easyRotation:PlayerCanCastSpell("Divine Storm")
 --      and easyRotation:UnitHasBuff("player","Divine Crusader")
 --       and easyRotation:UnitHasBuff("player","Templar's Verdict")
 --       and easyRotation:GetRange("target")< 8
 --      or easyRotationVars.storm
 --       and easyRotation:GetRange("target")< 8
 --       and easyRotation:PlayerCanCastSpell("Divine Storm")
 --       and easyRotation:UnitHasBuff("player","Divine Crusader")
        --and easyRotation:UnitHasBuffRemaining("player","Divine Crusader")<3
 --      then easyRotation:UpdateRotationHinterIcon("Divine Storm")


  

  
  

   end
 end
  
 --AOE MULTIPLE TARGETS, USE SEAL OF RIGHTEOUSNESS WHEN MORE THAN 4 TARGETS ARE UP AND WILL LIVE LONGER THAN 30 SECONDS

function easyRotation.rotations.retadin.DecideAOESpells()

if easyRotation:UnitHasBuff("Thorasus")
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
    or easyRotation:PlayerCanCastSpell("Avenging Wrath")
     and easyRotation:PlayerTimeInCombat()>1
     and easyRotation:GetRange("target")< 6  
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 1 
     and not easyRotation:UnitHasBuff("player","Avenging Wrath")  
     and easyRotationVars.wings  
    or easyRotation:UnitHealthPercent("Target")< 35 
     and easyRotationVars.wings      
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 0   
       then easyRotation:UpdateRotationHinterIcon("Avenging Wrath")

 --new
  elseif easyRotationVars.storm
        and easyRotation:GetRange("target")< 8
        and easyRotation:PlayerCanCastSpell("Divine Storm")
        and easyRotation:UnitHasBuff("player","Divine Crusader")
        --and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) > 3
        and not (easyRotation:UnitHasBuff("player","Divine Purpose"))
        or easyRotation:UnitHasBuff("player","Templar's Verdict")
         and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) > 3       
         and easyRotation:PlayerCanCastSpell("Divine Storm")
         and easyRotation:GetRange("target")< 8
         and easyRotationVars.storm
       then easyRotation:UpdateRotationHinterIcon("Divine Storm") 

  
--Templar's Verdict Buff (recieved after casting FV), Divine Purpose Buff (gives free FV or DS and damage as if 3 holy power), 
--Divine Crusader Buff (gives free DS)

  elseif (easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) == 5
        and easyRotation:GetRange("target")< 10
        and easyRotation:PlayerCanCastSpell("Templar's Verdict"))
        --then easyRotation:UpdateRotationHinterIcon("Templar's Verdict")        
     or (easyRotation:GetRange("target")< 10
        and easyRotation:PlayerCanCastSpell("Templar's Verdict")
        and easyRotation:UnitHasBuff("player","Divine Purpose"))
         --then easyRotation:UpdateRotationHinterIcon("Templar's Verdict")   
     or (easyRotation:PlayerCanCastSpell("Templar's Verdict")
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)> 2
        and not (easyRotation:PlayerCanCastSpell("Crusader Strike")
        and easyRotation:PlayerCanCastSpell("Exorcism")
        and easyRotation:PlayerCanCastSpell("Execution Sentence")
        and easyRotation:PlayerCanCastSpell("Hammer of Wrath")
        and easyRotation:PlayerCanCastSpell("Judgment")))
        and easyRotation:GetRange("target")< 10        
       then easyRotation:UpdateRotationHinterIcon("Templar's Verdict")
  
  
elseif easyRotation:PlayerCanCastSpell("Judgment")
      and easyRotation:GetRange("target")< 30
       then easyRotation:UpdateRotationHinterIcon("Judgment")

    end
 end



 