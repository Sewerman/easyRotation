easyRotation.rotations.frostMage = {}

function easyRotation.rotations.frostMage.init()
  local _,playerClass = UnitClass("player")
  if not easyRotationVars.orb then easyRotationVars.orb = "orb" end
  if not easyRotationVars.pc then easyRotationVars.pc = "pc" end
 -- if not easyRotationVars.ab then easyRotationVars.ab = "ab" end
  return playerClass == "MAGE" and GetSpecialization() == 3
end 

function easyRotation.rotations.frostMage.Slash(cmd,val)
  if (cmd == 'pc' and easyRotationVars.pc) then
   easyRotationVars.pc = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Prismatic Crystal",1,0,0)
    return true
  elseif (cmd == 'pc' and not easyRotationVars.pc) then
    easyRotationVars.pc = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Prismatic Crystal",0,0,1)
    return true
 elseif (cmd == 'orb' and easyRotationVars.orb) then
    easyRotationVars.orb = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking orb",1,0,0)
   return true
  elseif (cmd == 'orb' and not easyRotationVars.orb) then
    easyRotationVars.orb = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking orb",0,0,1)
    return true
 --elseif (cmd == 'ab' and easyRotationVars.ab) then
  --  easyRotationVars.ab = false
  --  DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking ab",1,0,0)
 --  return true
 -- elseif (cmd == 'ab' and not easyRotationVars.ab) then
 --   easyRotationVars.ab = true
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking ab",0,0,1)
 --   return true
 else
    return false
 end
end
  
function easyRotation.rotations.frostMage.DecideBuffs()
  -- if easyRotationVars.ab then
  --      if not easyRotation:UnitHasBuff("player","Arcane Brilliance") 
 --          or  easyRotation:UnitHasBuff("player","Dalaran Brilliance")
 --  then easyRotation:UpdateRotationHinterIcon("Arcane Brilliance") 
 --   end
 -- end
end

function easyRotation.rotations.frostMage.DecideSpells()
 --Arcane Brilliance up at all times. 
 --Try to keep one stack of Fingers of Frost up at all times. 
 --Top Priority:  
 --Second Priority: 
 --Third Priority: 
 --Fourth Priority: If you have nothing else to do, cast Frostbolt. 
 --Use Icy Veins whenever it’s off cooldown for maximum DPS, or save for burn phases if needed. 
 --If you need to do a lot of damage in a very short amount of time, 
 --use your Cold Snap ability to reset all your cooldowns after you’ve cast Flame Orb, Freeze, Deep Freeze, and Icy Veins. 



if easyRotation:UnitHasDebuff("target","Water Jet") 
       and easyRotation:GetRange("target")<=40
       and easyRotation:PlayerCanCastSpell("Frostbolt") 
         then easyRotation:UpdateRotationHinterIcon("Frostbolt")

  elseif easyRotation:TargetIs("Prismatic Crystal")
       and easyRotation:GetRange("target")<=40
       and easyRotation:PlayerCanCastSpell("Ice Nova")
        then easyRotation:UpdateRotationHinterIcon("Ice Nova")

   elseif easyRotation:UnitHasBuff("player","Fingers of Frost") 
           -- or (easyRotation:IsMoving()
           -- and not easyRotation:UnitHasBuff("Ice Floes"))
       and easyRotation:PlayerCanCastSpell("Ice Lance")
       --and easyRotation:PlayerSpellCooldownRemaining("Prismatic Crystal")> 10
        then easyRotation:UpdateRotationHinterIcon("Ice Lance")

 elseif easyRotation:UnitHasBuff("player","Brain Freeze") 
       and easyRotation:GetRange("target")<=40
       and easyRotation:PlayerCanCastSpell("Frostfire Bolt")
         then easyRotation:UpdateRotationHinterIcon("Frostfire Bolt")

  elseif easyRotation:IsMouseOverTarget()
       and easyRotation:GetRange("target")<=40
       and easyRotationVars.pc 
       and easyRotation:PlayerCanCastSpell("Prismatic Crystal")
        then easyRotation:UpdateRotationHinterIcon("Prismatic Crystal")

  elseif easyRotation:PlayerSpellCooldownRemaining("Prismatic Crystal") >=60
       and easyRotation:GetRange("target")<=40
       and easyRotation:PlayerCanCastSpell("Ice Nova")
         then easyRotation:UpdateRotationHinterIcon("Ice Nova")

  elseif easyRotation:UnitHasBuff("player","Ice Floes")
       and easyRotation:IsMoving()
       and easyRotation:PlayerCanCastSpell("Frostbolt")
        then easyRotation:UpdateRotationHinterIcon("Frostbolt")

  elseif easyRotation:TargetIs("Prismatic Crystal")
       and easyRotation:GetRange("target")<=40
       and easyRotation:UnitHasBuffStacks("player","Fingers of Frost") >= 1
       and easyRotation:PlayerCanCastSpell("Ice Lance")
        then easyRotation:UpdateRotationHinterIcon("Ice Lance")
   
  elseif easyRotation:TargetIs("Prismatic Crystal")
       and easyRotation:GetRange("target")<=40
       and easyRotation:UnitHasBuffStacks("player","Brain Freeze") >= 1
       and easyRotation:PlayerCanCastSpell("Frostfire Bolt")
        then easyRotation:UpdateRotationHinterIcon("Frostfire Bolt")

  elseif easyRotation:TargetIs("Prismatic Crystal") 
       and easyRotation:GetRange("target")<=40
       and (not easyRotation:UnitHasBuff("Fingers of Frost"))
       and easyRotation:PlayerCanCastSpell("Frozen Orb")
         then easyRotation:UpdateRotationHinterIcon("Frozen Orb")

  elseif easyRotation:PlayerCanCastSpell("Frozen Orb")
       and easyRotationVars.orb
       and easyRotation:GetRange("target") < 40
       and not easyRotation:UnitHasBuff("Fingers of Frost")
         then easyRotation:UpdateRotationHinterIcon("Frozen Orb")

  elseif (not easyRotation:TargetIs("Prismatic Crystal")
       and not easyRotation:UnitHasBuff("player","Fingers of Frost"))
       and easyRotation:PetCanCastSpell("Water Jet")
        then easyRotation:UpdateRotationHinterIcon("Water Jet")
  
  elseif easyRotation:PlayerCanCastSpell("Frostbolt")
       and easyRotation:GetRange("target")<=40
         then easyRotation:UpdateRotationHinterIcon("Frostbolt")





 


  
 







  



 end
end
