easyRotation.rotations.demoLock = {}

function easyRotation.rotations.demoLock.init()
  local _,playerClass = UnitClass("player")
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
  --easyRotation.lastWrathstorm = 0
  return playerClass == "WARLOCK" and GetSpecialization() == 2
end

function easyRotation.rotations.demoLock.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true
  end
end


--Effect: +10% Spell Power:
--Arcane Brilliance, Dalaran Brilliance, Dark Intent, Wisdom of the Serpent, Serpent's Cunning, Qiraji Fortitude, Still Water

-- SIMCRAFT NOTES
--actions.precombat=flask,type=greater_draenic_intellect_flask
--actions.precombat+=/food,type=sleeper_sushi
--actions.precombat+=/dark_intent,if=!aura.spell_power_multiplier.up
--actions.precombat+=/summon_pet,if=!talent.demonic_servitude.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.grimoire_of_sacrifice.down)
--actions.precombat+=/summon_doomguard,if=talent.demonic_servitude.enabled&active_enemies<9
--actions.precombat+=/summon_infernal,if=talent.demonic_servitude.enabled&active_enemies>=9
--actions.precombat+=/snapshot_stats
--actions.precombat+=/potion,name=draenic_intellect
--actions.precombat+=/soul_fire
--
--# Executed every time the actor is available.
--
--actions=potion,name=draenic_intellect,if=buff.bloodlust.react|(buff.dark_soul.up&(trinket.proc.any.react|trinket.stacking_proc.any.react>6)&!buff.demonbolt.remains)|target.health.pct<20
--actions+=/berserking
--actions+=/blood_fury
--actions+=/arcane_torrent
--actions+=/mannoroths_fury
--actions+=/dark_soul,if=talent.demonbolt.enabled&((charges=2&((!glyph.imp_swarm.enabled&(dot.corruption.ticking|trinket.proc.haste.remains<=10))|cooldown.imp_swarm.remains))|target.time_to_die<buff.demonbolt.remains|(!buff.demonbolt.remains&demonic_fury>=790))
--actions+=/dark_soul,if=!talent.demonbolt.enabled&((charges=2&(time>6|(debuff.shadowflame.stack=1&action.hand_of_guldan.in_flight)))|!talent.archimondes_darkness.enabled|(target.time_to_die<=20&!glyph.dark_soul.enabled|target.time_to_die<=10)|(target.time_to_die<=60&demonic_fury>400)|((trinket.stacking_proc.multistrike.remains>7.5|trinket.proc.any.remains>7.5)&demonic_fury>=400))
--actions+=/imp_swarm,if=!talent.demonbolt.enabled&(buff.dark_soul.up|(cooldown.dark_soul.remains>(120%(1%spell_haste)))|time_to_die<32)&time>3
--actions+=/felguard:felstorm
--actions+=/wrathguard:wrathstorm
--actions+=/wrathguard:mortal_cleave,if=pet.wrathguard.cooldown.wrathstorm.remains>5
--actions+=/hand_of_guldan,if=!in_flight&dot.shadowflame.remains<travel_time+action.shadow_bolt.cast_time&(((set_bonus.tier17_4pc=0&((charges=1&recharge_time<4)|charges=2))|(charges=3|(charges=2&recharge_time<13.8-travel_time*2))&((cooldown.cataclysm.remains>dot.shadowflame.duration)|!talent.cataclysm.enabled))|dot.shadowflame.remains>travel_time)
--actions+=/hand_of_guldan,if=!in_flight&dot.shadowflame.remains<travel_time+action.shadow_bolt.cast_time&talent.demonbolt.enabled&((set_bonus.tier17_4pc=0&((charges=1&recharge_time<4)|charges=2))|(charges=3|(charges=2&recharge_time<13.8-travel_time*2))|dot.shadowflame.remains>travel_time)
--actions+=/hand_of_guldan,if=!in_flight&dot.shadowflame.remains<3.7&time<5&buff.demonbolt.remains<gcd*2&(charges>=2|set_bonus.tier17_4pc=0)&action.dark_soul.charges>=1
--actions+=/service_pet,if=talent.grimoire_of_service.enabled&(target.time_to_die>120|target.time_to_die<20|(buff.dark_soul.remains&target.health.pct<20))
--actions+=/summon_doomguard,if=!talent.demonic_servitude.enabled&active_enemies<9
--actions+=/summon_infernal,if=!talent.demonic_servitude.enabled&active_enemies>=9
--actions+=/call_action_list,name=db,if=talent.demonbolt.enabled
--actions+=/kiljaedens_cunning,if=!cooldown.cataclysm.remains&buff.metamorphosis.up
--actions+=/cataclysm,if=buff.metamorphosis.up
--actions+=/immolation_aura,if=demonic_fury>450&active_enemies>=3&buff.immolation_aura.down
--actions+=/doom,if=buff.metamorphosis.up&target.time_to_die>=30*spell_haste&remains<=(duration*0.3)&(remains<cooldown.cataclysm.remains|!talent.cataclysm.enabled)&(buff.dark_soul.down|!glyph.dark_soul.enabled)&trinket.stacking_proc.multistrike.react<10
--actions+=/corruption,cycle_targets=1,if=target.time_to_die>=6&remains<=(0.3*duration)&buff.metamorphosis.down
--actions+=/cancel_metamorphosis,if=buff.metamorphosis.up&((demonic_fury<650&!glyph.dark_soul.enabled)|demonic_fury<450)&buff.dark_soul.down&(trinket.stacking_proc.multistrike.down&trinket.proc.any.down|demonic_fury<(800-cooldown.dark_soul.remains*(10%spell_haste)))&target.time_to_die>20
--actions+=/cancel_metamorphosis,if=buff.metamorphosis.up&action.hand_of_guldan.charges>0&dot.shadowflame.remains<action.hand_of_guldan.travel_time+action.shadow_bolt.cast_time&((demonic_fury<100&buff.dark_soul.remains>10)|time<15)
--actions+=/cancel_metamorphosis,if=buff.metamorphosis.up&action.hand_of_guldan.charges=3&(!buff.dark_soul.remains>gcd|action.metamorphosis.cooldown<gcd)
--actions+=/chaos_wave,if=buff.metamorphosis.up&(buff.dark_soul.up&active_enemies>=2|(charges=3|set_bonus.tier17_4pc=0&charges=2))
--actions+=/soul_fire,if=buff.metamorphosis.up&buff.molten_core.react&(buff.dark_soul.remains>execute_time|target.health.pct<=25)&(((buff.molten_core.stack*execute_time>=trinket.stacking_proc.multistrike.remains-1|demonic_fury<=ceil((trinket.stacking_proc.multistrike.remains-buff.molten_core.stack*execute_time)*40)+80*buff.molten_core.stack)|target.health.pct<=25)&trinket.stacking_proc.multistrike.remains>=execute_time|trinket.stacking_proc.multistrike.down|!trinket.has_stacking_proc.multistrike)
--actions+=/touch_of_chaos,cycle_targets=1,if=buff.metamorphosis.up&dot.corruption.remains<17.4&demonic_fury>750
--actions+=/touch_of_chaos,if=buff.metamorphosis.up
--actions+=/metamorphosis,if=buff.dark_soul.remains>gcd&(time>6|debuff.shadowflame.stack=2)&(demonic_fury>300|!glyph.dark_soul.enabled)&(demonic_fury>=80&buff.molten_core.stack>=1|demonic_fury>=40)
--actions+=/metamorphosis,if=(trinket.stacking_proc.multistrike.react|trinket.proc.any.react)&((demonic_fury>450&action.dark_soul.recharge_time>=10&glyph.dark_soul.enabled)|(demonic_fury>650&cooldown.dark_soul.remains>=10))
--actions+=/metamorphosis,if=!cooldown.cataclysm.remains&talent.cataclysm.enabled
--actions+=/metamorphosis,if=!dot.doom.ticking&target.time_to_die>=30%(1%spell_haste)&demonic_fury>300
--actions+=/metamorphosis,if=(demonic_fury>750&(action.hand_of_guldan.charges=0|(!dot.shadowflame.ticking&!action.hand_of_guldan.in_flight_to_target)))|floor(demonic_fury%80)*action.soul_fire.execute_time>=target.time_to_die
--actions+=/metamorphosis,if=demonic_fury>=950
--actions+=/cancel_metamorphosis
--actions+=/imp_swarm
--actions+=/hellfire,interrupt=1,if=active_enemies>=5
--actions+=/soul_fire,if=buff.molten_core.react&(buff.molten_core.stack>=7|target.health.pct<=25|(buff.dark_soul.remains&cooldown.metamorphosis.remains>buff.dark_soul.remains)|trinket.proc.any.remains>execute_time|trinket.stacking_proc.multistrike.remains>execute_time)&(buff.dark_soul.remains<action.shadow_bolt.cast_time|buff.dark_soul.remains>execute_time)
--actions+=/soul_fire,if=buff.molten_core.react&target.time_to_die<(time+target.time_to_die)*0.25+cooldown.dark_soul.remains
--actions+=/life_tap,if=mana.pct<40&buff.dark_soul.down
--actions+=/hellfire,interrupt=1,if=active_enemies>=4
--actions+=/shadow_bolt
--actions+=/hellfire,moving=1,interrupt=1
--actions+=/life_tap
--
--actions.db=immolation_aura,if=demonic_fury>450&active_enemies>=5&buff.immolation_aura.down
--actions.db+=/doom,cycle_targets=1,if=buff.metamorphosis.up&active_enemies>=6&target.time_to_die>=30*spell_haste&remains<=(duration*0.3)&(buff.dark_soul.down|!glyph.dark_soul.enabled)
--actions.db+=/kiljaedens_cunning,moving=1,if=buff.demonbolt.stack=0|(buff.demonbolt.stack<4&buff.demonbolt.remains>=(40*spell_haste-execute_time))
--actions.db+=/demonbolt,if=buff.demonbolt.stack=0|(buff.demonbolt.stack<4&buff.demonbolt.remains>=(40*spell_haste-execute_time))
--actions.db+=/doom,cycle_targets=1,if=buff.metamorphosis.up&target.time_to_die>=30*spell_haste&remains<=(duration*0.3)&(buff.dark_soul.down|!glyph.dark_soul.enabled)
--actions.db+=/corruption,cycle_targets=1,if=target.time_to_die>=6&remains<=(0.3*duration)&buff.metamorphosis.down
--actions.db+=/cancel_metamorphosis,if=buff.metamorphosis.up&buff.demonbolt.stack>3&demonic_fury<=600&target.time_to_die>buff.demonbolt.remains&buff.dark_soul.down
--actions.db+=/chaos_wave,if=buff.metamorphosis.up&buff.dark_soul.up&active_enemies>=2&demonic_fury>450
--actions.db+=/soul_fire,if=buff.metamorphosis.up&buff.molten_core.react&(((buff.dark_soul.remains>execute_time)&demonic_fury>=175)|(target.time_to_die<buff.demonbolt.remains))
--actions.db+=/soul_fire,if=buff.metamorphosis.up&buff.molten_core.react&target.health.pct<=25&(((demonic_fury-80)%800)>(buff.demonbolt.remains%(40*spell_haste)))&demonic_fury>=750
--actions.db+=/touch_of_chaos,cycle_targets=1,if=buff.metamorphosis.up&dot.corruption.remains<17.4&demonic_fury>750
--actions.db+=/touch_of_chaos,if=buff.metamorphosis.up&(target.time_to_die<buff.demonbolt.remains|(demonic_fury>=750&buff.demonbolt.remains)|buff.dark_soul.up)
--actions.db+=/touch_of_chaos,if=buff.metamorphosis.up&(((demonic_fury-40)%800)>(buff.demonbolt.remains%(40*spell_haste)))&demonic_fury>=750
--actions.db+=/metamorphosis,if=buff.dark_soul.remains>gcd&(demonic_fury>=470|buff.dark_soul.remains<=action.demonbolt.execute_time*3)&(buff.demonbolt.down|target.time_to_die<buff.demonbolt.remains|(buff.dark_soul.remains>execute_time&demonic_fury>=175))
--actions.db+=/metamorphosis,if=buff.demonbolt.down&demonic_fury>=480&(action.dark_soul.charges=0|!talent.archimondes_darkness.enabled&cooldown.dark_soul.remains)
--actions.db+=/metamorphosis,if=(demonic_fury%80)*2*spell_haste>=target.time_to_die&target.time_to_die<buff.demonbolt.remains
--actions.db+=/metamorphosis,if=target.time_to_die>=30*spell_haste&!dot.doom.ticking&buff.dark_soul.down&time>10
--actions.db+=/metamorphosis,if=demonic_fury>750&buff.demonbolt.remains>=action.metamorphosis.cooldown
--actions.db+=/metamorphosis,if=(((demonic_fury-120)%800)>(buff.demonbolt.remains%(40*spell_haste)))&buff.demonbolt.remains>=10&dot.doom.remains<=dot.doom.duration*0.3
--actions.db+=/cancel_metamorphosis
--actions.db+=/imp_swarm
--actions.db+=/hellfire,interrupt=1,if=active_enemies>=5
--actions.db+=/soul_fire,if=buff.molten_core.react&(buff.dark_soul.remains<action.shadow_bolt.cast_time|buff.dark_soul.remains>cast_time)
--actions.db+=/life_tap,if=mana.pct<40&buff.dark_soul.down
--actions.db+=/hellfire,interrupt=1,if=active_enemies>=4
--actions.db+=/shadow_bolt
--actions.db+=/hellfire,moving=1,interrupt=1
--actions.db+=/life_tap

