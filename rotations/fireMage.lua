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

 

function easyRotation.rotations.fireMage.DecideSpells()

         --If you have taken Rune as a talent
if easyRotation:PlayerCanCastSpell("Rune of Power") 
         and (not easyRotation:UnitHasBuff("player","Rune of Power"))
         and easyRotation:IsPlayerSpellReady("Rune of Power")
         and easyRotation:PlayerCanCastSpell("Combustion")
         and not easyRotation:IsMoving()      
          or easyRotation:PlayerCanCastSpell("Rune of Power") 
         and easyRotation:GetPlayerSpellCharges("Rune of Power")> 1 
         and not easyRotation:IsCasting()
         and not easyRotation:UnitHasBuff("player","Rune of Power") 
        then easyRotation:UpdateRotationHinterIcon("Rune of Power")

  elseif easyRotation:PlayerCanCastSpell("Combustion")
         and not easyRotation:UnitHasBuff("player","Combustion") 
        then easyRotation:UpdateRotationHinterIcon("Combustion")

  elseif easyRotation:PlayerCanCastSpell("Flame on")
         and easyRotation:GetPlayerSpellCharges("Fire Blast")< 1
        then easyRotation:UpdateRotationHinterIcon("Flame On")

  elseif easyRotation:UnitHasBuff("player","Hot Streak!")         
         and easyRotation:PlayerCanCastSpell("Fireball")         
        then easyRotation:UpdateRotationHinterIcon("Fireball") 

  elseif easyRotation:PlayerCanCastSpell("Pyroblast")
         and easyRotation:UnitHasBuff("player","Hot Streak!")
        then easyRotation:UpdateRotationHinterIcon("Pyroblast") 


  elseif easyRotation:PlayerCanCastSpell("Meteor")
         and easyRotation:IsMouseOverTarget()
        then easyRotation:UpdateRotationHinterIcon("Meteor")

  elseif easyRotation:UnitHasBuff("player","Heating Up")          
         and easyRotation:IsPlayerSpellReady("Fire Blast")
         and easyRotation:GetPlayerSpellCharges("Fire Blast")> 0   
        then easyRotation:UpdateRotationHinterIcon("Fire Blast")

  elseif easyRotation:PlayerCanCastSpell("Living Bomb") 
         and (not easyRotation:UnitHasYourDebuff("Target","Living Bomb") 
         or easyRotation:UnitHasYourDebuffRemaining("Target","Living Bomb")<= 0)
         and easyRotation:IsPlayerSpellReady("Living Bomb")
        then easyRotation:UpdateRotationHinterIcon("Living Bomb")

  elseif easyRotation:GetRange("target") < 10
         and easyRotation:PlayerCanCastSpell("Dragon's Breath")
         and not easyRotation:PlayerCanCastSpell("Combustion")
        then easyRotation:UpdateRotationHinterIcon("Dragon's Breath")

  elseif (not easyRotation:IsMoving()
          or easyRotation:UnitHasBuff("player","Ice Floes"))
         and easyRotation:IsPlayerSpellReady("Fireball")
        then easyRotation:UpdateRotationHinterIcon("Fireball")

  elseif easyRotation:IsMoving()
         and easyRotation:IsPlayerSpellReady("Scorch") 
         and not easyRotation:UnitHasBuff("player","Ice Floes")   
        then easyRotation:UpdateRotationHinterIcon("Scorch")                           
              
  end
 end 
end

             
