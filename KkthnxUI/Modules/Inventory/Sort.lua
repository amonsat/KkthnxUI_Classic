local K, C = unpack(select(2, ...))
if C["Inventory"].Enable ~= true then
    return
end

if IsAddOnLoaded("AdiBags")
or IsAddOnLoaded("ArkInventory")
or IsAddOnLoaded("cargBags_Nivaya")
or IsAddOnLoaded("cargBags")
or IsAddOnLoaded("Bagnon")
or IsAddOnLoaded("Combuctor")
or IsAddOnLoaded("TBag")
or IsAddOnLoaded("BaudBag") then
    return
end

local _G = _G
local math_abs = _G.math.abs
local math_ceil = _G.math.ceil
local math_min = _G.math.min
local string_find = _G.string.find
local string_format = _G.string.format
local string_gsub = _G.string.gsub
local table_insert = _G.table.insert
local table_remove = _G.table.remove
local table_sort = _G.table.sort

local BankButtonIDToInvSlotID = _G.BankButtonIDToInvSlotID
local ClearCursor = _G.ClearCursor
local CreateFrame = _G.CreateFrame
local GetBagName = _G.GetBagName
local GetBagSlotFlag = _G.GetBagSlotFlag
local GetBankBagSlotFlag = _G.GetBankBagSlotFlag
local GetContainerItemInfo = _G.GetContainerItemInfo
local GetContainerItemLink = _G.GetContainerItemLink
local GetContainerNumSlots = _G.GetContainerNumSlots
local GetItemInfo = _G.GetItemInfo
local GetTime = _G.GetTime
local InCombatLockdown = _G.InCombatLockdown
local PickupContainerItem = _G.PickupContainerItem

local Start, LT, Move, TooltipInfo, Sort, Stack, Initialize, ContainerClass, Item
local CONTAINERS

function _G.SortBags()
	CONTAINERS = {0, 1, 2, 3, 4}
	for i = #CONTAINERS, 1, -1 do
		if GetBagSlotFlag(i - 1, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP) then
			table_remove(CONTAINERS, i)
		end
	end
	Start()
end

function _G.SortBankBags()
	CONTAINERS = {-1, 5, 6, 7, 8, 9, 10}
	for i = #CONTAINERS, 1, -1 do
		if GetBankBagSlotFlag(i - 1, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP) then
			table_remove(CONTAINERS, i)
		end
	end
	Start()
end

function _G.GetSortBagsRightToLeft(enabled)
	return SortBagsRightToLeft
end

function _G.SetSortBagsRightToLeft(enabled)
	SortBagsRightToLeft = enabled and 1 or nil
end

local function set(...)
	local t = {}
	local n = select("#", ...)
	for i = 1, n do
		t[select(i, ...)] = true
	end
	return t
end

local function union(...)
	local t = {}
	local n = select("#", ...)
	for i = 1, n do
		for k in pairs(select(i, ...)) do
			t[k] = true
		end
	end
	return t
end

local MOUNTS = set(
	-- rams
	5864, 5872, 5873, 18785, 18786, 18787, 18244, 19030, 13328, 13329,
	-- horses
	2411, 2414, 5655, 5656, 18778, 18776, 18777, 18241, 12353, 12354,
	-- sabers
	8629, 8631, 8632, 18766, 18767, 18902, 18242, 13086, 19902, 12302, 12303, 8628, 12326,
	-- mechanostriders
	8563, 8595, 13321, 13322, 18772, 18773, 18774, 18243, 13326, 13327,
	-- kodos
	15277, 15290, 18793, 18794, 18795, 18247, 15292, 15293,
	-- wolves
	1132, 5665, 5668, 18796, 18797, 18798, 18245, 12330, 12351,
	-- raptors
	8588, 8591, 8592, 18788, 18789, 18790, 18246, 19872, 8586, 13317,
	-- undead horses
	13331, 13332, 13333, 13334, 18791, 18248, 13335,
	-- qiraji battle tanks
	21218, 21321, 21323, 21324, 21176
)

