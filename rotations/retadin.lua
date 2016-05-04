 easyRotation.rotations.retadin = {}

function easyRotation.rotations.retadin.init()
  local _,playerClass = UnitClass("player") 
  if not easyRotationVars.AOE then easyRotationVars.AOE = "Single Target" end
  if not easyRotationVars.seal then easyRotationVars.seal = true end
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
  elseif (cmd == 'seal' and easyRotationVars.seal) then
    easyRotationVars.seal = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking seals",1,0,0)
    return true
  elseif (cmd == 'seal' and not easyRotationVars.seal) then
    easyRotationVars.seal = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking seals",0,0,1)
    return true
  elseif (cmd == 'wings' and not easyRotationVars.wings) then
    easyRotationVars.wings = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Avenging Wrath",0,1,0)
    return true
  elseif (cmd == 'wings' and easyRotationVars.wings) then
    easyRotationVars.wings = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Avenging Wrath",1,0,0)
    return true
elseif (cmd == 'Seraphim' and easyRotationVars.Seraphim) then
    easyRotationVars.Seraphim = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Seraphim",1,0,0)
    return true
  elseif (cmd == 'Seraphim' and not easyRotationVars.Seraphim) then
    easyRotationVars.Seraphim = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Seraphim",0,0,1)
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
  --elseif easyRotationVars.wings == "wings" then
 --   easyRotation.rotations.retadin.AvengingWrath()
  end
end

function easyRotation.rotations.retadin.DecideSingleTargetSpells()
    local Seraphim = easyRotation:IsUsableSpell("Seraphim") 
    local Impseals = easyRotation:IsPassiveSpell("Empowered Seals") 
    local FinalV = easyRotation:IsUsableSpell("Final Verdict")

 if easyRotationVars.seal 
   --  and not easyRotation:IsPassiveSpell("Empowered Seals")
     and (easyRotation:GetShapeshiftForm()>1
         or easyRotation:GetShapeshiftForm()<1) 
       then easyRotation:UpdateRotationHinterIcon("Seal of Truth") 

elseif FinalV 
     and easyRotation:UnitHasBuff("player","Thorasus")
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
    or FinalV
     and easyRotation:PlayerCanCastSpell("Avenging Wrath")
     and easyRotation:PlayerTimeInCombat()>1
     and easyRotation:GetRange("target")< 6  
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 1 
     and not easyRotation:UnitHasBuff("player","Avenging Wrath")  
     and easyRotationVars.wings  
    or FinalV
     and easyRotation:UnitHealthPercent("Target")< 35 
     and easyRotationVars.wings      
     and not easyRotation:UnitHasBuff("player","Avenging Wrath") 
     and easyRotation:GetPlayerSpellCharges("Avenging Wrath")> 0   
       then easyRotation:UpdateRotationHinterIcon("Avenging Wrath")

  elseif easyRotation:PlayerCanCastSpell("Final Verdict")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
       and easyRotation:GetRange("target")< 10
      then easyRotation:UpdateRotationHinterIcon("Final Verdict")

  elseif easyRotation:PlayerCanCastSpell("Execution Sentence")
      and easyRotation:GetRange("target")< 40
        then easyRotation:UpdateRotationHinterIcon("Execution Sentence")

  elseif easyRotation:PlayerCanCastSpell("Light's Hammer")
       and easyRotation:GetRange("target")< 30
       and easyRotation:IsMouseOverTarget() 
        then easyRotation:UpdateRotationHinterIcon("Light's Hammer") 

  elseif (easyRotation:PlayerCanCastSpell("Hammer of Wrath")
        and easyRotation:UnitHasBuff("player","Crusader's Fury"))
         or (easyRotation:UnitHasBuff("player","Avenging Wrath") 
           and easyRotation:PlayerCanCastSpell("Hammer of Wrath"))
         or (easyRotation:PlayerCanCastSpell("Hammer of Wrath")
        and easyRotation:UnitHealthPercent("target") < 35) 
        and easyRotation:GetRange("target") < 30
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)<5
       then easyRotation:UpdateRotationHinterIcon("Hammer of Wrath")

