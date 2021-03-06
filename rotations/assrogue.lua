easyRotation.modules.assrogue = {}

function easyRotation.modules.assrogue.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "ROGUE" and GetSpecialization() == 3
end

function easyRotation.modules.assrogue.initializeVariables()
  
end

function easyRotation.modules.assrogue.Slash(cmd,val)
  
end

function easyRotation.modules.assrogue.DecideBuffs()
  if not UnitAffectingCombat("player") and easyRotation:PlayerCanCastSpell("Stealth") and not easyRotation:UnitHasBuff("player","Stealth") then
    easyRotation:UpdateButton("Stealth")
  end
end

function easyRotation.modules.assrogue.DecideSpells()
  local energy = easyRotation:GetPlayerResource(SPELL_POWER_ENERGY)
  local combo = GetComboPoints("player", "target")
  if energy >= 25 and easyRotation:PlayerCanCastSpell("Slice and Dice") and easyRotation:UnitHasBuffRemaining("player","Slice and Dice") < 10 and combo >= 5 then
    easyRotation:UpdateButton("Slice and Dice")
  elseif energy >= 35 and easyRotation:PlayerCanCastSpell("Eviscerate") and combo >= 5 then
    easyRotation:UpdateButton("Eviscerate")
  elseif energy >= 39 and easyRotation:PlayerCanCastSpell("Sinister Strike") and combo < 5 then
    easyRotation:UpdateButton("Sinister Strike")
  end
end