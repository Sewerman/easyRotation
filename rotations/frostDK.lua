easyRotation.modules.frostdk = {}

function easyRotation.modules.frostdk.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "DEATH KNIGHT" and GetSpecialization() == 2
end

function easyRotation.modules.frostdk.initializeVariables()
  if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
end

function easyRotation.modules.frostdk.Slash(cmd,val)
 -- if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
 --   easyRotationVars.mode = "AOE"
  --  DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
  --  return true
 -- elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
 --   easyRotationVars.mode = "Single Target"
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
 --   return true
if (cmd == 'pest' and easyRotationVars.pest) then
    easyRotationVars.pest = false
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation not tracking Pestilence",1,0,0)
    return true
  elseif (cmd == 'pest' and not easyRotationVars.pest) then
    easyRotationVars.pest = true
    DEFAULT_CHAT_FRAME:AddMessage("easyRotation tracking Pestilence",0,0,1)
    return true
  else
    return false
  end
end

function easyRotation.modules.frostdk.DecideSpells()
--Single Target Priority 
--Diseases 
--Obliterate if both Frost/Unholy pairs and/or both Death runes are up, or if Killing Machine is procced  
--Frost Strike if RP capped  
--Rime 
--Obliterate 
--Frost Strike 
--Horn of Winter 

-- blood_fury,time>=10
--golemblood_potion,if=!in_combat|buff.bloodlust.react|target.time_to_die<=60  
--auto_attack
--pillar_of_frost
--blood_tap,if=death!=2
--raise_dead,if=buff.rune_of_the_fallen_crusader.react&buff.heart_of_rage.react
--raise_dead,time>=15
--outbreak,if=dot.frost_fever.remains<=2|dot.blood_plague.remains<=2
--howling_blast,if=dot.frost_fever.remains<=2
--plague_strike,if=dot.blood_plague.remains<=2
--obliterate,if=frost=2&unholy=2
--obliterate,if=death=2
--obliterate,if=buff.killing_machine.react
--empower_rune_weapon,if=target.time_to_die<=120&buff.killing_machine.react
--frost_strike,if=runic_power>=90&!buff.bloodlust.react
--frost_strike,if=runic_power>=95
--howling_blast,if=buff.rime.react
--howling_blast,if=(death+unholy)=0&!buff.bloodlust.react
--obliterate
--empower_rune_weapon,if=target.time_to_die<=45
--frost_strike
--howling_blast
--blood_tap
--empower_rune_weapon
--horn_of_winter
 if easyRotationVars.mode == "Single Target" then
  if easyRotation:PlayerCanCastSpell("Empower Rune Weapon",easyRotation.fuzzTime) 
          and easyRotation:PlayerTimeInCombat() > 120
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) <= 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) <= 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) <= 0
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Empower Rune Weapon")   
   elseif easyRotation:PlayerCanCastSpell("Horn of Winter",easyRotation.fuzzTime)
          and not(easyRotation:UnitHasBuff("player","Horn of Winter") 
          or easyRotation:UnitHasBuff("player","Battle Shout"))          
          then easyRotation:UpdateButton("Horn of Winter")
   elseif easyRotation:IsSpellReady("Raise Dead",easyRotation.fuzzTime) 
          and easyRotation:PlayerTimeInCombat() > 5 
          then easyRotation:UpdateButton("Raise Dead")
   elseif easyRotation:UnitHasBuff("player","Blood Presence")
          and easyRotation:PlayerCanCastSpell("Rune Strike",easyRotation.fuzzTime) 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 60
          and easyRotation:PlayerTimeInCombat() > 20
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Rune Strike")   
  -- elseif easyRotation:IsSpellReady("Dark Simulacrum",easyRotation.fuzzTime)  
  --        and easyRotation:UnitManaPercent("target") > 1 
  --        and easyRotation:GetRange("target") < 40 
  --        then easyRotation:UpdateButton("Dark Simulacrum")
   elseif not easyRotation:UnitHasYourDebuff("target","Blood Plague") 
          and not easyRotation:UnitHasYourDebuff("target","Frost Fever") 
          and easyRotation:PlayerCanCastSpell("Outbreak",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Outbreak")
    elseif easyRotationVars.pest 
          and easyRotation:IsSpellReady("Pestilence")
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 1
          and easyRotation:UnitHasYourDebuffRemaining("target", "Blood Plague")>27       
          and easyRotation:UnitHasYourDebuffRemaining("target", "Frost Fever")>27
          and easyRotation:SpellNotCastRecently("Pestilence")
          and easyRotation:GetRange("target") < 6                  
          then easyRotation:UpdateButton("Pestilence")   
   elseif not easyRotation:UnitHasYourDebuff("target","Blood Plague") 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0 
          and easyRotation:PlayerCanCastSpell("Plague Strike",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Plague Strike")
   elseif easyRotation:UnitHasBuffRemaining("target","Blood Plague") > 10
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) > 1 
          and easyRotation:PlayerCanCastSpell("Festering Strike",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Festering Strike")
   elseif not easyRotation:UnitHasDebuff("target","Frost Fever") 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0 
          and easyRotation:PlayerCanCastSpell("Icy Touch",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Icy Touch")
   elseif easyRotation:PlayerCanCastSpell("Obliterate",easyRotation.fuzzTime) 
          and (easyRotation:UnitHasBuff("player","Killing Machine") 
          or (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) >= 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) >= 1)) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Obliterate")
   elseif easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 119
          or easyRotation:UnitHasBuff("player","Killing Machine") 
          and easyRotation:GetRange("target") < 6
          and easyRotation:PlayerCanCastSpell("Frost Strike",easyRotation.fuzzTime)
          then easyRotation:UpdateButton("Frost Strike")
   elseif easyRotation:PlayerCanCastSpell("Howling Blast",easyRotation.fuzzTime) 
          and (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0 
          or easyRotation:UnitHasBuff("player","Freezing Fog")) 
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Howling Blast")
   elseif easyRotation:PlayerCanCastSpell("Death Coil",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 40 
          then easyRotation:UpdateButton("Death Coil")
    end
 elseif easyRotationVars.mode == "AOE" then
  if easyRotation:IsSpellReady("Pestilence")
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 1
          and easyRotation:UnitHasYourDebuffRemaining("target", "Blood Plague")>27       
          and easyRotation:UnitHasYourDebuffRemaining("target", "Frost Fever")>27
          and easyRotation:SpellNotCastRecently("Pestilence")
          and easyRotation:GetRange("target") < 6                  
          then easyRotation:UpdateButton("Pestilence") 
  elseif easyRotation:IsSpellReady("Blood Tap",easyRotation.fuzzTime)
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 0
          and easyRotation:GetRange("target") < 6 
          and easyRotation:PlayerTimeInCombat() > 25
          then easyRotation:UpdateButton("Blood Tap")
   elseif easyRotation:IsSpellReady("Empower Rune Weapon",easyRotation.fuzzTime) 
          and easyRotation:PlayerTimeInCombat() > 120
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) <= 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) <= 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) <= 0
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Empower Rune Weapon")   
   elseif not easyRotation:UnitHasBuff("player","Horn of Winter") and  not easyRotation:UnitHasBuff("player","Battle Shout")
          and easyRotation:IsSpellReady("Horn of Winter",easyRotation.fuzzTime) 
          then easyRotation:UpdateButton("Horn of Winter")
   elseif easyRotation:IsSpellReady("Raise Dead",easyRotation.fuzzTime) 
          and easyRotation:PlayerTimeInCombat() > 5 
          then easyRotation:UpdateButton("Raise Dead")
