-- 
-- easyRotation
--
--  this file loads up the basic libraries and regesters for all the core events
--  and calls the core init() when the addon is loaded.
--

easyRotation = {}
easyRotation.events = {}

-- Init easyRotation libraries
easyRotation.rangeCheck = LibStub("LibRangeCheck-2.0")

-- Create event delegator
easyRotation.eventFrame = CreateFrame("Frame")
easyRotation.eventFrame:SetScript("OnEvent", function(this, event, ...)
  if event == "ADDON_LOADED" or 
      event == "COMBAT_LOG_EVENT_UNFILTERED" or 
      event == "ACTIVE_TALENT_GROUP_CHANGED" or 
      event == "CHAT_MSG_ADDON" or
      event == "PLAYER_ENTERING_WORLD" then
    easyRotation.events[event](...)
  else
    easyRotation:OnEvent(event, ...)
  end
end)

-- Register the ADDON_LOADED event
easyRotation.eventFrame:RegisterEvent("ADDON_LOADED")

-- Handle the ADDON_LOADED event
function easyRotation.events.ADDON_LOADED(name)
  if name == "easyRotation" then
    easyRotation:Init()
  end
end

function easyRotation.events.PLAYER_ENTERING_WORLD(...)
  easyRotation:LoadRotations()
  easyRotation:LoadSpellInfo()
end

function easyRotation.events.ACTIVE_TALENT_GROUP_CHANGED()
  easyRotation:LoadRotations()
  easyRotation:LoadSpellInfo()
end

function easyRotation.events.CHAT_MSG_ADDON(...)
  local prefix, message, _, sender = ...
  if message ~= nil and prefix == "easyrotation" then
    easyRotation:MsgHandler(message, sender)
  end
end

function easyRotation.events.COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, uknownBoolean, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
  easyRotation:CombatLogEvent(timestamp, event, uknownBoolean, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
end

-- Slash Command
function easyRotation.Slash(msg, self)
  easyRotation:CoreSlash(msg, self)
end
