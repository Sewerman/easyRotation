easyRotation.rotations.affliLock = {}

function easyRotation.rotations.affliLock.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "WARLOCK" and GetSpecialization() == 1
end

function easyRotation.rotations.affliLock.DecideSpells()
  -- Your rotation consists in the priority list below.
  -- Apply Agony Icon Agony and refresh it when it has less than 7.2 seconds remaining..
  -- Apply Corruption Icon Corruption and refresh it when it has less than 5.4 seconds remaining.
  -- Apply Unstable Affliction Icon Unstable Affliction and refresh it when it has less than 4.2 seconds remaining.
  -- Cast Haunt Icon Haunt when:
  -- one of the following is true
  -- Haunt's debuff is not applied on the target;
  -- you have 4 Soul Shards;
  -- and one of the following is also true
  -- you have a trinket proc;
  -- Dark Soul: Misery Icon Dark Soul: Misery is up;
  -- the boss is approaching death;
  -- you have at least 3 Soul Shards (so that you have Soul Shards left when Dark Soul is up).
  -- Cast Drain Soul Icon Drain Soul as a filler.

  if easyRotation:PlayerCanCastSpell("Agony")
      and easyRotation:UnitHasYourDebuffRemaining("target","Agony") < 8.0
      and easyRotation:SpellNotCastRecently("Agony") then
    easyRotation:UpdateRotationHinterIcon("Agony")
  elseif easyRotation:PlayerCanCastSpell("Corruption")
      and easyRotation:UnitHasYourDebuffRemaining("target","Corruption") < 6.0
      and easyRotation:SpellNotCastRecently("Corruption") then
    easyRotation:UpdateRotationHinterIcon("Corruption")
  elseif easyRotation:PlayerCanCastSpell("Unstable Affliction")
      and easyRotation:UnitHasYourDebuffRemaining("target","Unstable Affliction") < 5.0
      and easyRotation:SpellNotCastRecently("Unstable Affliction") then
    easyRotation:UpdateRotationHinterIcon("Unstable Affliction")
  elseif (not easyRotation:UnitHasDebuff("target","Haunt") or easyRotation:GetPlayerResource(SPELL_POWER_SOUL_SHARDS) > 399) and
      (easyRotation:UnitHasBuff("player","Dark Soul: Misery") or easyRotation:GetPlayerResource(SPELL_POWER_SOUL_SHARDS) > 299) and
      not easyRotation:IsMoving() then
    easyRotation:UpdateRotationHinterIcon("Haunt")
  elseif easyRotation:IsMoving() then
    easyRotation:UpdateRotationHinterIcon("Drain Soul (Not Ready)")
  elseif easyRotation:PlayerCanCastSpell("Drain Soul") then
    easyRotation:UpdateRotationHinterIcon("Drain Soul")
  end
end
