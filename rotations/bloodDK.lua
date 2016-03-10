easyRotation.modules.bloodDK = {}

function easyRotation.modules.bloodDK.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "DEATH KNIGHT" and GetSpecialization() == 1
end

function easyRotation.modules.bloodDK.initializeVariables()
 -- if not easyRotationVars.mode then easyRotationVars.mode = "Single Target" end
  if not easyRotationVars.pest then easyRotationVars.pest = true end 
end

function easyRotation.modules.bloodDK.Slash(cmd,val)
 -- if (cmd == 'mode' and easyRotationVars.mode == "Single Target") then
 --   easyRotationVars.mode = "AOE"
 --   DEFAULT_CHAT_FRAME:AddMessage("easyRotation AOE mode",0,0,1)
 --   return true
 -- elseif (cmd == 'mode' and easyRotationVars.mode  == "AOE") then
  --  easyRotationVars.mode = "Single Target"
  --  DEFAULT_CHAT_FRAME:AddMessage("easyRotation Single Target mode",0,0,1)
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

function easyRotation.modules.bloodDK.DecideSpells()

-- if easyRotationVars.mode == "Single Target" then
  if easyRotation:PlayerCanCastSpell("Empower Rune Weapon",easyRotation.fuzzTime) 
          and easyRotation:PlayerTimeInCombat() > 120
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) <= 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) <= 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) <= 0
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Empower Rune Weapon")
   elseif easyRotation:PlayerCanCastSpell("Blood Tap",easyRotation.fuzzTime)
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 0
          --and easyRotation:GetRange("target") < 6 
          and easyRotation:PlayerTimeInCombat() > 25
          then easyRotation:UpdateButton("Blood Tap") 
   elseif easyRotation:PlayerCanCastSpell("Horn of Winter",easyRotation.fuzzTime)
          and not (easyRotation:UnitHasBuff("player","Horn of Winter") 
          or easyRotation:UnitHasBuff("player","Battle Shout"))          
          then easyRotation:UpdateButton("Horn of Winter")
   elseif easyRotation:PlayerCanCastSpell("Bone Shield",easyRotation.fuzzTime) 
          and not easyRotation:UnitHasBuff("player","Bone Shield") 
          then easyRotation:UpdateButton("Bone Shield")
   elseif easyRotation:PlayerCanCastSpell("Dancing Rune Weapon",easyRotation.fuzzTime)  
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 60
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Dancing Rune Weapon")   
   elseif easyRotation:UnitHasBuff("player","Blood Presence") 
          and easyRotation:PlayerCanCastSpell("Rune Strike",easyRotation.fuzzTime) 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 40
          and easyRotation:PlayerTimeInCombat() > 20
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Rune Strike")   
   elseif easyRotation:PlayerCanCastSpell("Outbreak",easyRotation.fuzzTime) and
          not easyRotation:UnitHasDebuff("target","Blood Plague") 
          and not easyRotation:UnitHasDebuff("target","Frost Fever") 
          and (easyRotation:SpellNotCastRecently("Plague Strike")
          or easyRotation:SpellNotCastRecently("Icy Touch"))           
          and easyRotation:GetRange("target") < 29 
          then easyRotation:UpdateButton("Outbreak")    
   elseif easyRotation:PlayerCanCastSpell("Plague Strike",easyRotation.fuzzTime) 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0
          and (not easyRotation:UnitHasDebuff("target","Blood Plague") 
          or easyRotation:UnitHasDebuffRemaining("target","Blood Plague") < 3)                     
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Plague Strike")
   elseif easyRotation:PlayerCanCastSpell("Icy Touch",easyRotation.fuzzTime)
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0
          and (not easyRotation:UnitHasDebuff("target","Frost Fever") 
          or easyRotation:UnitHasDebuffRemaining("target", "Frost Fever")< 3)             
          and easyRotation:GetRange("target") < 19 
          then easyRotation:UpdateButton("Icy Touch") 
   elseif easyRotation:PlayerCanCastSpell("Pestilence")
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 1
          and easyRotation:UnitHasYourDebuffRemaining("target", "Blood Plague")>26       
          and easyRotation:UnitHasYourDebuffRemaining("target", "Frost Fever")>26
          and easyRotation:SpellNotCastRecently("Pestilence")
          and easyRotation:GetRange("target") < 6                  
          then easyRotation:UpdateButton("Pestilence")
   elseif easyRotation:PlayerCanCastSpell("Necrotic Strike",easyRotation.fuzzTime)
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0 
          and not easyRotation:UnitHasDebuff("target","Necrotic Strike") 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Necrotic Strike")  
  elseif easyRotation:UnitHasBuffRemaining("target","Blood Plague") > 6 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) > 0 
          and easyRotation:PlayerCanCastSpell("Festering Strike",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Festering Strike")
  elseif easyRotation:PlayerCanCastSpell("Death Strike",easyRotation.fuzzTime) 
          and easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) > 0
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) > 0 
          and easyRotation:UnitHealthPercent("player") < 50
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Death Strike")
   elseif easyRotation:UnitHasBuff("player","Crimson Scourge") 
          and easyRotation:PlayerCanCastSpell("Blood Boil",easyRotation.fuzzTime)
          and easyRotation:GetRange("target") < 6 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) >= 1
          then easyRotation:UpdateButton("Blood Boil")
   elseif easyRotation:PlayerCanCastSpell("Raise Dead",easyRotation.fuzzTime) 
          and easyRotation:PlayerTimeInCombat() > 5
          and easyRotation:SpellNotCastRecently("Raise Dead") 
          then easyRotation:UpdateButton("Raise Dead")
   elseif easyRotation:PlayerCanCastSpell("Heart Strike",easyRotation.fuzzTime) 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) > 0
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Heart Strike")
   --elseif easyRotation:PlayerCanCastSpell("Dark Simulacrum",easyRotation.fuzzTime)  
   --       and easyRotation:UnitManaPercent("target") > 1 
   --       and easyRotation:GetRange("target") < 39 
   --       then easyRotation:UpdateButton("Dark Simulacrum")
   elseif  easyRotation:PlayerCanCastSpell("Obliterate",easyRotation.fuzzTime) 
          and (easyRotation:UnitHasBuff("player","Killing Machine")  
          or (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) >= 1 
          and easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) >= 1)) 
          and easyRotation:GetRange("target") < 6 
          then easyRotation:UpdateButton("Obliterate")   
   elseif easyRotation:PlayerCanCastSpell("Death Coil",easyRotation.fuzzTime) 
          and easyRotation:GetRange("target") < 29 
          and easyRotation:GetPlayerResource(SPELL_POWER_RUNIC_POWER) > 45
          then easyRotation:UpdateButton("Death Coil")
  elseif easyRotation:PlayerCanCastSpell("Blood Boil",easyRotation.fuzzTime) 
          and easyRotation:GetPlayerResource(SPELL_POWER_BLOOD_RUNE) > 1
          and easyRotation:GetRange("target") < 6
          then easyRotation:UpdateButton("Blood Boil")
  --elseif easyRotation:PlayerCanCastSpell("Icy Touch")
    --     and (easyRotation:GetPlayerResource(SPELL_POWER_FROST_RUNE) >= 1)
      --   then easyRotation:UpdateButton("Icy Touch")
  --elseif easyRotation:PlayerCanCastSpell("Plague Strike",easyRotation.fuzzTime)
    --     and (easyRotation:GetPlayerResource(SPELL_POWER_UNHOLY_RUNE) >= 1)
      --   then easyRotation:UpdateButton("Plague Strike")
--else
   --   easyRotation:UpdateButton("Icy Touch (waiting)")
    end
end