--   elseif easyRotation:IsSpellReady("Dark Simulacrum",easyRotation.fuzzTime)  
--          and easyRotation:UnitManaPercent("target") > 1 
 --         and easyRotation:GetRange("target") < 40 
 --         then easyRotation:UpdateButton("Dark Simulacrum")
   elseif not easyRotation:UnitHasDebuff("target","Blood Plague") 
          and not easyRotation:UnitHasDebuff("target","Frost Fever") 
          and easyRotation:IsSpellReady("Outbreak",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Outbreak")    
   elseif not easyRotation:UnitHasDebuff("target","Blood Plague") 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0 
          and easyRotation:IsSpellReady("Plague Strike",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Plague Strike")
   elseif easyRotation:UnitHasBuffRemaining("target","Blood Plague") > 6 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) > 1 
          and easyRotation:IsSpellReady("Festering Strike",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Festering Strike")
   elseif not easyRotation:UnitHasDebuff("target","Frost Fever") 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0 
          and easyRotation:IsSpellReady("Icy Touch",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Icy Touch")
   elseif easyRotation:IsSpellReady("Blood Boil") 
          and easyRotation:SpellNotCastRecently("Blood Boil")
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 1
          and easyRotation:GetRange("target") < 10 
          then easyRotation:UpdateButton("Blood Boil")
   elseif  easyRotation:IsSpellReady("Obliterate",easyRotation.fuzzTime) 
          and (easyRotation:UnitHasBuff("player","Killing Machine") 
          or (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) >= 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) >= 1)) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Obliterate")
   elseif easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 119
          or easyRotation:UnitHasBuff("player","Killing Machine") 
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Frost Strike")
   elseif easyRotation:IsSpellReady("Howling Blast",easyRotation.fuzzTime) 
          and (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0 
          or easyRotation:UnitHasBuff("player","Freezing Fog")) 
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Howling Blast")
   elseif easyRotation:IsSpellReady("Death Coil",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 40 
          then easyRotation:UpdateButton("Death Coil")
    end
  end
end