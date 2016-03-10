easyRotation.modules.drainLock = {}

function easyRotation.modules.drainLock.init()
  local _,playerClass = UnitClass("player")
  local _, _, _, _, points1, _, _, _ = GetSpecializationInfo(1, false, false, nil)
  local _, _, _, _, points2, _, _, _ = GetSpecializationInfo(2, false, false, nil)
  local _, _, _, _, points3, _, _, _ = GetSpecializationInfo(3, false, false, nil)
  return playerClass == "WARLOCK" and points1 > (points2 + points3) and (points2 > points3) and (points2 + points3) >= 0
end

function easyRotation.modules.drainLock.InitializeButton(easyRotationBtn)
  easyRotationBtn:SetAttribute("unit", "target")
  easyRotationBtn:RegisterForClicks("LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down",
                              "Button6Down", "Button7Down", "Button8Down", "Button9Down", "Button10Down",
                              "Button11Down", "Button12Down", "Button13Down", "Button14Down", "Button15Down")

  easyRotationBtn:SetAttribute("*harmbutton1", "harm1")
  easyRotationBtn:SetAttribute("*harmbutton2", "harm2")
  easyRotationBtn:SetAttribute("*harmbutton3", "harm3")
  easyRotationBtn:SetAttribute("*harmbutton4", "harm4")
  easyRotationBtn:SetAttribute("*harmbutton5", "harm5")
  easyRotationBtn:SetAttribute("type", "macro")
  easyRotationBtn:SetAttribute("macrotext-harm1", easyRotation.modules.drainLock.macroTextWrapper("Drain Life",false))
  easyRotationBtn:SetAttribute("macrotext-harm2", easyRotation.modules.drainLock.macroTextWrapper("Haunt",false))
  easyRotationBtn:SetAttribute("macrotext-harm3", easyRotation.modules.drainLock.macroTextWrapper("Unstable Affliction",false))
  easyRotationBtn:SetAttribute("macrotext-harm4", easyRotation.modules.drainLock.macroTextWrapper("Life Tap",false))
  easyRotationBtn:SetAttribute("macrotext-harm5", easyRotation.modules.drainLock.macroTextWrapper("Soul Fire",false))
  easyRotationBtn:SetAttribute("ctrl-macrotext-harm1", easyRotation.modules.drainLock.macroTextWrapper("Fel Flame",false))
  easyRotationBtn:SetAttribute("ctrl-macrotext-harm2", easyRotation.modules.drainLock.macroTextWrapper("Shadowflame",false))
  easyRotationBtn:SetAttribute("ctrl-macrotext-harm3", easyRotation.modules.drainLock.macroTextWrapper("Drain Soul",false))
  easyRotationBtn:SetAttribute("ctrl-macrotext-harm4", easyRotation.modules.drainLock.macroTextWrapper("Shadow Bolt",false))
  easyRotationBtn:SetAttribute("ctrl-macrotext-harm5", easyRotation.modules.drainLock.macroTextWrapper("Soulburn",true)) -- Soulburn
end

function easyRotation.modules.drainLock.macroTextWrapper(spell,instant)
  return [[/console Sound_EnableSFX 0
/use 13
/use 14
/cast Demon Soul
/cast [@pettarget, exists] Shadow Bite
]]..(instant and "/cast Soulburn\n" or "")..[[/cast ]]..spell.."\n"..[[
/console Sound_EnableSFX 1]]
end