function easyRotation.rotations.demoLock.DecideBuffs()
  if not (easyRotation:UnitHasBuff("player","Dark Intent")) then
      easyRotation:UpdateRotationHinterIcon("Dark Intent")
  end
end

function easyRotation.rotations.demoLock.DecideSpells()
  if easyRotation:UnitHasBuff("player","Metamorphosis") then
    easyRotation.rotations.demoLock.DecideMetamorphosisSpells()
  else
    easyRotation.rotations.demoLock.DecideNormalSpells()
  end
end

function easyRotation.rotations.demoLock.DecideNormalSpells()
-- Trinket procs
-- Exquisite Proficiency

--easyRotation:UnitHasBuffStacks("player","Molten Core")

  -- cast Hand of Gul'dan only when you have a stack and its about to fall off (you want to maintain 2 stacks)
  if easyRotation:PlayerCanCastSpell("Hand of Gul'dan") and 
      easyRotation:SpellNotCastRecently("Hand of Gul'dan") and
      (easyRotation:GetPlayerSpellCharges("Hand of Gul'dan") > 0 and easyRotation:UnitHasYourDebuff("target","Hand of Gul'dan") and easyRotation:UnitHasYourDebuffRemaining("target","Hand of Gul'dan") < 2.5) then
    easyRotation:UpdateRotationHinterIcon("Hand of Gul'dan")
  elseif not easyRotation:UnitHasYourDebuff("target","Corruption") or
      easyRotation:UnitHasYourDebuffRemaining("target","Corruption") < 6 then
    easyRotation:UpdateRotationHinterIcon("Corruption")
  elseif easyRotation:PlayerCanCastSpell("Soul Fire") and
        easyRotation:SpellNotCastRecently("Soul Fire") and
        (easyRotation:UnitHasBuffStacks("player","Molten Core") > 4 or easyRotation:UnitHealthPercent("target") < 25) then
    easyRotation:UpdateRotationHinterIcon("Soul Fire")
  -- start up your Hand of Gul'dan when you have 2 stack and the target dosent have the debuff
  elseif easyRotation:PlayerCanCastSpell("Hand of Gul'dan") and 
      easyRotation:SpellNotCastRecently("Hand of Gul'dan") and
      (easyRotation:GetPlayerSpellCharges("Hand of Gul'dan") > 1 and not easyRotation:UnitHasYourDebuff("target","Hand of Gul'dan")) then
    easyRotation:UpdateRotationHinterIcon("Hand of Gul'dan")
  elseif easyRotation:UnitManaPercent("player") < 25 and
      easyRotation:UnitHealthPercent("player") > 75 then
    easyRotation:UpdateRotationHinterIcon("Life Tap")
  elseif easyRotation:GetPlayerSpellCharges("Hand of Gul'dan") > 0 and 
      easyRotation:UnitHasYourDebuff("target","Hand of Gul'dan") and
      easyRotation:UnitHasYourDebuffRemaining("target","Hand of Gul'dan") < 4 then
    easyRotation:UpdateRotationHinterIcon("Shadow Bolt (Not Ready)")
  else 
    easyRotation:UpdateRotationHinterIcon("Shadow Bolt")
  end
