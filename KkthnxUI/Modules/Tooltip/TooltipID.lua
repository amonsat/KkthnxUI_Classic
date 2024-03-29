local K, C, L = unpack(select(2, ...))
local Module = K:GetModule("Tooltip")

local _G = _G
local string_format = _G.string.format
local string_match = _G.string.match

local ACHIEVEMENTS = _G.ACHIEVEMENTS
local BAGSLOT = _G.BAGSLOT
local BANK = _G.BANK
local CURRENCY = _G.CURRENCY
--local C_TradeSkillUI_GetRecipeReagentItemLink = _G.C_TradeSkillUI.GetRecipeReagentItemLink
local GetItemCount = _G.GetItemCount
local GetItemInfo = _G.GetItemInfo
local GetUnitName = _G.GetUnitName
local ITEMS = _G.ITEMS
local QUESTS_LABEL = _G.QUESTS_LABEL
local SPELLS = _G.SPELLS
local TALENT = _G.TALENT
local UnitAura = _G.UnitAura

local types = {
	spell = SPELLS.."ID:",
	item = ITEMS.."ID:",
	quest = QUESTS_LABEL.."ID:",
	talent = TALENT.."ID:",
	achievement = ACHIEVEMENTS.."ID:",
	currency = CURRENCY.."ID:",
	azerite = L["Trait"].."ID:",
}

function Module:AddLineForID(id, linkType, noadd)
	for i = 1, self:NumLines() do
		local line = _G[self:GetName().."TextLeft"..i]
        if not line then
            break
        end

		local text = line:GetText()
        if text and text == linkType then
            return
        end
    end

    if not noadd then
        self:AddLine(" ")
    end

	if linkType == types.item then
		local bagCount = GetItemCount(id)
		local bankCount = GetItemCount(id, true) - GetItemCount(id)
		local itemStackCount = select(8, GetItemInfo(id))
		if bankCount > 0 then
			self:AddDoubleLine(BAGSLOT.."/"..BANK..":", K.InfoColor..bagCount.."/"..bankCount)
		elseif bagCount > 0 then
			self:AddDoubleLine(BAGSLOT..":", K.InfoColor..bagCount)
		end

		if itemStackCount and itemStackCount > 1 then
			self:AddDoubleLine(L["Stack Cap"]..":", K.InfoColor..itemStackCount)
		end
	end

	self:AddDoubleLine(linkType, string_format(K.InfoColor.."%s|r", id))
	self:Show()
end

function Module:SetHyperLinkID(link)
	local linkType, id = string_match(link, "^(%a+):(%d+)")
	if not linkType or not id then
		return
	end

	if linkType == "spell" or linkType == "enchant" or linkType == "trade" then
		Module.AddLineForID(self, id, types.spell)
	elseif linkType == "talent" then
		Module.AddLineForID(self, id, types.talent, true)
	elseif linkType == "quest" then
		Module.AddLineForID(self, id, types.quest)
	elseif linkType == "achievement" then
		Module.AddLineForID(self, id, types.achievement)
	elseif linkType == "item" then
		Module.AddLineForID(self, id, types.item)
	elseif linkType == "currency" then
		Module.AddLineForID(self, id, types.currency)
	end
end

function Module:SetItemID()
	local link = select(2, self:GetItem())
	if link then
		local id = string_match(link, "item:(%d+):")
		local keystone = string_match(link, "|Hkeystone:([0-9]+):")
		if keystone then
			id = tonumber(keystone)
		end

		if id then
			Module.AddLineForID(self, id, types.item)
		end
	end
end

function Module:UpdateSpellCaster(...)
	local unitCaster = select(7, UnitAura(...))
	if unitCaster then
		local name = GetUnitName(unitCaster, true)
		local hexColor = K.RGBToHex(K.UnitColor(unitCaster))
		self:AddDoubleLine(L["From"]..":", hexColor..name)
		self:Show()
	end
end

function Module:CreateTooltipID()
	-- Update all
	hooksecurefunc(GameTooltip, "SetHyperlink", Module.SetHyperLinkID)
	hooksecurefunc(ItemRefTooltip, "SetHyperlink", Module.SetHyperLinkID)

	-- Spells
	hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
		local id = select(10, UnitAura(...))
		if id then
			Module.AddLineForID(self, id, types.spell)
		end
	end)

	GameTooltip:HookScript("OnTooltipSetSpell", function(self)
		local id = select(2, self:GetSpell())
		if id then
			Module.AddLineForID(self, id, types.spell)
		end
	end)

	hooksecurefunc("SetItemRef", function(link)
		local id = tonumber(string_match(link, "spell:(%d+)"))
		if id then
			Module.AddLineForID(ItemRefTooltip, id, types.spell)
		end
	end)

	-- Items
	GameTooltip:HookScript("OnTooltipSetItem", Module.SetItemID)
	ItemRefTooltip:HookScript("OnTooltipSetItem", Module.SetItemID)
	ShoppingTooltip1:HookScript("OnTooltipSetItem", Module.SetItemID)
	ShoppingTooltip2:HookScript("OnTooltipSetItem", Module.SetItemID)
	ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", Module.SetItemID)
	ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", Module.SetItemID)
	-- hooksecurefunc(GameTooltip, "SetToyByItemID", function(self, id)
	-- 	if id then
	-- 		Module.AddLineForID(self, id, types.item)
	-- 	end
	-- end)

	-- hooksecurefunc(GameTooltip, "SetRecipeReagentItem", function(self, recipeID, reagentIndex)
	-- 	local link = C_TradeSkillUI_GetRecipeReagentItemLink(recipeID, reagentIndex)
	-- 	local id = link and string_match(link, "item:(%d+):")
	-- 	if id then
	-- 		Module.AddLineForID(self, id, types.item)
	-- 	end
	-- end)

	-- Currencies
	-- hooksecurefunc(GameTooltip, "SetCurrencyToken", function(self, index)
	-- 	local id = tonumber(string_match(GetCurrencyListLink(index), "currency:(%d+)"))
	-- 	if id then
	-- 		Module.AddLineForID(self, id, types.currency)
	-- 	end
	-- end)

	-- hooksecurefunc(GameTooltip, "SetCurrencyByID", function(self, id)
	-- 	if id then
	-- 		Module.AddLineForID(self, id, types.currency)
	-- 	end
	-- end)

	-- hooksecurefunc(GameTooltip, "SetCurrencyTokenByID", function(self, id)
	-- 	if id then
	-- 		Module.AddLineForID(self, id, types.currency)
	-- 	end
	-- end)

	-- Spell caster
	hooksecurefunc(GameTooltip, "SetUnitAura", Module.UpdateSpellCaster)

	-- Azerite traits
	-- hooksecurefunc(GameTooltip, "SetAzeritePower", function(self, _, _, id)
	-- 	if id then
	-- 		Module.AddLineForID(self, id, types.azerite, true)
	-- 	end
	-- end)
end