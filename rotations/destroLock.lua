easyRotation.rotations.destroLock = {}

function easyRotation.rotations.destroLock.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "WARLOCK" and GetSpecialization() == 3
end

function easyRotation.rotations.destroLock.Slash(cmd,val)
  return false
end

function easyRotation.rotations.destroLock.DecideBuffs()
  if not (easyRotation:UnitHasBuff("player","Dark Intent")) then
      easyRotation:UpdateRotationHinterIcon("Dark Intent")
  end
end

function easyRotation.rotations.destroLock.DecideSpells()
  if easyRotation:GetRange("target") > 40 then
    easyRotation:UpdateRotationHinterIcon("Incinerate (Not Ready)")
  elseif not easyRotation:IsMoving() and not easyRotation:PlayerInCombat() and easyRotation:PlayerCanCastSpell("Incinerate") and easyRotation:SpellNotCastRecently("Incinerate") then
    easyRotation:UpdateRotationHinterIcon("Incinerate")
  elseif easyRotation:PlayerCanCastSpell("Havoc") and
         easyRotation:SpellNotCastRecently("Havoc") and
         UnitCanAttack("player", "mouseover") and 
         not UnitIsDead("mouseover") and
         not easyRotation:IsMouseOverTarget() and
         not easyRotation:UnitHasYourDebuff("mouseover","Havoc") then
    easyRotation:UpdateRotationHinterIcon("Havoc")
  elseif easyRotation:PlayerCanCastSpell("Shadowburn") and easyRotation:UnitHealthPercent("target") < 20
      and easyRotation:UnitHasYourDebuffRemaining("target","Shadowburn") < 1.0
      and (easyRotation:GetPlayerResource(SPELL_POWER_BURNING_EMBERS) > 15 -- tipically 53 but i want it to do it more
      or (easyRotation:GetPlayerResource(SPELL_POWER_BURNING_EMBERS) > 10 and easyRotation:UnitHasBuff("player","Dark Soul: Instability"))) then
    easyRotation:UpdateRotationHinterIcon("Shadowburn")
  elseif not easyRotation:IsMoving() and easyRotation:PlayerCanCastSpell("Immolate") and easyRotation:SpellNotCastRecently("Immolate")
      and easyRotation:UnitHasYourDebuffRemaining("target","Immolate") < 6.5 then
    easyRotation:UpdateRotationHinterIcon("Immolate")
  elseif easyRotation:PlayerCanCastSpell("Conflagrate")
      and easyRotation:GetPlayerSpellCharges("Conflagrate") > 1 then
    easyRotation:UpdateRotationHinterIcon("Conflagrate")
  elseif not easyRotation:IsMoving() and easyRotation:PlayerCanCastSpell("Chaos Bolt") and easyRotation:SpellNotCastRecently("Chaos Bolt")
      --and (easyRotation:GetPlayerResource(SPELL_POWER_BURNING_EMBERS) > 35
      and (easyRotation:GetPlayerResource(SPELL_POWER_BURNING_EMBERS) > 25
      or (easyRotation:GetPlayerResource(SPELL_POWER_BURNING_EMBERS) > 10 and easyRotation:UnitHasBuff("player","Dark Soul: Instability"))) then
    easyRotation:UpdateRotationHinterIcon("Chaos Bolt")
  elseif not easyRotation:IsMoving() and easyRotation:PlayerCanCastSpell("Immolate") and easyRotation:SpellNotCastRecently("Immolate")
      and easyRotation:UnitHasYourDebuffRemaining("target","Immolate") < 4.5 then
    easyRotation:UpdateRotationHinterIcon("Immolate")
  elseif easyRotation:PlayerCanCastSpell("Conflagrate")
      and easyRotation:GetPlayerSpellCharges("Conflagrate") > 0 then
    easyRotation:UpdateRotationHinterIcon("Conflagrate")
  elseif not easyRotation:IsMoving() and UnitMana("player") > 32000 then
    easyRotation:UpdateRotationHinterIcon("Incinerate")
  elseif easyRotation:PlayerCanCastSpell("Rain of Fire") and UnitMana("player") > 40000 and UnitCanAttack("player", "mouseover") and
      (not easyRotation:UnitHasYourDebuff("target","Rain of Fire") or not easyRotation:UnitHasYourDebuff("mouseover","Rain of Fire")) then
    easyRotation:UpdateRotationHinterIcon("Rain of Fire")
  else
    easyRotation:UpdateRotationHinterIcon("Incinerate (Not Ready)")
  end
end
