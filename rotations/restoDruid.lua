easyRotation.modules.restoDruid = {}

function easyRotation.modules.restoDruid.init()
  local _,playerClass = UnitClass("player")
  return playerClass == "Druid" and GetSpecialization() == 4
end

function easyRotation.modules.restoDruid.initializeVariables()
end

function easyRotation.modules.restoDruid.Slash(cmd,val)
end

function easyRotation.modules.restoDruid.DecideSpells()
end

--Rejuvenation: Though we no longer blanket the raid the way we did in WLK, this spell is still central to our healing. 
--It does very high amount of healing, is quite efficient, and it enables Swiftmend. Because it is a moderately expensive instant, 
--it can burn your mana quickly if you start spamming it, you must break that habit from WLK. 
--But whenever you can cast a Rejuv that will not be mostly overheal, it is an excellent choice (how to know when this is, of course, 
--is not easy, and is one of the hallmarks of good healing). In addition, you will often maintain Rejuvenation on a tank who's taking 
--any significant amount of damage. In general, your "filler" healing is a mix of Nourish and Rejuv, based on your mana.

--Wild Growth: This remains an excellent spell all-around. It will automatically target the 5/6 lowest-HP people within range 
--(not necessarily including the target). Because the radius is now so high (30y), you can often just cast it on anybody and get a good result.
-- Make sure to cast it anytime an AoE effect hits some people in the raid. In heavy damage situations you'll use Wild Growth on cooldown.
--Even though it is expensive, it does more than enough healing to be worth it. Wild Growth is unusual in that in can be targeted on a hostile
-- unit and will still apply to the lowest-HP raid members in range of that unit.

--Lifebloom: You want to keep this rolling on a tank at virtually all times. It is a strong, cheap HoT, has a very fast tick rate to help
--tabilize the tank, and gives you frequent Revitalize and Malfurion's Gift procs. Try to get used to the timing of refreshing this on 
--the last tick without breaking your casting rhythm, both with Lifebloom itself and with Nourish/HT/RG. Always have a Lifebloom stack 
--on one person, even if there's no tank at the moment. The Malfurion's Gift, Revitalize, Replenishment, and T11 4-pieces bonuses all rely 
--on it to give you mana.

--Nourish: The Druid's cheap heal. Put simply, you cast this when you're not casting anything else. Gauge your mana consumption to know 
--when you need to try to work in more Nourish, and when you can afford to fill time with extra Rejuvenations instead. 
--The tank is always a good target for Nourishes in spare time because of the free Lifebloom refresh. Also, anytime you're using your Nourish
--to refresh Lifebloom (every 10 seconds), you will have 100% Harmony uptime.

--Healing Touch: Has the same cast time as Nourish, but is less efficient and much larger. A typical use is to top off a tank who needs 
--a direct heal. It has less use in raid healing, because it's somewhat squeezed out by other heals (Nourish for a small heal, Rejuv for an 
--efficient large heal, and Regrowth for a fast large heal). It is a good option on Clearcasts, however, whenever you don't need the 
--fast heal from a Regrowth.

--Combined with Nature's Swiftness, it provides an emergency instant heal which is somewhat stronger than Swiftmend. 
--You'll usually use it with Swiftmend when you need two consecutive instant heals on someone. 
--(You can replace the @mouseover with whatever target you like). Note that this will cast both spells at once if you're still, 
--but you'll need to press the macro twice if you're moving.

--Regrowth: The Druid's fast, inefficient direct heal. When people in the raid need immediate healing to avoid death, use this 
--(also use Swiftmend if it's available). Whenever a Clearcast procs, you can more liberally throw a Regrowth on anyone in the raid who 
--isn't topped off. Regrowth has another important use during Tree of Life, discussed below.

--Swiftmend: A strong instant heal on a short cooldown. One of our best spells. Always be vigilant for people at low HP on whom you might 
--use this. It's great for helping stabilize a tank anytime you see them sit low for more than a GCD, or making sure any raid member is 
--safe while your HoT's do their work. You can Swiftmend another Druid's HoT's (if you're using the Glyph this doesn't interfere with them 
--at all), so you want your raid frames to show who's Swiftmendable. Using Swiftmend on cooldown also helps to ensure high Harmory uptime.

--Efflorescence: I'm listing this separately from Swiftmend because you tend to think of it differently. If your Swiftmend is off cooldown 
--and you see a clump of people below full HP, quickly Swiftmend any one of them. Clumps of people are not easy to recognize, but raid frames 
--are starting to add tools to help with this.Becoming familiar with fights to know which AoE effects are ripe for Efflorescence can help alot.

