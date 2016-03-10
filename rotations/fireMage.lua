easyRotation.rotations.fireMage = {}

function easyRotation.rotations.fireMage.init()
  local _,playerClass = UnitClass("player")
  --if not easyRotationVars.armor then easyRotationVars.armor = true end
  --if not easyRotationVars.ai then easyRotationVars.ai = true end
  if easyRotationVars.FF then easyRotationVars.FF = true end
  --if not easyRotationVars.mode then easyRotationVars.mode = "Single Target"end

  return playerClass == "MAGE" and GetSpecialization() == 2
end

function easyRotation.rotations.fireMage.Slash(cmd,val)
  --if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
 --   easyRotationVars.mode = "AOE"
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
 --   return true
 -- elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
 --   easyRotationVars.mode = "Single Target"
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
--    return true
 -- elseif
  --  (cmd == 'ai' and easyRotationVars.ai) then
  --  easyRotationVars.ai = false
  --  DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking ai",1,0,0)
  --  return true
 -- elseif (cmd == 'ai' and not easyRotationVars.ai) then
 --   easyRotationVars.ai = true
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking ai",0,0,1)
  --  return true
 if (cmd == 'FF' and not easyRotationVars.FF) then-- (When Glyphed does same damage and cast at same speed as FireBall)
    easyRotationVars.FF = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking FF",0,0,1)
    return true
  elseif (cmd == 'FF' and easyRotationVars.FF) then  
    easyRotationVars.FF = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking FF",1,0,0)
   return true
 else
    return false
 end
end
  
function easyRotation.rotations.fireMage.DecideBuffs()
 -- if easyRotationVars.armor then
 --   if (easyRotation:UnitManaPercent("player") > 90) and
 --       not easyRotation:UnitHasYourBuff("player","Molten Armor") then
    --  easyRotation:UpdateRotationHinterIcon("Molten Armor") 
    --elseif easyRotation:UnitManaPercent("player") < 15 and
--        not easyRotation:UnitHasYourBuff("player","Mage Armor") then
--      easyRotation:UpdateRotationHinterIcon("Mage Armor")    
 --   end
 -- end

 if not (easyRotation:UnitHasBuff("player","Arcane Brilliance") 
     or easyRotation:UnitHasBuff("player","Dalaran Brilliance"))
     then easyRotation:UpdateRotationHinterIcon("Arcane Brilliance") 
  end
end

function easyRotation.rotations.fireMage.DecideSpells()
--  if easyRotationVars.mode == "Single Target" then
--else
         --If you have taken Rune as a talent
 if easyRotation:PlayerCanCastSpell("Rune of Power") 
         and (not easyRotation:UnitHasBuff("player","Rune of Power"))
         and easyRotation:IsPlayerSpellReady("Rune of Power")
         and easyRotation:IsMouseOverCenterOfScreen()
         and not easyRotation:IsMoving()         
        then 
        easyRotation:UpdateRotationHinterIcon("Rune of Power")
 elseif easyRotation:UnitHasBuff("player","Pyroblast!")         
         and easyRotation:UnitHasBuff("player","Heating Up")  
         and easyRotation:IsPlayerSpellReady("Pyroblast") -- Instant Cast 
         and easyRotation:IsCasting()
        then easyRotation:UpdateRotationHinterIcon("Stop Casting")
       easyRotation:IgnoreReady()  
  elseif easyRotation:UnitHasBuff("player","Pyroblast!")         
         and easyRotation:UnitHasBuff("player","Heating Up")  
         and easyRotation:IsPlayerSpellReady("Pyroblast") -- Instant Cast
          --or easRotation:UnitHasBuff("player","pyroblast!")<3
        then 
        easyRotation:UpdateRotationHinterIcon("Pyroblast") 
 --If you have Taken Meteor as a talent
elseif easyRotation:PlayerCanCastSpell("Meteor")
         and easyRotation:IsMouseOverTarget()
        then easyRotation:UpdateRotationHinterIcon("Meteor")
-- COMBUSTION REMOVED UNTIL ITS TICK CAN BE TRACKED
--elseif easyRotation:PlayerCanCastSpell("Combustion")
   --      and (easyRotation:UnitHasYourDebuff("Target","Ignite"))
         --and easyRotation:UnitHasYourDebuffRemaining("Target","Ignite")> 3) 
        --and not easyRotation:UnitHasDebuff("Target","Combustion") 
  --      then 
  --      easyRotation:UpdateRotationHinterIcon("Combustion")
elseif easyRotation:PlayerCanCastSpell("Living Bomb") 
         and (not easyRotation:UnitHasYourDebuff("Target","Living Bomb") 
         or easyRotation:UnitHasYourDebuffRemaining("Target","Living Bomb")<= 0)
         and easyRotation:IsPlayerSpellReady("Living Bomb")
        then 
        easyRotation:UpdateRotationHinterIcon("Living Bomb")

 elseif easyRotation:UnitHasBuff("player","Heating Up") and 
          easyRotation:IsPlayerSpellReady("Inferno Blast") -- Instant Cast
        then 
        easyRotation:UpdateRotationHinterIcon("Inferno Blast")
  --elseif easyRotation:GetRange("target") < 10
  --       and easyRotation:PlayerCanCastSpell("Dragon's Breath")
  --      then 
  --      easyRotation:UpdateRotationHinterIcon("Dragon's Breath")
   --- If Blast Wave is selected in talent tree
elseif easyRotation:PlayerCanCastSpell("Blast Wave")
       then easyRotation:UpdateRotationHinterIcon("Blast Wave")
 
