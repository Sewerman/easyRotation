-- 
-- easyRotationUI
--
--  This file handles all of the ui creation and functionality.
-- 

-- a function that enables dragging the spell button
function easyRotation:EnableRotationHinterDragging()
  easyRotation.rotationHinter:SetScript("OnMouseDown", function(self) self:StartMoving() end)
  easyRotation.rotationHinter:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing(); easyRotation:SaveRotationHinterPos() end)
  easyRotation.rotationHinter:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
  easyRotation.rotationHinter:EnableMouse(true)
end

-- a function that disables/locks the spell button in place
function easyRotation:DisableRotationHinterDragging()
  easyRotation.rotationHinter:SetScript("OnMouseDown", nil)
  easyRotation.rotationHinter:SetScript("OnMouseUp", nil)
  easyRotation.rotationHinter:SetScript("OnDragStop", nil)
  easyRotation.rotationHinter:EnableMouse(false)
end

-- function that stores the spell butons position to user vars
function easyRotation:SaveRotationHinterPos()
  local anchorPoint, _, _, xOffset, yOffset = easyRotation.rotationHinter:GetPoint(1)
  easyRotationVars.rotationHinterPosX = xOffset
  easyRotationVars.rotationHinterPosY = yOffset
  easyRotationVars.rotationHinterPosAnchorPoint = anchorPoint
end

-- a function that generates the easyRotation spell button and border
function easyRotation:CreateRotationHinterUI()
  -- create rotation hinter wrapper
  easyRotation.rotationHinter = CreateFrame("Frame","easyRotationRotationHinter",UIParent)
  easyRotation.rotationHinter:SetFrameStrata("TOOLTIP")
  easyRotation.rotationHinter:SetWidth(58)
  easyRotation.rotationHinter:SetHeight(58)
  easyRotation.rotationHinter.texture = easyRotation.rotationHinter:CreateTexture()
  easyRotation.rotationHinter.texture:SetAllPoints(easyRotation.rotationHinter)
  easyRotation.rotationHinter.texture:SetColorTexture(0.5, 0.5, 0.5, 1)
  easyRotation.rotationHinter:SetMovable(true)
  easyRotation.rotationHinter:SetClampedToScreen(true)
  easyRotation:EnableRotationHinterDragging()
  easyRotation.rotationHinter:SetPoint(easyRotationVars.rotationHinterPosAnchorPoint, easyRotationVars.rotationHinterPosX, easyRotationVars.rotationHinterPosY)
  -- create rotation hinter icon
  easyRotation.rotationHinterIcon = CreateFrame("Button", "easyRotationRotationHinterIcon", easyRotation.rotationHinter, "SecureActionButtonTemplate")
  easyRotation.rotationHinterIcon:SetWidth(50)
  easyRotation.rotationHinterIcon:SetHeight(50)
  easyRotation.rotationHinterIcon:SetPoint("TOPLEFT", 4, -4)
  easyRotation.rotationHinterIcon.texture = easyRotation.rotationHinterIcon:CreateTexture(nil,"BACKGROUND")
  easyRotation.rotationHinterIcon.texture:SetTexture(nil)
  easyRotation.rotationHinterIcon.texture:SetAllPoints(easyRotation.rotationHinterIcon)
  easyRotation.rotationHinterIcon.fontstring = easyRotation.rotationHinterIcon:CreateFontString()
  easyRotation.rotationHinterIcon.fontstring:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE, MONOCHROME")
  easyRotation.rotationHinterIcon.fontstring:SetPoint("CENTER", easyRotation.rotationHinterIcon, "CENTER", 0, 0)
  easyRotation.rotationHinterIcon.fontstring:SetText("")
  easyRotation.rotationHinterIcon.fontstring:SetTextColor(1, 1, 1)
  easyRotation.rotationHinter:Show()
end

function easyRotation:ShowRotationHinter()
  if UnitAffectingCombat("player") == true then
    DEFAULT_CHAT_FRAME:AddMessage("Cannot show easyRotation, you are in combat", 1, 0, 0);
  else
    easyRotation.rotationHinter:Show()
  end
end

function easyRotation:HideRotationHinter()
  if UnitAffectingCombat("player") == true then
    DEFAULT_CHAT_FRAME:AddMessage("Cannot hide easyRotation, you are in combat", 1, 0, 0);
  else
    easyRotation.rotationHinter:Hide()
  end
end

-- function rescales the rotation hinter to the stored scale variable
function easyRotation:RescaleRotationHinterUI()
  easyRotation.rotationHinter:SetScale(easyRotationVars.rotationHinterScale)
end

-- function updates the rotation button to the specified spell
function easyRotation:UpdateRotationHinterIcon(spellname)
  local spellIcon = easyRotation:getSpellIcon(spellname)
  local spellColor = easyRotation:getSpellColor(spellname)
  easyRotation.rotationHinterIcon.texture:SetTexture(spellIcon)
  easyRotation.rotationHinter.texture:SetColorTexture(spellColor.r/255, spellColor.g/255, spellColor.b/255, 1)
  easyRotation.buttonUpdated = true
end

function easyRotation:RotationHinterUIInitilized()
  return easyRotation.rotationHinter ~= nil
end

function easyRotation:deactivate()
  easyRotation.rotationHinter.texture:SetColorTexture(127/255, 127/255, 127/255, 1)
end