local SPECIAL = set(5462, 17696, 17117, 13347, 13289, 11511)

local KEYS = set(9240, 17191, 13544, 12324, 16309, 12384, 20402)

local TOOLS = set(7005, 12709, 19727, 5956, 2901, 6219, 10498, 6218, 6339, 11130, 11145, 16207, 9149, 15846, 6256, 6365, 6367)

local ENCHANTING_MATERIALS = set(
	-- dust
	10940, 11083, 11137, 11176, 16204,
	-- essence
	10938, 10939, 10998, 11082, 11134, 11135, 11174, 11175, 16202, 16203,
	-- shard
	10978, 11084, 11138, 11139, 11177, 11178, 14343, 14344,
	-- crystal
	20725
)

local HERBS = set(765, 785, 2447, 2449, 2450, 2452, 2453, 3355, 3356, 3357, 3358, 3369, 3818, 3819, 3820, 3821, 4625, 8153, 8831, 8836, 8838, 8839, 8845, 8846, 13463, 13464, 13465, 13466, 13467, 13468)

local SEEDS = set(17034, 17035, 17036, 17037, 17038)

local CLASSES = {
	-- arrow
	{
		containers = {2101, 5439, 7278, 11362, 3573, 3605, 7371, 8217, 2662, 19319, 18714},
		items = set(2512, 2515, 3030, 3464, 9399, 11285, 12654, 18042, 19316),
	},
	-- bullet
	{
		containers = {2102, 5441, 7279, 11363, 3574, 3604, 7372, 8218, 2663, 19320},
		items = set(2516, 2519, 3033, 3465, 4960, 5568, 8067, 8068, 8069, 10512, 10513, 11284, 11630, 13377, 15997, 19317),
	},
	-- soul
	{
		containers = {22243, 22244, 21340, 21341, 21342},
		items = set(6265),
	},
	-- ench
	{
		containers = {22246, 22248, 22249},
		items = union(
			ENCHANTING_MATERIALS,
			-- rods
			set(6218, 6339, 11130, 11145, 16207)
		),
	},
	-- herb
	{
		containers = {22250, 22251, 22252},
		items = union(HERBS, SEEDS)
	},
}

local model, itemStacks, itemClasses, itemSortKeys

do
	local f = CreateFrame("Frame")
	f:Hide()

	local timeout

	function Start()
		if f:IsShown() then return end
		Initialize()
		timeout = GetTime() + 7
		f:Show()
	end

	local delay = 0
	f:SetScript("OnUpdate", function(_, arg1)
		if InCombatLockdown() or GetTime() > timeout then
			f:Hide()
			return
		end
		delay = delay - arg1
		if delay <= 0 then
			delay = .2
			local complete = Sort()
			if complete then
				f:Hide()
				return
			end
			Stack()
		end
	end)
end

function LT(a, b)
	local i = 1
	while true do
		if a[i] and b[i] and a[i] ~= b[i] then
			return a[i] < b[i]
		elseif not a[i] and b[i] then
			return true
		elseif not b[i] then
			return false
		end
		i = i + 1
	end
end

function Move(src, dst)
    local texture, _, srcLocked = GetContainerItemInfo(src.container, src.position)
    local _, _, dstLocked = GetContainerItemInfo(dst.container, dst.position)

	if texture and not srcLocked and not dstLocked then
		ClearCursor()
       	PickupContainerItem(src.container, src.position)
		PickupContainerItem(dst.container, dst.position)

		if src.item == dst.item then
			local count = math_min(src.count, itemStacks[dst.item] - dst.count)
			src.count = src.count - count
			dst.count = dst.count + count
			if src.count == 0 then
				src.item = nil
			end
		else
			src.item, dst.item = dst.item, src.item
			src.count, dst.count = dst.count, src.count
		end

		return true
    end
end

