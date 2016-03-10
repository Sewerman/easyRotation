easyRotation.rotations.arcMage = {}

function easyRotation.rotations.arcMage.init()
  local _,playerClass = UnitClass("player")
 -- if not easyRotationVars.armor then easyRotationVars.armor = true end
 -- if not easyRotationVars.ai then easyRotationVars.ai = true end
 if easyRotationVars.ab then easyRotationVars.ab = true end
 -- if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end

 return playerClass == "MAGE" and GetSpecialization() == 1
end


function easyRotation.rotations.arcMage.Slash(cmd,val)
--if (cmd == 'ai' and easyRotationVars.ai) then
 --   easyRotationVars.ai = false
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking ai",1,0,0)
--    return true
 -- elseif (cmd == 'ai' and not easyRotationVars.ai) then
 --   easyRotationVars.ai = true
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking ai",0,0,1)
 --   return true
 -- else
    if (cmd == 'ab' and easyRotationVars.ab) then
    easyRotationVars.ab = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking ab",1,0,0)
    return true
  elseif (cmd == 'ab' and not easyRotationVars.ab) then
    easyRotationVars.ab = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking ab",0,0,1)
    return true
--  elseif (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
--    easyRotationVars.mode = "AOE"
--    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
--    return true
--  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
--    easyRotationVars.mode = "Single Target"
--    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
--    return true
--  else
--    return false
  end
end
  
function easyRotation.rotations.arcMage.DecideBuffs()
--if not (easyRotation:UnitHasBuff("player","Arcane Brilliance") 
--        or easyRotation:UnitHasBuff("player","Dalaran Brilliance"))
--        then easyRotation:UpdateRotationHinterIcon("Arcane Brilliance") 
--    end
  end

function easyRotation.rotations.arcMage.DecideSpells()
--Conserve Phase

--Put your Rune of Power down and try to stay within 8 yards of it.
--If you chose Nether Tempest as your Tier 5 talent, apply it with 4 stacks of 
--Arcane Charge or refresh it with 4 stacks of Arcane Charge 
--before it drops (refreshing it with less than 3.6 seconds left will not cause you to waste ticks).
--*****Supernova as your Tier 5 talent, try to cast it on cooldown 
--or let it recharge, so that you can cast it twice in a row for burst damage (preferably during a trinket proc).
--*****Arcane Orb as your Tier 7 talent, then cast it if you have 0 or 1 stack of Arcane Charge.
--*****Cast Arcane Missiles once, if you have 3 charges of Arcane Missiles.
--*****Cast Arcane Blast, if you are above 93% Mana before your start casting.
--*****Cast Arcane Missiles, if you have 4 stacks of Arcane Charge and at least a charge of Arcane Missiles.
--*****Cast Arcane Barrage at 4 stacks of Arcane Charge Icon Arcane Charge.
--*****Cast Arcane Blast.
--When moving, you need to first place a Rune of Power Icon Rune of Power at your destination 
--(it requires a bit of planning ahead), and Ice Floes Icon Ice Floes can greatly help with that. 
--When the next Rune of Power is in place, you can use Ice Floes Icon Ice Floes again to cast 
--Arcane Blast or Arcane Missiles 
--(do not cast Arcane Barrage unless you meet the single-target rotation criteria that we listed above).
-- If you have to move for a long distance and that your stacks of Arcane Charge are about to drop,
-- you can use Arcane Explosion to refresh them, if there is a target in range.

-- Burn Phase

--At the start of the fight and whenever Evocation is about to come off cooldown, 
--you need to start the Burn Phase and burn your Mana. Before doing so, make sure that you have 3 charges of Arcane Missiles
--*****Arcane Missiles and 4 stacks of Arcane Charge Icon Arcane Charge.
--Your rotation during the Burn Phase is the same as the Conserve Phase, with three changes.
--*****Arcane Barrage should never be cast during the Burn Phase, 
--because you want to remain at 4 stacks of Arcane Charge Icon Arcane Charge for the entire Burn Phase.
--*****Arcane Blast should be cast without Mana restrictions. 
--Your goal is to burn your Mana, and the only way to do so is to keep casting Arcane Blast.
--When your Mana drops below 50%, use Evocation to get back to full Mana 
--(interrupt the channel when you reach 100%). After that, resume your Conserve Phase.
--Note that you should not use Arcane Barrage right before casting Evocation Icon Evocation.
--This is a mistake as it drops your stacks of Arcane Charge and greatly reduces the mana regeneration rate of Evocation, 
--causing you to spend more time channeling the spell when you could be doing DPS instead.


   local Burnphase = easyRotation:PlayerSpellCooldownRemaining("Evocation") < 30 --and easyRotation:UnitManaPercent("player") > 90
   --local Conservephase = easyRotation:WhenIsPlayerSpellReady("Evocation")> 30
                           
 
 if  easyRotation:IsMouseOverCenterOfScreen()
        and easyRotation:PlayerCanCastSpell("Rune of Power")
        and not easyRotation:UnitHasBuff("player","Rune of Power")
          then easyRotation:UpdateRotationHinterIcon("Rune of Power")
 -- Prismatic Crystal
    elseif Burnphase
        and easyRotation:IsMouseOverTarget()
        and easyRotation:PlayerCanCastSpell("Prismatic Crystal")
        and easyRotation:GetRange("target")<=40       
        and easyRotation:UnitHasDebuffStacks("player","Arcane Charge") > 3 
        and easyRotation:UnitManaPercent("player") > 94
        and not easyRotation:TargetIs("Prismatic Crystal")
          then easyRotation:UpdateRotationHinterIcon("Prismatic Crystal")
   elseif Burnphase 
        and easyRotation:UnitManaPercent("player") < 94 and easyRotation:UnitManaPercent("player") > 90
        and not easyRotation:TargetIs("Prismatic Crystal")
        and easyRotation:UnitHasDebuffStacks("player","Arcane Charge") > 3 
        and easyRotation:PlayerCanCastSpell("Supernova")
        and not easyRotation:IsCasting()
          then easyRotation:UpdateRotationHinterIcon("Supernova")
    elseif easyRotation:PlayerSpellCooldownRemaining("Prismatic Crystal") > 50
        and easyRotation:GetPlayerSpellCharges("Supernova")>0
        and easyRotation:UnitManaPercent("player") < 94 and easyRotation:UnitManaPercent("player") > 90
        and easyRotation:UnitHasDebuffStacks("player","Arcane Charge") > 3
        and easyRotation:UnitHasYourBuffStacks("player","Arcane Missiles!")< 3
        and not easyRotation:IsCasting() 
          then easyRotation:UpdateRotationHinterIcon("Supernova")
    elseif easyRotation:UnitManaPercent("player") < 50
        and easyRotation:PlayerCanCastSpell("Evocation")
        and not easyRotation:IsCasting()
        and not easyRotation:UnitHasBuff("player", "Arcane Missiles!")
         then easyRotation:UpdateRotationHinterIcon("Evocation")
    elseif easyRotation:IsPlayerCastingSpell("Evocation")
        and easyRotation:UnitManaPercent("player") > 95
         then easyRotation:UpdateRotationHinterIcon("Stop Casting")
   --elseif easyRotation:PlayerCanCastSpell("Presence of Mind")
   --     and not easyRotation:UnitHasBuff("player","Presence of Mind") 
   --     and not easyRotation:UnitHasBuff("player","Arcane Power")  
  --        then easyRotation:UpdateRotationHinterIcon("Presence of Mind")
   --elseif (easyRotation:WhenIsPlayerSpellReady("Evocation") - GetTime()) < 45 
   --     and easyRotation:PlayerCanCastSpell("Arcane Power") 
   --     and not easyRotation:UnitHasBuff("player","Presence of Mind")
   --       then easyRotation:UpdateRotationHinterIcon("Arcane Power")
   elseif Burnphase and easyRotation:UnitManaPercent("player") > 30
        and easyRotation:UnitHasYourBuffStacks("player","Arcane Missiles!")> 2 
        and easyRotation:PlayerCanCastSpell("Arcane Missiles")
          then easyRotation:UpdateRotationHinterIcon("Arcane Missiles")
   elseif not Burnphase --Conservephase
        and easyRotation:UnitHasDebuffStacks("player","Arcane Charge") > 3  
        and easyRotation:UnitHasYourBuffStacks("player","Arcane Missiles!") > 0         
        and easyRotation:UnitHasBuff("player","Arcane Missiles!") 
        and easyRotation:PlayerCanCastSpell("Arcane Missiles")
          then easyRotation:UpdateRotationHinterIcon("Arcane Missiles")
   elseif Burnphase and easyRotation:PlayerCanCastSpell("Arcane Blast")  
        and not easyRotation:IsCasting()
         then easyRotation:UpdateRotationHinterIcon("Arcane Blast")
   elseif not Burnphase --Conservephase 
        and easyRotation:UnitManaPercent("player") > 90
        and easyRotation:PlayerCanCastSpell("Arcane Blast") 
        and easyRotation:UnitHasDebuffStacks("player","Arcane Charge") < 4
        and not easyRotation:IsCasting()
       or easyRotation:PlayerCanCastSpell("Arcane Blast")
        and easyRotation:UnitHasYourBuffStacks("player","Arcane Missiles!") < 1
        and easyRotation:UnitHasDebuffStacks("player","Arcane Charge") < 4
        and not easyRotation:IsCasting()
          then easyRotation:UpdateRotationHinterIcon("Arcane Blast")

   elseif easyRotation:UnitHasDebuffStacks("player","Arcane Charge") > 3
        and not (easyRotation:UnitHasBuff("player","Arcane Missiles!")and Burnphase)
        --or easyRotation:PlayerCanCastSpell("Supernova")
          then easyRotation:UpdateRotationHinterIcon("Arcane Barrage")
   elseif easyRotation:PlayerCanCastSpell("Arcane Blast")
           then easyRotation:UpdateRotationHinterIcon("Arcane Blast")
   

end
 end