end

function easyRotation.rotations.demoLock.DecideMetamorphosisSpells()
  if (easyRotation:UnitHasDebuffRemaining("target","Doom") < easyRotation.gcd) then
    easyRotation:UpdateRotationHinterIcon("Doom")
  elseif easyRotation:UnitHasDebuffRemaining("target","Corruption") < 6 or easyRotation:GetPlayerResource(SPELL_POWER_DEMONIC_FURY) > 970 then
    easyRotation:UpdateRotationHinterIcon("Touch of Chaos")
  elseif easyRotation:PlayerCanCastSpell("Soul Fire") and
     (easyRotation:UnitHasBuffStacks("player","Molten Core") > 1 or (easyRotation:UnitHasBuffStacks("player","Molten Core") > 0 and easyRotation:SpellNotCastRecently("Soul Fire")))then
    easyRotation:UpdateRotationHinterIcon("Soul Fire")
  else
    easyRotation:UpdateRotationHinterIcon("Touch of Chaos")
  end

  --if easyRotation:UnitHasDebuffRemaining("target","Corruption") < 15 then
  --  easyRotation:UpdateRotationHinterIcon("Touch of Chaos")
  --elseif easyRotation:UnitHealthPercent("player") < 50 and easyRotation:PlayerCanCastSpell("Dark Regeneration") then
  --  easyRotation:UpdateRotationHinterIcon("Dark Regeneration")
  --elseif easyRotationVars.mode == "AOE" and easyRotation:PlayerCanCastSpell("Immolation Aura") then
  --  easyRotation:UpdateRotationHinterIcon("Immolation Aura")
  --elseif easyRotation:UnitHasBuffRemaining("player","Aura of the Elements") < 45 then
  --   easyRotation:UpdateRotationHinterIcon("Aura of the Elements")
  --elseif UnitIsPlayer("target") and (easyRotation:UnitHasDebuffRemaining("target","urse of Enfeeblement") < easyRotation.gcd
  --     and easyRotation:UnitHasBuffRemaining("player","Aura of Enfeeblement") < easyRotation.gcd) then
  --   easyRotation:UpdateRotationHinterIcon("Curse of Enfeeblement")
  --elseif (easyRotation:UnitHasDebuffRemaining("target","Doom") < easyRotation.gcd) then
  --  easyRotation:UpdateRotationHinterIcon("Doom")
  --elseif easyRotation:PlayerCanCastSpell("Soul Fire") and 
  --    easyRotation:UnitHasBuffStacks("player","Molten Core") > 1 then
  --  easyRotation:UpdateRotationHinterIcon("Soul Fire")
  --elseif easyRotation:PlayerCanCastSpell("Hand of Gul'dan") and 
  --     easyRotation:SpellNotCastRecently("Chaos Wave") then
  --   easyRotation:UpdateRotationHinterIcon("Chaos Wave")
  --elseif easyRotation:PlayerCanCastSpell("Soul Fire") and 
  --    (easyRotation:SpellNotCastRecently("Soul Fire") or easyRotation:UnitHealthPercent("target") < 25) and
  --    easyRotation:UnitHasBuff("player","Molten Core") then
  --  easyRotation:UpdateRotationHinterIcon("Soul Fire")
  --elseif easyRotationVars.mode == "AOE" and easyRotation:PlayerCanCastSpell("Void Ray") and not easyRotation:PlayerCanCastSpell("Touch of Chaos") then
  --  easyRotation:UpdateRotationHinterIcon("Void Ray")
  --else
  --  easyRotation:UpdateRotationHinterIcon("Touch of Chaos (Waiting)")
  --end
end

function easyRotation.rotations.demoLock.CombatLog(timestamp, event, uknownBoolean, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
  if (event ~= nil and srcName ~= nil and UnitIsUnit(srcName, "pet")) then
    if ((event == "SPELL_CAST_START" or event == "SPELL_CAST_SUCCESS" or event == "SPELL_MISS")) then
      local arg = {...}
      if arg[4] == "Wrathstorm" then
        easyRotation.lastWrathstorm = GetTime()
      end
    end
  end
end

function getWarlockPetTypeName()
  for i=1,10 do
    local name, _, _, _, _, _, _ = GetPetActionInfo(i)
    if name == "Axe Toss" or name == "Felstorm" or name == "Legion Strike" or name == "Pursuit" then
      return "Felguard"
    elseif name == "Devour Magic" or name == "Fel Intelligence" or name == "Shadow Bite" or name == "Spell Lock" then
      return "Felhunter"
    end
  end
  return "uknown"
end

function isFelstormReady()
  return easyRotation.lastWrathstorm == 0 or GetTime() - (easyRotation.lastWrathstorm + (45 - 6)) > 0
end