function TooltipInfo(container, position)
	-- local chargesPattern = "^" .. gsub(gsub(ITEM_SPELL_CHARGES_P1, "%%d", "(%%d+)"), "%%%d+%$d", "(%%d+)") .. "$" TODO retail
	local chargesPattern = "^" .. string_gsub(string_gsub(ITEM_SPELL_CHARGES, "%%d", "(%%d+)"), "%%%d+%$d", "(%%d+)") .. "$"

	K.ScanTooltip:SetOwner(UIParent, "ANCHOR_NONE")
	K.ScanTooltip:ClearLines()

	if container == BANK_CONTAINER then
		K.ScanTooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(position))
	else
		K.ScanTooltip:SetBagItem(container, position)
	end

	local charges, usable, soulbound, quest, conjured
	for i = 1, K.ScanTooltip:NumLines() do
		local text = _G[K.ScanTooltip:GetName().."TextLeft"..i]:GetText()

		local _, _, chargeString = string_find(text, chargesPattern)
		if chargeString then
			charges = tonumber(chargeString)
		elseif string_find(text, "^" .. ITEM_SPELL_TRIGGER_ONUSE) then
			usable = true
		elseif text == ITEM_SOULBOUND then
			soulbound = true
		elseif text == ITEM_BIND_QUEST then -- TODO retail can maybe use GetItemInfo bind info instead
			quest = true
		elseif text == ITEM_CONJURED then
			conjured = true
		end
	end

	return charges or 1, usable, soulbound, quest, conjured
end

function Sort()
	local complete = true

	for _, dst in ipairs(model) do
		if dst.targetItem and (dst.item ~= dst.targetItem or dst.count < dst.targetCount) then
			complete = false

			local sources, rank = {}, {}

			for _, src in ipairs(model) do
				if src.item == dst.targetItem
					and src ~= dst
					and not (dst.item and src.class and src.class ~= itemClasses[dst.item])
					and not (src.targetItem and src.item == src.targetItem and src.count <= src.targetCount)
				then
					rank[src] = math_abs(src.count - dst.targetCount + (dst.item == dst.targetItem and dst.count or 0))
					table_insert(sources, src)
				end
			end

			table_sort(sources, function(a, b) return rank[a] < rank[b] end)

			for _, src in ipairs(sources) do
				if Move(src, dst) then
					break
				end
			end
		end
	end

	return complete
end

function Stack()
	for _, src in ipairs(model) do
		if src.item and src.count < itemStacks[src.item] and src.item ~= src.targetItem then
			for _, dst in ipairs(model) do
				if dst ~= src and dst.item and dst.item == src.item and dst.count < itemStacks[dst.item] and dst.item ~= dst.targetItem then
					Move(src, dst)
				end
			end
		end
	end
end

do
	local counts

	local function insert(t, v)
		if SortBagsRightToLeft then
			table_insert(t, v)
		else
			table_insert(t, 1, v)
		end
	end

	local function assign(slot, item)
		if counts[item] > 0 then
			local count
			if SortBagsRightToLeft and mod(counts[item], itemStacks[item]) ~= 0 then
				count = mod(counts[item], itemStacks[item])
			else
				count = math_min(counts[item], itemStacks[item])
			end
			slot.targetItem = item
			slot.targetCount = count
			counts[item] = counts[item] - count
			return true
		end
	end

	function Initialize()
		model, counts, itemStacks, itemClasses, itemSortKeys = {}, {}, {}, {}, {}

		for _, container in ipairs(CONTAINERS) do
			local class = ContainerClass(container)
			for position = 1, GetContainerNumSlots(container) do
				local slot = {container=container, position=position, class=class}
				local item = Item(container, position)
				if item then
					local _, count = GetContainerItemInfo(container, position)
					slot.item = item
					slot.count = count
					counts[item] = (counts[item] or 0) + count
				end
				insert(model, slot)
			end
		end

		local free = {}
		for item, count in pairs(counts) do
			local stacks = math_ceil(count / itemStacks[item])
			free[item] = stacks
			if itemClasses[item] then
				free[itemClasses[item]] = (free[itemClasses[item]] or 0) + stacks
			end
		end
		for _, slot in ipairs(model) do
			if slot.class and free[slot.class] then
				free[slot.class] = free[slot.class] - 1
			end
		end

		local items = {}
		for item in pairs(counts) do
			table_insert(items, item)
		end
        table_sort(items, function(a, b)
            return LT(itemSortKeys[a], itemSortKeys[b])
        end)

		for _, slot in ipairs(model) do
			if slot.class then
				for _, item in ipairs(items) do
					if itemClasses[item] == slot.class and assign(slot, item) then
						break
					end
				end
			else
				for _, item in ipairs(items) do
					if (not itemClasses[item] or free[itemClasses[item]] > 0) and assign(slot, item) then
						if itemClasses[item] then
							free[itemClasses[item]] = free[itemClasses[item]] - 1
						end
						break
					end
				end
			end
		end
	end