--Final Verdict Buff (recieved after casting FV), Divine Purpose Buff (gives free FV or DS and damage as if 3 holy power), 
--Divine Crusader Buff (gives free DS)
  elseif easyRotationVars.storm
        and easyRotation:PlayerCanCastSpell("Divine Storm")
        and easyRotation:UnitHasBuff("player","Divine Crusader")
        and easyRotation:UnitHasBuff("player","Final Verdict")
        and easyRotation:GetRange("target")< 8
       or easyRotationVars.storm
        and easyRotation:GetRange("target")< 8
        and easyRotation:PlayerCanCastSpell("Divine Storm")
        and easyRotation:UnitHasBuff("player","Divine Crusader")
        --and easyRotation:UnitHasBuffRemaining("player","Divine Crusader")<3
       then easyRotation:UpdateRotationHinterIcon("Divine Storm")

      elseif easyRotation:PlayerCanCastSpell("Crusader Strike")
        and easyRotation:GetRange("target")< 5
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) < 5
        and not easyRotation:UnitHasBuff("player","Divine Purpose")        
       then easyRotation:UpdateRotationHinterIcon("Crusader Strike")

      elseif easyRotation:PlayerCanCastSpell("Judgment")
        and easyRotation:GetRange("target")< 30
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) < 5
        and not easyRotation:UnitHasBuff("player","Divine Purpose")        
       then easyRotation:UpdateRotationHinterIcon("Judgment")

  elseif easyRotation:PlayerCanCastSpell("Exorcism")
        and easyRotation:GetRange("target")< 5
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) < 5
        and not (easyRotation:UnitHasBuff("player","Divine Purpose")        
        and easyRotation:UnitHasBuff("player","Divine Crusader"))
        or easyRotation:PlayerCanCastSpell("Exorcism")
        and easyRotation:GetRange("target")< 5
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) < 3
        and easyRotation:UnitHasBuff("player","Blazing Contempt")
       then easyRotation:UpdateRotationHinterIcon("Exorcism")

  elseif easyRotation:PlayerCanCastSpell("Final Verdict")
       and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)==5
       and easyRotation:GetRange("target")< 10
      then easyRotation:UpdateRotationHinterIcon("Final Verdict")
  
  elseif easyRotation:PlayerCanCastSpell("Final Verdict")
        and easyRotation:GetRange("target")< 10
        and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER)> 2
        and not easyRotation:PlayerCanCastSpell("Crusader Strike")
        and not easyRotation:PlayerCanCastSpell("Exorcism")
        and not easyRotation:PlayerCanCastSpell("Judgment")
       -- and not easyRotation:PlayerCanCastSpell("Hammer of Wrath")
        
      then easyRotation:UpdateRotationHinterIcon("Final Verdict")


   end
 end
  
 --AOE MULTIPLE TARGETS, USE SEAL OF RIGHTEOUSNESS WHEN MORE THAN 4 TARGETS ARE UP AND WILL LIVE LONGER THAN 30 SECONDS

function easyRotation.rotations.retadin.DecideAOESpells()

if easyRotationVars.seal
     and not easyRotation:IsPassiveSpell("Empowered Seals")
     and (easyRotation:GetShapeshiftForm()>2
        or easyRotation:GetShapeshiftForm()<2)
     and easyRotation:PlayerInCombat() 
      then easyRotation:UpdateRotationHinterIcon("Seal of Righteousness") 

 elseif easyRotationVars.seal
     and easyRotation:IsPassiveSpell("Empowered Seals")
     and not (easyRotation:UnitHasBuff("player","Liadrin's Righteousness"))
     and (easyRotation:GetShapeshiftForm()>2
        or easyRotation:GetShapeshiftForm()<2)   
      then easyRotation:UpdateRotationHinterIcon("Seal of Righteousness")

elseif FinalV 
     and easyRotation:UnitHasBuff("Thorasus")
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

  elseif easyRotation:PlayerCanCastSpell("Light's Hammer")
       and easyRotation:GetRange("target")< 30
       and easyRotation:IsMouseOverTarget() 
        then easyRotation:UpdateRotationHinterIcon("Light's Hammer") 

   elseif easyRotation:GetRange("target")< 40
      and easyRotation:PlayerCanCastSpell("Execution Sentence")
        then easyRotation:UpdateRotationHinterIcon("Execution Sentence")
--new
  elseif easyRotationVars.storm
        and easyRotation:GetRange("target")< 8
        and easyRotation:PlayerCanCastSpell("Divine Storm")
        and easyRotation:UnitHasBuff("player","Divine Crusader")
        --and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) > 3
        and not (easyRotation:UnitHasBuff("player","Divine Purpose"))
        or easyRotation:UnitHasBuff("player","Final Verdict")
         and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) > 3       
         and easyRotation:PlayerCanCastSpell("Divine Storm")
         and easyRotation:GetRange("target")< 8
         and easyRotationVars.storm
       then easyRotation:UpdateRotationHinterIcon("Divine Storm") 

  elseif easyRotation:GetRange("target") < 30
        and (easyRotation:PlayerCanCastSpell("Hammer of Wrath")
        and easyRotation:UnitHasBuff("player","Crusader's Fury"))
         or (easyRotation:PlayerCanCastSpell("Hammer of Wrath")
        and easyRotation:UnitHealthPercent("target") < 35) 
         or (easyRotation:UnitHasBuff("player","Avenging Wrath") 
           and easyRotation:PlayerCanCastSpell("Hammer of Wrath"))
       then easyRotation:UpdateRotationHinterIcon("Hammer of Wrath") 

--Final Verdict Buff (recieved after casting FV), Divine Purpose Buff (gives free FV or DS and damage as if 3 holy power), 
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
  
  elseif easyRotation:PlayerCanCastSpell("Exorcism")
      and easyRotation:GetRange("target")< 5
       then easyRotation:UpdateRotationHinterIcon("Exorcism") 
 
  elseif --easyRotationVars.seal and
       easyRotation:PlayerCanCastSpell("Hammer of the Righteous") 
      and easyRotation:GetRange("target")< 5
      and easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) < 5
      and not easyRotation:UnitHasBuff("player","Divine Purpose")
       then easyRotation:UpdateRotationHinterIcon("Hammer of the Righteous")

elseif easyRotation:PlayerCanCastSpell("Judgment")
      and easyRotation:GetRange("target")< 30
       then easyRotation:UpdateRotationHinterIcon("Judgment")

    end
 end



 