function easyRotation.modules.drainLock.DecideSpells()
  -- ations=flask,type=draconic_mind
  -- actions+=/food,type=seafood_magnifique_feast
  -- actions+=/fel_armor
  -- actions+=/summon_succubus
  -- actions+=/dark_intent
  -- actions+=/snapshot_stats
  -- actions+=/use_item,name=figurine__jeweled_serpent
  -- actions+=/volcanic_potion,if=buff.bloodlust.react|!in_combat|target.health_pct<=20
  -- actions+=/corruption,if=(!ticking|remains<tick_time)&miss_react
  -- actions+=/unstable_affliction,if=(!ticking|remains<(cast_time+tick_time))&target.time_to_die>=5&miss_react
  -- actions+=/bane_of_doom,if=target.time_to_die>15&!ticking&miss_react
  -- actions+=/haunt
  -- actions+=/fel_flame,if=buff.tier11_4pc_caster.react&dot.unstable_affliction.remains<8
  -- actions+=/summon_doomguard,if=time>10
  -- actions+=/drain_soul,interrupt=1,if=target.health_pct<=25
  -- actions+=/shadowflame
  -- actions+=/demon_soul,if=buff.shadow_trance.react
  -- actions+=/shadow_bolt,if=buff.shadow_trance.react
  -- actions+=/life_tap,mana_percentage<=5
  -- actions+=/soulburn
  -- actions+=/drain_life
  -- actions+=/life_tap,moving=1,if=mana_pct<80&mana_pct<target.health_pct
  -- actions+=/fel_flame,moving=1
  -- actions+=/life_tap

  if not easyRotation:UnitHasDebuff("target","Curse of the Elements") or
         easyRotation:UnitHasDebuffRemaining("target","Curse of the Elements") < easyRotation.fuzzTime then
    easyRotation:UpdateButton("Curse of the Elements")
  elseif not easyRotation:UnitHasDebuff("target","Corruption") or
         easyRotation:UnitHasDebuffRemaining("target","Corruption") < easyRotation.fuzzTime then
    -- corruption,if=(!ticking|remains<tick_time)&miss_react
    easyRotation:UpdateButton("Corruption")
  elseif not easyRotation:IsMoving() and easyRotation:SpellNotCastRecently("Unstable Affliction") and
         not easyRotation:IsCastingSpell("Unstable Affliction") and
         (not easyRotation:UnitHasDebuff("target","Unstable Affliction") or
         easyRotation:UnitHasDebuffRemaining("target","Unstable Affliction") < easyRotation.fuzzTime) then
    -- unstable_affliction,if=(!ticking|remains<(cast_time+tick_time))&target.time_to_die>=5&miss_react
    easyRotation:UpdateButton("Unstable Affliction")
  elseif not easyRotation:UnitHasDebuff("target","Bane of Doom") or
         easyRotation:UnitHasDebuffRemaining("target","Bane of Doom") < easyRotation.fuzzTime then
    -- bane_of_doom,if=target.time_to_die>15&!ticking&miss_react
    easyRotation:UpdateButton("Bane of Doom")
  elseif not easyRotation:IsMoving() and (easyRotation:SpellNotCastRecently("Haunt") and
         not easyRotation:IsCastingSpell("Haunt") and
         (not easyRotation:UnitHasDebuff("target","Haunt") or
         easyRotation:UnitHasDebuffRemaining("target","Haunt") < easyRotation.fuzzTime)) then
    -- haunt
    easyRotation:UpdateButton("Haunt")
  elseif easyRotation:UnitHasBuff("player","Fel Spark") then
    -- fel_flame,if=buff.tier11_4pc_caster.react&dot.unstable_affliction.remains<8
    easyRotation:UpdateButton("Fel Flame")
  elseif not easyRotation:IsMoving() and easyRotation:UnitHealthPercent("target") < 25 then
      -- drain_soul,interrupt=1,if=target.health_pct<=25
      easyRotation:UpdateButton("Drain Soul")
  elseif easyRotation:GetRange("target") < 10 and
         easyRotation:IsSpellReady("Shadowflame",easyRotation.fuzzTime)  then
    -- shadowflame
    easyRotation:UpdateButton("Shadowflame")
  elseif easyRotation:UnitHasBuff("player","Shadow Trance") then
    -- shadow_bolt,if=buff.shadow_trance.react
    easyRotation:UpdateButton("Shadow Bolt")
  elseif easyRotation:UnitManaPercent("player") < 50 and
         easyRotation:UnitHealthPercent("player") > 50 then
    -- life_tap,mana_percentage<=5
    easyRotation:UpdateButton("Life Tap")
  elseif easyRotation:IsMoving() then
    -- fel_flame,moving=1
    easyRotation:UpdateButton("Fel Flame")
  elseif UnitPower("player",SPELL_POWER_SOUL_SHARDS) > 0 and easyRotation:IsSpellReady("Soulburn",easyRotation.fuzzTime) then
    -- soulburn
    easyRotation:UpdateButton("Soulburn")
  else
    -- drain_life
    easyRotation:UpdateButton("Drain Life")
  end
end
