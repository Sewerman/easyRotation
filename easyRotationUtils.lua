-- 
-- easyRotationUtil
-- 

-- return true if everyone in the raid or party has the buff by the specified name
function easyRotation:EveryoneHasBuff(name)
  if UnitInRaid("player") or UnitInParty("player") then
    local prefix = UnitInRaid("player") and "raid" or "party"
    for n = 1, GetNumGroupMembers() do
      if UnitGUID(prefix..n) ~= nil then
        local found = false
        for i=1,40 do
          local buffName, _, _, _, _, _, _, unitCaster, _, _, _ = UnitBuff(prefix..n,i)
          if buffName == name then
            found = true
            break
          end
        end
        if found == false then
          return false
        end
      end
    end
    return easyRotation:UnitHasBuff('player',name)
  else
    return easyRotation:UnitHasBuff('player',name)
  end
end

-- returns true if the unit specified has the buff by that name and it was casted by you
function easyRotation:UnitHasYourBuff(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, _, unitCaster, _, _, _ = UnitBuff(unit, i)
    if buffName == name and (unitCaster == "player" or unitCaster == "pet") then
      return true
    end
  end
  return false
end

-- returns true if the unit specified has the debuff by that name and it was casted by you
function easyRotation:UnitHasBuffId(unit, buffId)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, _, unitCaster, _, _, id = UnitBuff(unit, i)
    if buffId == id then
      return true
    end
  end
  return false
end

function easyRotation:UnitHasBuff(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, _, unitCaster, _, _, id = UnitBuff(unit, i)
    if buffName == name then
      return true
    end
  end
  return false
end

-- returns true if the unit specified has the buff by that name
function easyRotation:UnitHasYourDebuff(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, _, unitCaster, _, _, _ = UnitDebuff(unit, i)
    if buffName == name and (unitCaster == "player" or unitCaster == "pet") then
      return true
    end
  end
  return false
end

-- returns true if the unit specified has the debuff by that name
function easyRotation:UnitHasDebuff(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, _, unitCaster, _, _, _ = UnitDebuff(unit, i)
    if buffName == name then
      return true
    end
  end
  return false
end

-- return the number of stacks of a buff the unit has casted by you
function easyRotation:UnitHasYourBuffStacks(unit, name)
  for i = 1, 40 do
    local buffName, _, _, count, _, _, _, unitCaster, _, _, _ = UnitBuff(unit, i)
    if buffName == name and (unitCaster == "player" or unitCaster == "pet") then
      return count
    end
  end
  return 0
end

-- return the number of stacks of a buff the unit has
function easyRotation:UnitHasBuffStacks(unit, name)
  for i = 1, 40 do
    local buffName, _, _, count, _, _, _, unitCaster, _, _, _ = UnitBuff(unit, i)
    if buffName == name then
      return count
    end
  end
  return 0
end

-- return the number of stacks of a debuff the unit has casted by you
function easyRotation:UnitHasYourDebuffStacks(unit, name)
  for i = 1, 40 do
    local buffName, _, _, count, _, _, _, unitCaster, _, _, _ = UnitDebuff(unit, i)
    if buffName == name and (unitCaster == "player" or unitCaster == "pet") then
      return count
    end
  end
  return 0
end

-- return the number of stacks of a debuff the unit has
function easyRotation:UnitHasDebuffStacks(unit, name)
  for i = 1, 40 do
    local buffName, _, _, count, _, _, _, unitCaster, _, _, _ = UnitDebuff(unit, i)
    if buffName == name then
      return count
    end
  end
  return 0
end

-- return the buff time remaning from the next time you can cast for the unit casted by you
function easyRotation:UnitHasYourBuffRemaining(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, x, unitCaster, _, _, id = UnitBuff(unit, i)
    if buffName == name and (unitCaster == "player" or unitCaster == "pet") then
      return -1 * (easyRotation:nextTimePlayerCanCast() - x)
    end
  end
  return 0
end

function easyRotation:UnitHasYourBuffIdRemaining(unit, buffId)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, x, unitCaster, _, _, id = UnitBuff(unit, i)
    if buffId == id and (unitCaster == "player" or unitCaster == "pet") then
      return -1 * (easyRotation:nextTimePlayerCanCast() - x)
    end
  end
  return 0
end

-- return the buff time remaning from the next time you can cast for the unit 
function easyRotation:UnitHasBuffRemaining(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, x, unitCaster, _, _, _ = UnitBuff(unit, i)
    if buffName == name then
      return -1 * (easyRotation:nextTimePlayerCanCast() - x)
    end
  end
  return 0
end

-- return the debuff time remaning from the next time you can cast for the unit casted by you
function easyRotation:UnitHasYourDebuffRemaining(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, x, unitCaster, _, _, _ = UnitDebuff(unit, i)
    if buffName == name and (unitCaster == "player" or unitCaster == "pet") then
      return -1 * (easyRotation:nextTimePlayerCanCast() - x)
    end
  end
  return 0
end

-- return the debuff time remaning from the next time you can cast for the unit 
function easyRotation:UnitHasDebuffRemaining(unit, name)
  for i = 1, 40 do
    local buffName, _, _, _, _, _, x, unitCaster, _, _, _ = UnitDebuff(unit, i)
    if buffName == name then
      return -1*(easyRotation:nextTimePlayerCanCast() - x)
    end
  end
  return 0
end
--return if Player has Tier Talent selected
function easyRotation:GetSpellInfo(spellname)
    local name, _, _, _, _, _, _, name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spellId or spellName)
    if name ~= nil then
  return false
else 
  return true
end
end

--return if player has Usable spell
function easyRotation:IsUsableSpell(spell,bookType) 
  local IsUsableSpell = GetSpellInfo(spell);
 if IsUsableSpell == nil then
   return false
else
   return true
end
end
-- return the spell cooldown time remaning minus some padding time for latency
function easyRotation:PlayerSpellCooldownRemaining(spell)
  local start, duration, enabled = GetSpellCooldown(spell);
  if start == 0 and duration == 0 and enabled == 1 then
    return 0
  else
    return (start + duration) - GetTime()
  end
end

-- return pet spell cooldown
function easyRotation:PetSpellCooldownRemaining(spell)
  local start, duration, enabled = GetSpellCooldown(spell);
  if start == 0 and duration == 0 and enabled == 1 then
    return 0
  else
    return (start + duration) - GetTime()
  end
end

-- return the absolute time minus some padding time for latency for when a spell will be ready
function easyRotation:WhenIsPlayerSpellReady(spell)
  local start, duration, enabled = GetSpellCooldown(spell);
  if start == 0 and duration == 0 and enabled == 1 then
    return 0
  else
    return start + duration
  end
end

--return the absolute time minus some padding time for latency for when a spell will be ready for Pet spells
function easyRotation:WhenIsPetSpellReady(spell)
  local start, duration, enabled = GetSpellCooldown(spell);
  if start == 0 and duration == 0 and enabled == 1 then
    return 0
  else
    return start + duration
  end
end

-- return the absolute time for when a player can cast next
function easyRotation:nextTimePlayerCanCast()
  -- a player can cast (when gcd is gonna end) or if no gcd (the current time)
  return (easyRotation.readyTime == 0 and (GetTime()) or (easyRotation.readyTime))
end

--Return for Pet spell
function easyRotation:nextTimePetCanCast()
  -- a player can cast (when gcd is gonna end) or if no gcd (the current time)
  return easyRotation.readyTime == 0 and (GetTime()) or (easyRotation.readyTime)
end
--Passive Spell
function easyRotation:IsPassiveSpell(spell, bookType)
 local isPassive = IsPassiveSpell(spell, bookType);
 if isPassive == true then
   return true
else
   return false
end
end

-- return true if the WhenIsSpellReady time is less than nextTimePlayerCanCast time
function easyRotation:IsPlayerSpellReady(spell)
  -- basically the spell is ready when the (last cast time) + (duration) is less than (when gcd is gonna end) or (the current time)
  return (easyRotation:WhenIsPlayerSpellReady(spell) - easyRotation.latencyAdjustment) <= easyRotation:nextTimePlayerCanCast()
end

--Return for pet spell is ready
function easyRotation:IsPetSpellReady(spell)
  -- basically the spell is ready when the (last cast time) + (duration) is less than (when gcd is gonna end) or (the current time)
  return easyRotation:WhenIsPetSpellReady(spell) <= easyRotation:nextTimePetCanCast()
end
-- is Player in Combat
function easyRotation:PlayerInCombat()
  return UnitAffectingCombat("player")
end

-- the duration the player has been in active combat
function easyRotation:PlayerTimeInCombat()
  if(easyRotation.startOfCombat == 0) then
    return 0
  else
    return GetTime() - easyRotation.startOfCombat
  end
end

-- returns true if the player is casting the spell
function easyRotation:IsPlayerCastingSpell(spell)
  local castingSpell, _, _, _, _, _, _, _, _ = UnitCastingInfo("player")
  local channeledSpell, _, _, _, _, _, _, _ = UnitChannelInfo("player")
  return (castingSpell == spell or channeledSpell == spell) --and easyRotation.readyTime ~= 0
  --return false
end

-- returns true if the Pet is casting the spell
function easyRotation:IsPetCastingSpell(spell)
  local castingSpell, _, _, _, _, _, _, _, _ = UnitCastingInfo("pet")
  local channeledSpell, _, _, _, _, _, _, _ = UnitChannelInfo("pet")
  return (castingSpell == spell or channeledSpell == spell)
end

-- return the player haste precent
function easyRotation:GetPlayerHastePercent()
  return GetCombatRatingBonus(20) + (easyRotation:UnitHasBuff("player","Dark Intent") and 3.0 or 0.0) + (easyRotation:UnitHasBuff("player","Moonkin Aura") and 5.0 or 0.0) -- moonkin form -- shadow form -- wrath of air totem
end

-- this fuction returns the count of a special player resource
-- Example: if easyRotation:GetPlayerResource(SPELL_POWER_HOLY_POWER) > 2 then
-- resource types: SPELL_POWER_MANA,SPELL_POWER_RAGE,SPELL_POWER_FOCUS,SPELL_POWER_ENERGY,SPELL_POWER_HAPPINESS,SPELL_POWER_RUNES,SPELL_POWER_RUNIC_POWER,SPELL_POWER_SOUL_SHARDS,SPELL_POWER_ECLIPSE,SPELL_POWER_HOLY_POWER,SPELL_POWER_DEMONIC_FURY,SPELL_POWER_SHADOW_ORBs
-- other resource types for DKs:
SPELL_POWER_BLOOD_RUNE =  -1
SPELL_POWER_UNHOLY_RUNE = -2
SPELL_POWER_FROST_RUNE =  -3
SPELL_POWER_DEATH_RUNE =  -4
    function easyRotation:GetPlayerResource(resource_type)
  if(resource_type > 0) then
    return UnitPower("player", resource_type, true)
  else
    local count = 0
    for i=1,6 do
      if (GetRuneType(i) * -1) == resource_type or (GetRuneType(i) * -1) == SPELL_POWER_DEATH_RUNE then
        count = count + GetRuneCount(i)
      end
    end
    return count
  end
end

-- Stances will be needed for warriors and Druids. paladins can swap seals
--STANCE_POSITION =  1
--STANCE_POSITION =  2
--STANCE_POSITION =  3
--STANCE_POSITION =  4
function easyRotation:GetShapeshiftForm(stance_position)
 --if(stance_position) > 0 then
    return GetShapeshiftForm(stance_position)
  --else
  --local stance = 1
  --  for i=0,4 do
  --    if (GetShapeshiftForm(i) * 1) == stance_position then
 --       stance = stance(i)
 --     end
  --  end
 --   return stance
 --end
end


-- GetPlayerSpellCharges(spell) 
function easyRotation:GetPlayerSpellCharges(spell) 
  currentCharges = GetSpellCharges(spell)
  if currentCharges == nil then
    return 0;
  else
    return currentCharges 
  end
end

-- return true if an item is avalible and useable
function easyRotation:IsItemReady(itemName)
  _, itemLink = GetItemInfo(itemName)
  if itemLink == nil then
    return false;
  end
  local _, _, Color, Ltype, itemId, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
  local start, duration, enable = GetItemCooldown(itemId);
  if start == 0 and duration == 0 and enabled == 1 then
    return true
  else
    return (start + duration) < GetTime()
  end
end

-- return true if player has a specifig glyp
function easyRotation:PlayerHasGlyph(glyphName)
  for i=1,GetNumGlyphs() do
    local name, _, _, _, _ = GetGlyphInfo(i)
    if(name == glyphName) then
      return true
    end
  end
  return false
end

-- return true if player has specific item
function easyRotation:PlayerHasItem(itemName)
  _, itemLink = GetItemInfo(itemName)
  if itemLink == nil then
    return false;
  end
  local _, _, Color, Ltype, itemId, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
  return GetItemCount(itemId, nil, true) ~= 0
end

-- return the number of stacks of an item a player has
function easyRotation:PlayerHasItemCount(itemName)
  _, itemLink = GetItemInfo(itemName)
  if itemLink == nil then
    return 0;
  end
  local _, _, Color, Ltype, itemId, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
  return GetItemCount(itemId, nil, true)
end

-- returns the last time a spell was cast
function easyRotation:SpellLastCast(spell)
  if easyRotation.lastSpell[spell] ~= nil then
    return easyRotation.lastSpell[spell]
  end
  easyRotation.lastSpell[spell] = 0
  return easyRotation.lastSpell[spell]
end

-- returns an estimated time for the current spell to hit the target
function easyRotation:EstimatedSpellTravelTime(unit,spell)
   local minRange, maxRange = easyRotation.rangeCheck:GetRange(unit)
   if maxRange ~= nil then
     if easyRotation.spells[spell] ~= nil and easyRotation.spells[spell].travelSpeed ~= nil then
       return maxRange / easyRotation.spells[spell].travelSpeed
     end
     return maxRange / 20.0 -- range / (default) 20yards per second
   else
     return 9999
   end
end

-- return true is the spell has not been cast recently
function easyRotation:SpellNotCastRecently(spell)
    local _, _, _, castTime, _, _ = GetSpellInfo(spell)
    return (easyRotation:SpellLastCast(spell) + castTime + (easyRotation.gcd * 1000) < ((GetTime() + easyRotation.latencyAdjustment) * 1000))
end

-- returns true if the player is moving
function easyRotation:IsMoving()
  return easyRotation.moving
end

function easyRotation:IsMouseOverTarget()
  return UnitIsUnit("target", "mouseover");
end

function easyRotation:IsMouseOverCenterOfScreen()
  local x, y = GetCursorPosition()
  local center_width = (GetScreenWidth() / 2) * UIParent:GetEffectiveScale()
  local center_height = (GetScreenHeight() / 2) * UIParent:GetEffectiveScale()
  return (x > (center_width - 50)) and  (x < (center_width + 50)) and (y > (center_height - 50)) and  (y < (center_height + 50))
end

-- returns true if player is currently casting
function easyRotation:IsCasting()
  return easyRotation.castingSpell ~= nil or easyRotation.channeledSpell ~= nil
end

-- return true if player can cast spell
function easyRotation:PlayerCanCastSpell(spell)
  local inRange = IsSpellInRange(spell, "target");
  local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(spell)
  local can = name ~= nil and (inRange == nil or inRange == 1) and easyRotation:IsPlayerSpellReady(spell) and not easyRotation:IsPlayerCastingSpell(spell) and (not easyRotation:IsMoving() or castingTime == 0 or easyRotation.castwhilemovingbuff or easyRotation.castWhileMovingSpells[spell])
  return can
end

-- return true if pet can cast spell
function easyRotation:PetCanCastSpell(spell)
  local inRange = IsSpellInRange(spell, "target");
  local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(spell)
  return name ~= nil and (inRange == nil or inRange == 1) and easyRotation:IsPetSpellReady(spell) and not easyRotation:IsPetCastingSpell(spell) and (not easyRotation:IsMoving() or castingTime == 0 or easyRotation.castwhilemovingbuff or easyRotation.castWhileMovingSpells[spell])
end

--Return true if player has pet
function easyRotation:PetHasActionBar()
  return PetHasActionBar()
end

--return true if for specific target
function easyRotation:TargetIs(targetName)
  local name, _ = UnitName("target")
  return name == targetName;
end

 -- returns the unit health percent
function easyRotation:UnitHealthPercent(unit)
  return UnitHealth(unit) / UnitHealthMax(unit) * 100
end

-- returns the unit mana percent
function easyRotation:UnitManaPercent(unit)
  return UnitMana(unit) / UnitManaMax(unit) * 100
end

-- returns an estimate range between player and unit
function easyRotation:GetRange(unit)
   local minRange, maxRange = easyRotation.rangeCheck:GetRange(unit)
   if not minRange then
     return 99
   elseif not maxRange then
     return minRange
   else
     return (maxRange + minRange) / 2.0;
   end
end

-- sets ignore ready to true
function easyRotation:IgnoreReady()
  easyRotation.ignoreReady = true
end

-- returns true if the target is casting a spell on the intrurupted target list
function easyRotation:TargetNeedsToBeInterrupted()
  local spell, _, _, _, _, _, _, _, _ = UnitCastingInfo("target");
  local channel, _, _, _, _, _, _, _ = UnitChannelInfo("target");
  for name,inturrupt in pairs(easyRotationVars.interruptSpells) do
    if (spell == name or channel == name) and inturrupt then
      return true
    end
  end
  return false
end

TOTEM_FIRE = 1
TOTEM_EARTH = 2
TOTEM_WATER = 3
TOTEM_AIR = 4

function easyRotation:PlayerCanDropTotem(index)
  local haveTotem, totemName, startTime, duration = GetTotemInfo(index)
  return haveTotem
end

function easyRotation:TotemTimeRemaining(index)
  local haveTotem, totemName, startTime, duration = GetTotemInfo(index)
  return (startTime + duration) - GetTime()
end

