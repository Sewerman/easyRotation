easyRotation.rotations.shadowPriest = {}

function easyRotation.rotations.shadowPriest.init()
  local _,playerClass = UnitClass("player")
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end

return playerClass == "PRIEST" and GetSpecialization () == 3
end

function easyRotation.rotations.shadowPriest.Slash(cmd,val)
  if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
    easyRotationVars.mode = "AOE"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
    return true
  elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
    easyRotationVars.mode = "Single Target"
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
    return true
  else
    return false
  end
end

function easyRotation.rotations.shadowPriest.DecideSpells()
  --actions=flask,type=draconic_mind
  --actions+=/food,type=seafood_magnifique_feast
  --actions+=/fortitude
  --actions+=/inner_fire
  --actions+=/shadow_form
  --actions+=/vampiric_embrace
  --actions+=/snapshot_stats
  --actions+=/volcanic_potion,if=!in_combat
  --actions+=/volcanic_potion,if=buff.bloodlust.react|target.time_to_die<=40
  --actions+=/mind_blast
  --actions+=/shadow_word_pain,if=(!ticking|dot.shadow_word_pain.remains<gcd+0.5)&miss_react
  --actions+=/devouring_plague,if=(!ticking|dot.devouring_plague.remains<gcd+1.0)&miss_react
  --actions+=/stop_moving,health_percentage<=25,if=cooldown.shadow_word_death.remains>=0.2|dot.vampiric_touch.remains<cast_time+2.5
  --actions+=/vampiric_touch,if=(!ticking|dot.vampiric_touch.remains<cast_time+2.5)&miss_react
  --actions+=/archangel,if=buff.dark_evangelism.stack>=5&dot.vampiric_touch.remains>5&dot.devouring_plague.remains>5
  --actions+=/start_moving,health_percentage<=25,if=cooldown.shadow_word_death.remains<=0.1
  --actions+=/shadow_word_death,health_percentage<=25
  --actions+=/shadow_fiend
  --actions+=/shadow_word_death,if=mana_pct<10
  --actions+=/mind_flay
  --actions+=/shadow_word_death,moving=1
  --actions+=/devouring_plague,moving=1,if=mana_pct>10
  --actions+=/dispersion
  if easyRotation:PlayerCanCastSpell("Shadowform") and not
     easyRotation:UnitHasBuff("player","Shadowform") then
     easyRotation:UpdateRotationHinterIcon("Shadowform")
  elseif (easyRotation:UnitManaPercent("player") < 50) and
         easyRotation:PlayerCanCastSpell("Shadow Word: Death") then
    --actions+=/shadow_word_death,mana_percentage<=25
    easyRotation:UpdateRotationHinterIcon("Shadow Word: Death")
  elseif easyRotation:PlayerCanCastSpell("Mind Blast") then
    -- mind_blast
    easyRotation:UpdateRotationHinterIcon("Mind Blast")
  elseif easyRotation:UnitHasYourDebuffRemaining("target","Shadow Word: Pain") < 1 then
    --actions+=/shadow_word_pain,if=(!ticking|dot.shadow_word_pain.remains<gcd+0.5)&miss_react
    easyRotation:UpdateRotationHinterIcon("Shadow Word: Pain")
  elseif UnitPower("player",SPELL_POWER_SHADOW_ORBS) >= 3 and
     easyRotation:UnitHasYourDebuffRemaining("target","Devouring Plague") < 1.5 and 
     easyRotation:PlayerCanCastSpell("Devouring Plague") then
    --actions+=/devouring_plague,if=(!ticking|dot.devouring_plague.remains<gcd+1.0)&miss_react
    easyRotation:UpdateRotationHinterIcon("Devouring Plague")
  elseif easyRotation:PlayerCanCastSpell("Vampiric Touch")
         and easyRotation:UnitHasYourDebuffRemaining("target","Vampiric Touch") < 2.5 then
    --actions+=/vampiric_touch,if=(!ticking|dot.vampiric_touch.remains<cast_time+2.5)&miss_react
    easyRotation:UpdateRotationHinterIcon("Vampiric Touch")
  --elseif --easyRotation:PlayerCanCastSpell("Archangel")and 
      --   easyRotation:UnitHasBuffStacks("player","Dark Evangelism") >= 5 and
      --   easyRotation:UnitHasYourDebuffRemaining("target","Vampiric Touch") > 5 and
      --   easyRotation:UnitHasYourDebuffRemaining("target","Devouring Plague") > 5 and
     --    easyRotation:PlayerCanCastSpell("Archangel") then
    --actions+=/archangel,if=buff.dark_evangelism.stack>=5&dot.vampiric_touch.remains>5&dot.devouring_plague.remains>5
   -- easyRotation:UpdateRotationHinterIcon("Archangel")
  elseif (easyRotation:UnitHealthPercent("target") < 25) and
         easyRotation:PlayerCanCastSpell("Shadow Word: Death") then
    --actions+=/shadow_word_death,health_percentage<=25
    easyRotation:UpdateRotationHinterIcon("Shadow Word: Death")
  elseif easyRotation:PlayerCanCastSpell("Shadowfiend") then
    --actions+=/shadow_fiend
    easyRotation:UpdateRotationHinterIcon("Shadowfiend")
  elseif easyRotation:PlayerCanCastSpell("Shadow Word: Death") then
    -- shadow_word_death,moving=1
    easyRotation:UpdateRotationHinterIcon("Shadow Word: Death")
  elseif UnitPower("player",SPELL_POWER_SHADOW_ORBS) >= 3 and 
         easyRotation:PlayerCanCastSpell("Devouring Plague") and 
         easyRotation:IsMoving() and
         easyRotation:UnitHasYourDebuffRemaining("target","Devouring Plague") < 18 then
    --actions+=/devouring_plague,moving=1,if=mana_pct>10
    easyRotation:UpdateRotationHinterIcon("Devouring Plague")
  elseif easyRotationVars.mode == "AOE" and 
      easyRotation:PlayerCanCastSpell("Mind Sear") then
      --actions+=/mind_sear
      easyRotation:UpdateRotationHinterIcon("Mind Sear")
   elseif easyRotation:PlayerCanCastSpell("Mind Flay")  
      --actions+=/mind_flay
      then easyRotation:UpdateRotationHinterIcon("Mind Flay")
 --   elseif easyRotation:PlayerCanCastSpell("Smite")
 --    then easyRotation:UpdateRotationHinterIcon("Smite")
    end
end