elseif easyRotationVars.FF
         and (easyRotation:IsPlayerSpellReady("Frostfire Bolt")
         and not easyRotation:IsMoving())
          or (easyRotationVars.FF and easyRotation:UnitHasBuff("player", "Ice Floes")
          and easyRotation:IsMoving())
        then 
        easyRotation:UpdateRotationHinterIcon("Frostfire Bolt")

 elseif (not easyRotation:IsMoving()
          or easyRotation:UnitHasBuff("player","Ice Floes"))
        and easyRotation:IsPlayerSpellReady("Fireball")
        then 
        easyRotation:UpdateRotationHinterIcon("Fireball")
 elseif easyRotation:IsMoving()
         and easyRotation:IsPlayerSpellReady("Scorch") 
         and not easyRotation:UnitHasBuff("player","Ice Floes")   
        then
        easyRotation:UpdateRotationHinterIcon("Scorch")                           
              
  end

--elseif easyRotationVars.mode == "AOE" then

-- if not easyRotation:UnitHasYourDebuff("Target","Combustion")
  --       and easyRotation:UnitHasYourDebuff("Target","Ignite") 
  --       and easyRotation:UnitHasYourDebuff("Target","Pyroblast!") 
  --       and easyRotation:UnitHasYourDebuff("Target","Living Bomb")
  --       and easyRotation:PlayerCanCastSpell("Combustion") 
  --       and easyRotation:IsCasting()
  --       then easyRotation:UpdateRotationHinterIcon("Stop Casting")
  --   easyRotation:IgnoreReady()
-- elseif not easyRotation:UnitHasYourDebuff("Target","Combustion")
  --       and easyRotation:UnitHasYourDebuff("Target","Ignite") 
  --       and easyRotation:UnitHasYourDebuff("Target","Pyroblast!") 
  --       and easyRotation:UnitHasYourDebuff("Target","Living Bomb")          
  --       and easyRotation:PlayerCanCastSpell("Combustion") 
  --       then easyRotation:UpdateRotationHinterIcon("Combustion") 
-- elseif easyRotation:UnitHasBuff("player","Hot Streak") 
  --       and easyRotation:IsCasting()
  --       then easyRotation:UpdateRotationHinterIcon("Stop Casting")
  --   easyRotation:IgnoreReady()
-- elseif easyRotation:UnitHasBuff("player","Hot Streak")  
  --       and easyRotation:PlayerCanCastSpell("Pyroblast") -- Instant Cast
  --       then easyRotation:UpdateRotationHinterIcon("Pyroblast")  
-- elseif easyRotation:UnitManaPercent("player") < 60 
  --       and easyRotation:PlayerHasItem("Mana Gem")
  --       and easyRotation:IsItemReady("Mana Gem")
  --       then easyRotation:UpdateRotationHinterIcon("Mana Gem")
-- elseif easyRotation:UnitManaPercent("player") < 20 
  --       and (not easyRotation:IsMoving()) 
  --       and easyRotation:SpellNotCastRecently("Evocation") 
  --       and easyRotation:PlayerCanCastSpell("Evocation")
  --      then easyRotation:UpdateRotationHinterIcon("Evocation")                    
-- elseif not easyRotation:UnitHasYourDebuff("Target","Living Bomb") 
  --       and easyRotation:PlayerCanCastSpell("Living Bomb")
  --       and easyRotation:UnitManaPercent("player") > 2
  --       then easyRotation:UpdateRotationHinterIcon("Living Bomb")
-- elseif easyRotation:UnitHasBuff("player","Impact")
  --       and easyRotation:UnitHasYourDebuff("target","Living Bomb")
  --       and easyRotation:SpellNotCastRecently("Fire Blast") 
  --       and easyRotation:PlayerCanCastSpell("Fire Blast")
  --       and easyRotation:UnitManaPercent("player") > 10        
  --       then easyRotation:UpdateRotationHinterIcon("Fire Blast") 
-- elseif easyRotation:SpellNotCastRecently("Flame Orb") 
  --       and easyRotation:PlayerCanCastSpell("Flame Orb") 
  --       and easyRotation:UnitManaPercent("player") > 20
  --       then easyRotation:UpdateRotationHinterIcon("Flame Orb")
-- elseif (easyRotation:UnitHasDebuff("Target","Shadow and Flame") 
  --       or easyRotation:UnitHasDebuff("Target","Critical Mass"))
  --       and easyRotation:UnitManaPercent("player") > 15 
  --       and easyRotation:PlayerCanCastSpell("Fireball")
  --       then easyRotation:UpdateRotationHinterIcon("Fireball")
-- elseif not(easyRotation:UnitHasDebuff("Target","Shadow and Flame") 
  --       or easyRotation:UnitHasDebuff("Target","Critical Mass"))
  --       and (easyRotation:PlayerCanCastSpell("Scorch"))
  --       then easyRotation:UpdateRotationHinterIcon("Scorch")
-- elseif (easyRotation:IsMoving()
  --       or easyRotation:UnitManaPercent("player") < 35) 
  --       and easyRotation:PlayerCanCastSpell("Scorch")
  --       --and easyRotation:SpellNotCastRecently("Scorch")
  --       then easyRotation:UpdateRotationHinterIcon("Scorch")                            
-- elseif easyRotation:GetRange("target") < 10
  --       and easyRotation:PlayerCanCastSpell("Dragon's Breath")
  --       then easyRotation:UpdateRotationHinterIcon("Dragon's Breath") 
  --  end
--  end 
end 
             
