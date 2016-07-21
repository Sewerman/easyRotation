easyRotation.rotations.feralCat = {}

function easyRotation.rotations.feralCat.init()
  local _,playerClass = UnitClass("player")
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
  if not easyRotationVars.selfHealing then easyRotationVars.selfHealing = "None" end
  if not easyRotationVars.prowlMode then easyRotationVars.prowlMode = "DPS" end
  if not easyRotationVars.mark then easyRotationVars.mark = true end
  if not easyRotationVars.Serk then easyRotationVars.Serk = true end
 -- if easyRotation:PlayerHasGlyph("The Treant") then easyRotationVars.catForm = 2 else easyRotationVars.catForm = 2 end

  return playerClass == "DRUID" and GetSpecialization() == 2
end


function easyRotation.rotations.feralCat.Slash(cmd,val)
  if (cmd == 'mark' and not easyRotationVars.mark) then
    easyRotationVars.mark = true;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Mark of the Wild",0,1,0);
    return true
  elseif (cmd == 'mark' and easyRotationVars.mark) then
    easyRotationVars.mark = false;
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Mark of the Wild",1,0,0);
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true
  elseif (cmd == 'selfhealing' and easyRotationVars.selfHealing == "None") then
    easyRotationVars.selfHealing = "Moderate"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Self Healing mode: Moderate",0,0,1)
    return true
  elseif (cmd == 'selfhealing' and easyRotationVars.selfHealing == "Moderate") then
    easyRotationVars.selfHealing = "Agressive"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Self Healing mode: Agressive",0,0,1)
    return true
  elseif (cmd == 'selfhealing' and easyRotationVars.selfHealing  == "Agressive") then
    easyRotationVars.selfHealing = "None"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Self Healing mode: None",0,0,1)
    return true
  elseif (cmd == 'prowl' and easyRotationVars.prowlMode == "DPS") then
    easyRotationVars.prowlMode = "Stun"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Prowl mode: Stun",0,0,1)
    return true
  elseif (cmd == 'prowl' and easyRotationVars.prowlMode  == "Stun") then
    easyRotationVars.prowlMode = "DPS"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Prowl mode: DPS",0,0,1)
    return true
  elseif (cmd == 'Serk' and not easyRotationVars.Serk) then
    easyRotationVars.Serk = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Berserk",0,1,0)
    return true
  elseif (cmd == 'Serk' and easyRotationVars.Serk) then
    easyRotationVars.Serk = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Berserk",1,0,0)
    return true
  else
    return false
  end
end

function easyRotation.rotations.feralCat:CatForm()
  return GetShapeshiftForm() == easyRotationVars.catForm
end

function easyRotation.rotations.feralCat.DecideBuffs()
 -- if not (easyRotation.rotations.feralCat:CatForm())
  --  and easyRotation:PlayerTimeInCombat() > 1 and easyRotation:SpellNotCastRecently("Cat Form") then
  --    easyRotation:UpdateRotationHinterIcon("Cat Form")
  --else
if easyRotationVars.mark and not (easyRotation:EveryoneHasBuff("Mark of the Wild")) and (GetTime() - easyRotation:SpellLastCast("Mark of the Wild")) > 30 then
      easyRotation:UpdateRotationHinterIcon("Mark of the Wild")
  elseif easyRotationVars.selfHealing ~= "None" and easyRotation:UnitHealthPercent("player") < 95 and easyRotation:UnitHasBuff("player","Predatory Swiftness") and easyRotation:PlayerCanCastSpell("Healing Touch") then
    easyRotation:UpdateRotationHinterIcon("Healing Touch")
  elseif easyRotationVars.selfHealing ~= "None" and easyRotation:UnitHealthPercent("player") < 90 and not easyRotation:UnitHasBuff("player","Rejuvenation") and easyRotation:PlayerCanCastSpell("Rejuvenation") then
    easyRotation:UpdateRotationHinterIcon("Rejuvenation")
  end
end
  