end

function ContainerClass(container)
	if container ~= 0 and container ~= BANK_CONTAINER then
		local name = GetBagName(container)
		if name then
			for class, info in pairs(CLASSES) do
				for _, itemID in pairs(info.containers) do
					if name == GetItemInfo(itemID) then
						return class
					end
				end
			end
		end
	end
end

function Item(container, position)
	local link = GetContainerItemLink(container, position)
	if link then
		local _, _, itemID, enchantID, suffixID, uniqueID = string_find(link, "item:(%d+):(%d*):(%d*):(%d*)")
		itemID = tonumber(itemID)
		local _, _, quality, _, _, _, _, stack, slot, _, _, classId, subClassId = GetItemInfo("item:" .. itemID)
		local charges, usable, soulbound, quest, conjured = TooltipInfo(container, position)

		local sortKey = {}

		-- hearthstone
		if itemID == 6948 then
			table_insert(sortKey, 1)

		-- mounts
		elseif MOUNTS[itemID] then
			table_insert(sortKey, 2)

		-- special items
		elseif SPECIAL[itemID] then
			table_insert(sortKey, 3)

		-- key items
		elseif KEYS[itemID] then
			table_insert(sortKey, 4)

		-- tools
		elseif TOOLS[itemID] then
			table_insert(sortKey, 5)

		-- soul shards
		elseif itemID == 6265 then
			table_insert(sortKey, 14)

		-- conjured items
		elseif conjured then
			table_insert(sortKey, 15)

		-- soulbound items
		elseif soulbound then
			table_insert(sortKey, 6)

		-- reagents
		elseif classId == 9 then
			table_insert(sortKey, 7)

		-- quest items
		elseif quest then
			table_insert(sortKey, 9)

		-- consumables
		elseif usable and classId ~= 1 and classId ~= 2 and classId ~= 8 or classId == 4 then
			table_insert(sortKey, 8)

		-- enchanting materials
		elseif ENCHANTING_MATERIALS[itemID] then
			table_insert(sortKey, 11)

		-- herbs
		elseif HERBS[itemID] then
			table_insert(sortKey, 12)

		-- higher quality
		elseif quality > 1 then
			table_insert(sortKey, 10)

		-- common quality
		elseif quality == 1 then
			table_insert(sortKey, 13)

		-- junk
		elseif quality == 0 then
			table_insert(sortKey, 14)
		end

		table_insert(sortKey, classId)
		table_insert(sortKey, slot)
		table_insert(sortKey, subClassId)
		table_insert(sortKey, -quality)
		table_insert(sortKey, itemID)
		table_insert(sortKey, (SortBagsRightToLeft and 1 or -1) * charges)
		table_insert(sortKey, suffixID)
		table_insert(sortKey, enchantID)
		table_insert(sortKey, uniqueID)

		local key = string_format("%s:%s:%s:%s:%s:%s", itemID, enchantID, suffixID, uniqueID, charges, (soulbound and 1 or 0))

		itemStacks[key] = stack
		itemSortKeys[key] = sortKey

		for class, info in pairs(CLASSES) do
			if info.items[itemID] then
				itemClasses[key] = class
				break
			end
		end

		return key
	end
end