--Clearcasting: Not a spell, but deserves an entry. The 4.2 patch has made Clearcasting easier to manage--it now lasts 15 seconds and 
--can only apply to the expensive spells Regrowth and Healing Touch, so it's difficult to waste. When Clearcasting procs, you simply have to 
--make sure to cast either a Healing Touch or a Regrowth in the next few seconds. A Healing Touch should generally be your first thought
--it is both longer cast and more healing than Regrowth, generally making more effective use of the Clearcast. The tank is a good target; 
--and HT on him for a free heal and LB/Harmony refresh is never a bad option. If, however, people in the raid are in need of a quick heal, 
--a Clearcast is a good chance to throw a Regrowth on them as well.
--In particular, if you want to use a Swiftmend or Efflorescence on a raid member soon, a great use of a Clearcast is to set up that 
--Swiftmend with a Regrowth. This way you avoid paying for an expensive Rejuvenation.

--Tree of Life Form: In addition to the 15% healing bonus, this has a few effects on our healing spells:

--Lifebloom: now castable on any number of targets. This is handy since Lifebloom does moderate healing and is very cheap. 
--In a fight where you don't need Tree for other purposes, shifting to cast primarily Lifebloom for 30 seconds lets you use ToL as a 
--very good mana cooldown.

--Regrowth: now instant cast. Not a throughput gain since Regrowth is a 1.5 cast anyway, but this allows use while moving and also gives
--you much quicker reactive healing. Because of all the Lifeblooms you use during Tree of Life, you get a lot of Clearcasting procs from 
--Malfurion's Gift, and can turn each one into a free instant Regrowth. The Regrowths even refresh the Lifeblooms.
--If many people in the raid need healing quickly, shifting to cast instant Regrowths can help hit people who need the most healing 
--immediately. Be careful though, as this can be expensive. Still use a good amount of Lifebloom when people aren't in danger of death.

--Wild Growth: now targets 2 extra people. Simply makes WG slightly better to use even than it ordinarily is.

--Efflorescence gets a double benefit from the 15% Tree boost (since the underlying Swiftmend was already boosted). 
--Again, simply makes a good spell even more effective during Tree.

--Also remember that in fights with short-term burn phases, you can shift to Tree and do a useful amount DPS with Wrath.

--As as final note, in my experience, I tend to use ToL form at fixed times each encounter (once I've seen the fight enough times to have 
--a plan), rather than in much of a reactive way.

--Tranquility: This spell is very strong now, and outputs massive amounts of healing during its channeling time. 
--Due to the new smart targeting mechanics, it's basically self-working. Can easily save people from dying if you mash it quickly 
--when the raid takes a lot of damage. You can now use it 2-3 times per fight, so depending on the encounter, you might use it reactively 
--when the raid is at low HP, or you might plan its use around certain boss abilities. The spell is now immune to pushback, so you no 
--longer have to protect it with Barkskin.

--Rebirth: Our most unique contribution to the raid. The most important issue is to avoid wasting it, especially now that the raid can 
--only use a limited number per attempt (3 in 25-man, 1 in 10-man). First, make sure to coordinate with other Druids/DK's/Warlocks in your 
--raid using macros or Vent so two of you don't cast on the same target. Second, people love to accept the resurrection as soon as it
--appears and die to something immediately. It can be good to warn them if it's a bad time to accept, and Glyph of Rebirth provides further 
--insurance. Even though other classes can combat rez now, the Druid rez should be still preferred in raids, because it raises the person 
--at 100% HP.

--Innervate: In general, you will now cast this on yourself on cooldown. Use the first one in any encounter after you dip slightly below 
--80% mana, and then on cooldown after that. Innervate is now extremely weak when cast on targets other than yourself, and this is rarely 
--going to be worth doing (in the event that you are going to cast it on someone else, remember to install a Glyph of Innervate).

--Thorns: This spell is quite strong now, and can be useful on tank especially in an AoE or threat-sensitive situation. 
--But generally the other Druids in the raid will use this first--ours does less damage, and it is also quite an expensive spell.

--Remove Corruption: Unlike the old Remove Curse, this is now castable even on people who don't have a cleansable debuff. 
--You might have to coordinate with your healing team a little so people don't waste GCD's on duplicative cleansing.

--Barkskin: Remember that this doesn't use the GCD, so you can cast it almost anytime without disrupting your healing. 
--It should be on an easily-accessible bind, and you should make it second nature to hit this instantly when you foresee a threatening 
--amount of damage coming.