function easyRotation.rotations.feralCat.DecideSpells()
  -- savage roar 12
  -- rip 7.2
  -- rake 4.5

  local energy = easyRotation:GetPlayerResource(SPELL_POWER_ENERGY)
  local combo = GetComboPoints("player", "target")
  local range = GetComboPoints("player", "target")
  
  if(easyRotation:UnitHasBuff("player","Prowl")) then
    if easyRotationVars.prowlMode == "Stun" then
      if range < 10 and energy >= 35 and easyRotation:UnitHasYourDebuffRemaining("target","Rake") < 4.5 and easyRotation:PlayerCanCastSpell("Rake") then
        easyRotation:UpdateRotationHinterIcon("Rake")
      else
        if easyRotationVars.mode == "AOE" then
          easyRotation:UpdateRotationHinterIcon("Swipe (Not Ready)")
        else
          easyRotation:UpdateRotationHinterIcon("Shred (Not Ready)")
        end
      end
    else
      if range < 10 and energy >= 40 and easyRotation:PlayerCanCastSpell("Shred") then
        easyRotation:UpdateRotationHinterIcon("Shred")
      else
        if easyRotationVars.mode == "AOE" then
          easyRotation:UpdateRotationHinterIcon("Swipe (Not Ready)")
        else
          easyRotation:UpdateRotationHinterIcon("Shred (Not Ready)")
        end
      end
    end
    elseif easyRotation.startOfCombat >0 and easyRotation:UnitHasBuff("player","Cat Form")and easyRotation:PlayerCanCastSpell("Prowl") and easyRotation:GetRange("target") < 6 and easyRotation:UnitHasBuff("player","Incarnation: King of the Jungle") then
      easyRotation:UpdateRotationHinterIcon("Prowl")
    elseif easyRotation.startOfCombat >0 and easyRotation:GetRange("target") > 8 and easyRotation:GetRange("target")< 25 and easyRotation:PlayerCanCastSpell("Wild Charge") then
      easyRotation:UpdateRotationHinterIcon("Wild Charge")
    elseif easyRotation:UnitHasBuff("player","Thorasus") and not easyRotation:UnitHasBuff("player","Incarnation: King of the Jungle") and easyRotation:PlayerCanCastSpell("Incarnation: King of the Jungle") or easyRotation.startOfCombat >0 and easyRotation:PlayerCanCastSpell("Incarnation: King of the Jungle") and easyRotationVars.Serk  then
      easyRotation:UpdateRotationHinterIcon("Incarnation: King of the Jungle")
    elseif easyRotation:UnitHasBuff("player","Thorasus") and not easyRotation:UnitHasBuff("player","Berserk") and easyRotation:PlayerCanCastSpell("Berserk") or easyRotation.startOfCombat >0 and easyRotation:PlayerCanCastSpell("Berserk") and easyRotationVars.Serk  then
      easyRotation:UpdateRotationHinterIcon("Berserk")
    elseif easyRotationVars.selfHealing == "Agressive" and easyRotation:UnitHealthPercent("player") < 85 and easyRotation:UnitHasBuff("player","Predatory Swiftness") and easyRotation:PlayerCanCastSpell("Healing Touch") then
      easyRotation:UpdateRotationHinterIcon("Healing Touch")
    elseif easyRotationVars.selfHealing == "Agressive" and easyRotation:UnitHealthPercent("player") < 80 and not easyRotation:UnitHasBuff("player","Rejuvenation") and easyRotation:PlayerCanCastSpell("Rejuvenation") then
      easyRotation:UpdateRotationHinterIcon("Rejuvenation")
    elseif range < 10 and energy >= 50 and easyRotation:UnitHasBuff("player","Clearcasting") and easyRotation:UnitHasYourDebuffRemaining("target","Thrash") < 5 then
      easyRotation:UpdateRotationHinterIcon("Thrash")
    elseif range < 10 and energy >= 35 and easyRotation:UnitHasYourDebuffRemaining("target","Rake") < 4.5 and easyRotation:PlayerCanCastSpell("Rake") then
      easyRotation:UpdateRotationHinterIcon("Rake")
    elseif range < 40 and energy >= 30 and easyRotation:UnitHasYourDebuffRemaining("target","Moonfire") < 4 then  
      easyRotation:UpdateRotationHinterIcon("Moonfire")
    elseif range < 10 and energy >= 25 and combo > 4 and easyRotation:PlayerCanCastSpell("Savage Roar") and easyRotation:UnitHasYourBuffRemaining("player","Savage Roar") < 12 then
      easyRotation:UpdateRotationHinterIcon("Savage Roar")
    elseif range < 10 
        and energy >= 30
        and combo > 4
        and easyRotation:UnitHasYourDebuffRemaining("target","Rip") < 7.2
        and easyRotation:PlayerCanCastSpell("Rip") then
      easyRotation:UpdateRotationHinterIcon("Rip")
    elseif range < 10 
        and energy >= 25 
        and easyRotation:PlayerCanCastSpell("Ferocious Bite")
        and ((combo > 4 and easyRotation:UnitHasYourDebuffRemaining("target","Rip") > 7.2)
          -- emergency refresh
          or (easyRotation:UnitHealthPercent("target") < 25 and combo > 0 and easyRotation:UnitHasYourDebuffRemaining("target","Rip") > 0 and easyRotation:UnitHasYourDebuffRemaining("target","Rip") < (easyRotation.gcd + 1))) then
      easyRotation:UpdateRotationHinterIcon("Ferocious Bite")
    elseif range < 10 and energy < 30 and easyRotation:PlayerCanCastSpell("Tiger's Fury") then
      easyRotation:UpdateRotationHinterIcon("Tiger's Fury")
    elseif easyRotationVars.mode == "AOE" then
      if range < 10 and energy >= 50 and easyRotation:PlayerCanCastSpell("Thrash") and easyRotation:UnitHasYourDebuffRemaining("target","Thrash") < 5 then
        easyRotation:UpdateRotationHinterIcon("Thrash")
      elseif range < 10 and energy >= 45 and easyRotation:PlayerCanCastSpell("Swipe") then
        easyRotation:UpdateRotationHinterIcon("Swipe")
      else
        easyRotation.rotations.feralCat.DecideIdleSpells()
      end
    else
      if range < 10 and energy >= 40 and easyRotation:PlayerCanCastSpell("Shred") then
        easyRotation:UpdateRotationHinterIcon("Shred")
      else
        easyRotation.rotations.feralCat.DecideIdleSpells()
      end
    end
  end

function easyRotation.rotations.feralCat.DecideIdleSpells()
  if easyRotationVars.selfHealing == "Moderate" and easyRotation:UnitHealthPercent("player") < 75 and easyRotation:UnitHasBuff("player","Predatory Swiftness") and easyRotation:PlayerCanCastSpell("Healing Touch") then
    easyRotation:UpdateRotationHinterIcon("Healing Touch")
  elseif easyRotationVars.selfHealing == "Moderate" and easyRotation:UnitHealthPercent("player") < 65 and not easyRotation:UnitHasBuff("player","Rejuvenation") and easyRotation:PlayerCanCastSpell("Rejuvenation") then
    easyRotation:UpdateRotationHinterIcon("Rejuvenation")
  else
    if easyRotationVars.mode == "AOE" then
      easyRotation:UpdateRotationHinterIcon("Swipe (Not Ready)")
    else
      easyRotation:UpdateRotationHinterIcon("Shred (Not Ready)")
    end
  end
end