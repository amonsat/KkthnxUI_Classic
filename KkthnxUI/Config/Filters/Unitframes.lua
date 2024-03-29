local K = unpack(select(2, ...))

local _G = _G
-- local print = _G.print
local unpack = _G.unpack

local GetSpellInfo = _G.GetSpellInfo

local function SpellName(id)
	local name = GetSpellInfo(id)
	if not name then
		-- print("|cff3c9bedKkthnxUI:|r SpellID is not valid: " .. id .. ". Please check for an updated version, if none exists report to Kkthnx in Discord.")
		return "Impale"
	else
		return name
	end
end

local function Defaults(priorityOverride)
	return {["enable"] = true, ["priority"] = priorityOverride or 0, ["stackThreshold"] = 0}
end

K.RaidBuffsTrackingPosition = {
	TOPLEFT = {6, 1},
	TOPRIGHT = {-6, 1},
	BOTTOMLEFT = {6, 1},
	BOTTOMRIGHT = {-6, 1},
	LEFT = {6, 1},
	RIGHT = {-6, 1},
	TOP = {0, 0},
	BOTTOM = {0, 0}
}

K.DebuffHighlightColors = {
	[25771] = {
		enable = false,
		style = "FILL",
		color = {r = 0.85, g = 0, b = 0, a = 0.85}
	},
}

K.DebuffsTracking = {}
K.DebuffsTracking["RaidDebuffs"] = {
	["type"] = "Whitelist",
	["spells"] = {
		-- Raids
		-- Onyxia's Lair
		[18431] = Defaults(2), --Bellowing Roar
		-- Molten Core
		[19703] = Defaults(2), --Lucifron's Curse
		[19408] = Defaults(2), --Panic
		[19716] = Defaults(2), --Gehennas' Curse
		[20277] = Defaults(2), --Fist of Ragnaros
		[20475] = Defaults(6), --Living Bomb
		[19695] = Defaults(6), --Inferno
		[19659] = Defaults(2), --Ignite Mana
		[19714] = Defaults(2), --Deaden Magic
		[19713] = Defaults(2), --Shazzrah's Curse
		-- Blackwing's Lair
		[23023] = Defaults(2), --Conflagration
		[18173] = Defaults(2), --Burning Adrenaline
		[24573] = Defaults(2), --Mortal Strike
		[23340] = Defaults(2), --Shadow of Ebonroc
		[23170] = Defaults(2), --Brood Affliction: Bronze
		[22687] = Defaults(2), --Veil of Shadow
		-- Zul'Gurub
		[23860] = Defaults(2), --Holy Fire
		[22884] = Defaults(2), --Psychic Scream
		[23918] = Defaults(2), --Sonic Burst
		[24111] = Defaults(2), --Corrosive Poison
		[21060] = Defaults(2), --Blind
		[24328] = Defaults(2), --Corrupted Blood
		[16856] = Defaults(2), --Mortal Strike
		[24664] = Defaults(2), --Sleep
		[17172] = Defaults(2), --Hex
		[24306] = Defaults(2), --Delusions of Jin'do
		-- Ahn'Qiraj Ruins
		[25646] = Defaults(2), --Mortal Wound
		[25471] = Defaults(2), --Attack Order
		[96] = Defaults(2), --Dismember
		[25725] = Defaults(2), --Paralyze
		[25189] = Defaults(2), --Enveloping Winds
		-- Ahn'Qiraj Temple
		[785] = Defaults(2), --True Fulfillment
		[26580] = Defaults(2), --Fear
		[26050] = Defaults(2), --Acid Spit
		[26180] = Defaults(2), --Wyvern Sting
		[26053] = Defaults(2), --Noxious Poison
		[26613] = Defaults(2), --Unbalancing Strike
		[26029] = Defaults(2), --Dark Glare
		-- Naxxramas
		[28732] = Defaults(2), --Widow's Embrace
		[28622] = Defaults(2), --Web Wrap
		[28169] = Defaults(2), --Mutating Injection
		[29213] = Defaults(2), --Curse of the Plaguebringer
		[28835] = Defaults(2), --Mark of Zeliek
		[27808] = Defaults(2), --Frost Blast
		[28410] = Defaults(2), --Chains of Kel'Thuzad
		[27819] = Defaults(2), --Detonate Mana

		-- Dungeons
		[246] = Defaults(2), --Slow
		[6533] = Defaults(2), --Net
		[8399] = Defaults(2), --Sleep
		-- Blackrock Depths
		[13704] = Defaults(2), --Psychic Scream
		-- Deadmines
		[6304] = Defaults(2), --Rhahk'Zor Slam
		[12097] = Defaults(2), --Pierce Armor
		[7399] = Defaults(2), --Terrify
		[6713] = Defaults(2), --Disarm
		[5213] = Defaults(2), --Molten Metal
		[5208] = Defaults(2), --Poisoned Harpoon
		-- Maraudon
		[7964] = Defaults(2), --Smoke Bomb
		[21869] = Defaults(2), --Repulsive Gaze
		--
		[744] = Defaults(2), --Poison
		[18267] = Defaults(2), --Curse of Weakness
		[20800] = Defaults(2), --Immolate
		--
		[12255] = Defaults(2), --Curse of Tuten'kash
		[12252] = Defaults(2), --Web Spray
		[7645] = Defaults(2), --Dominate Mind
		[12946] = Defaults(2), --Putrid Stench
		--
		[14515] = Defaults(2), --Dominate Mind
		-- Scarlet Monastry
		[9034] = Defaults(2), --Immolate
		[8814] = Defaults(2), --Flame Spike
		[8988] = Defaults(2), --Silence
		[9256] = Defaults(2), --Deep Sleep
		[8282] = Defaults(2), --Curse of Blood
		-- Shadowfang Keep
		[7068] = Defaults(2), --Veil of Shadow
		[7125] = Defaults(2), --Toxic Saliva
		[7621] = Defaults(2), --Arugal's Curse
		--
		[16798] = Defaults(2), --Enchanting Lullaby
		[12734] = Defaults(2), --Ground Smash
		[17293] = Defaults(2), --Burning Winds
		[17405] = Defaults(2), --Domination
		[16867] = Defaults(2), --Banshee Curse
		[6016] = Defaults(2), --Pierce Armor
		[16869] = Defaults(2), --Ice Tomb
		[17307] = Defaults(2), --Knockout
		--
		[12889] = Defaults(2), --Curse of Tongues
		[12888] = Defaults(2), --Cause Insanity
		[12479] = Defaults(2), --Hex of Jammal'an
		[12493] = Defaults(2), --Curse of Weakness
		[12890] = Defaults(2), --Deep Slumber
		[24375] = Defaults(2), --War Stomp
		--
		[3356] = Defaults(2), --Flame Lash
		[6524] = Defaults(2), --Ground Tremor
		--
		[8040] = Defaults(2), --Druid's Slumber
		[8142] = Defaults(2), --Grasping Vines
		[7967] = Defaults(2), --Naralex's Nightmare
		[8150] = Defaults(2), --Thundercrack
		-- Zul'Farrak
		[11836] = Defaults(2), --Freeze Solid
		--
		[21056] = Defaults(2), --Mark of Kazzak
		[24814] = Defaults(2), --Seeping Fog
	},
}

-- CC DEBUFFS (TRACKING LIST)
K.DebuffsTracking["CCDebuffs"] = {
	-- BROKEN: Need to build a new classic CCDebuffs list
	-- EXAMPLE: See comment in spells table

	["type"] = "Whitelist",
	["spells"] = {
		-- [107079] = Defaults(4), -- Quaking Palm
	},
}

-- Raid Buffs (Squared Aura Tracking List)
K.RaidBuffsTracking = {
	PRIEST = {
		{10898, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 7)
		{10899, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 8)
		{10900, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 9)
		{10901, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 10)
		{10927, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 7)
		{10928, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 8)
		{10929, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 9)
		{10937, "TOPLEFT", {1, 1, 0.66}}, --Power Word: Fortitude (Rank 5)
		{10938, "TOPLEFT", {1, 1, 0.66}}, --Power Word: Fortitude (Rank 6)
		{10957, "BOTTOMLEFT", {0.7, 0.7, 0.7}}, --Shadow Protection (Rank 2)
		{10958, "BOTTOMLEFT", {0.7, 0.7, 0.7}}, --Shadow Protection (Rank 3)
		{1243, "TOPLEFT", {1, 1, 0.66}}, --Power Word: Fortitude (Rank 1)
		{1244, "TOPLEFT", {1, 1, 0.66}}, --Power Word: Fortitude (Rank 2)
		{1245, "TOPLEFT", {1, 1, 0.66}}, --Power Word: Fortitude (Rank 3)
		{139, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 1)
		{14752, "TOPRIGHT", {0.2, 0.7, 0.2}}, --Divine Spirit (Rank 1)
		{14818, "TOPRIGHT", {0.2, 0.7, 0.2}}, --Divine Spirit (Rank 2)
		{14819, "TOPRIGHT", {0.2, 0.7, 0.2}}, --Divine Spirit (Rank 3)
		{17, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 1)
		{21562, "TOPLEFT", {1, 1, 0.66}}, --Prayer of Fortitude (Rank 1)
		{21564, "TOPLEFT", {1, 1, 0.66}}, --Prayer of Fortitude (Rank 2)
		{25315, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 10)
		{27581, "TOPRIGHT", {0.2, 0.7, 0.2}}, --Prayer of Spirit (Rank 1)
		{27683, "BOTTOMLEFT", {0.7, 0.7, 0.7}}, --Prayer of Shadow Protection (Rank 1)
		{27841, "TOPRIGHT", {0.2, 0.7, 0.2}}, --Divine Spirit (Rank 4)
		{2791, "TOPLEFT", {1, 1, 0.66}}, --Power Word: Fortitude (Rank 4)
		{3747, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 4)
		{592, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 2)
		{600, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 3)
		{6065, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 5)
		{6066, "BOTTOM", {0.00, 0.00, 1.00}}, --Power Word: Shield (Rank 6)
		{6074, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 2)
		{6075, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 3)
		{6076, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 4)
		{6077, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 5)
		{6078, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Renew (Rank 6)
		{976, "BOTTOMLEFT", {0.7, 0.7, 0.7}}, --Shadow Protection (Rank 1)
	},
	DRUID = {
		{1058, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 2)
		{1075, "TOPRIGHT", {0.4, 0.2, 0.8}}, --Thorns (Rank 3)
		{1126, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 1)
		{1430, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 3)
		{16878, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 7)
		{2090, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 4)
		{2091, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 5)
		{21849, "TOPLEFT", {0.2, 0.8, 0.8}}, --Gift of the Wild (Rank 1)
		{21850, "TOPLEFT", {0.2, 0.8, 0.8}}, --Gift of the Wild (Rank 2)
		{25299, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 11)
		{3627, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 6)
		{467, "TOPRIGHT", {0.4, 0.2, 0.8}}, --Thorns (Rank 1)
		{5232, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 2)
		{5234, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 4)
		{6756, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 3)
		{774, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 1)
		{782, "TOPRIGHT", {0.4, 0.2, 0.8}}, --Thorns (Rank 2)
		{8907, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 5)
		{8910, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 7)
		{8914, "TOPRIGHT", {0.4, 0.2, 0.8}}, --Thorns (Rank 4)
		{8936, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 1)
		{8938, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 2)
		{8939, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 3)
		{8940, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 4)
		{8941, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 5)
		{9750, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 6)
		{9756, "TOPRIGHT", {0.4, 0.2, 0.8}}, --Thorns (Rank 5)
		{9839, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 8)
		{9840, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 9)
		{9841, "BOTTOMLEFT", {0.83, 1.00, 0.25}}, --Rejuvenation (Rank 10)
		{9856, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 7)
		{9857, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 8)
		{9858, "BOTTOMRIGHT", {0.33, 0.73, 0.75}}, --Regrowth (Rank 9)
		{9884, "TOPLEFT", {0.2, 0.8, 0.8}}, --Mark of the Wild (Rank 6)
		{9910, "TOPRIGHT", {0.4, 0.2, 0.8}}, --Thorns (Rank 6)
	},
	PALADIN = {
		{1044, "CENTER", {0.89, 0.45, 0}}, --Blessing of Freedom
		{19740, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 1)
		{19742, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Wisdom (Rank 1)
		{19834, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 2)
		{19835, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 3)
		{19836, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 4)
		{19837, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 5)
		{19838, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 6)
		{19850, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Wisdom (Rank 2)
		{19852, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Wisdom (Rank 3)
		{19853, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Wisdom (Rank 4)
		{19854, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Wisdom (Rank 5)
		{20729, "CENTER", {0.89, 0.1, 0.1}}, --Blessing Sacrifice (Rank 2)
		{25290, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Wisdom (Rank 6)
		{25291, "TOPLEFT", {0.2, 0.8, 0.2}}, --Blessing of Might (Rank 7)
		{25782, "TOPLEFT", {0.2, 0.8, 0.2}}, --Greater Blessing of Might (Rank 1)
		{25894, "TOPLEFT", {0.2, 0.8, 0.2}}, --Greater Blessing of Wisdom (Rank 1)
		{25916, "TOPLEFT", {0.2, 0.8, 0.2}}, --Greater Blessing of Might (Rank 2)
		{25918, "TOPLEFT", {0.2, 0.8, 0.2}}, --Greater Blessing of Wisdom (Rank 2)
		{6940, "CENTER", {0.89, 0.1, 0.1}}, --Blessing Sacrifice (Rank 1)
	},
	SHAMAN = {
		{10460, "BOTTOM", {0.67, 1.00, 0.50}}, --Healing Stream Totem (Rank 4)
		{10461, "BOTTOM", {0.67, 1.00, 0.50}}, --Healing Stream Totem (Rank 5)
		{10476, "TOPLEFT", {0.54, 0.53, 0.79}}, --Frost Resistance Totem (Rank 2)
		{10477, "TOPLEFT", {0.54, 0.53, 0.79}}, --Frost Resistance Totem (Rank 3)
		{10491, "LEFT", {0.67, 1.00, 0.80}}, --Mana Spring Totem (Rank 2)
		{10493, "LEFT", {0.67, 1.00, 0.80}}, --Mana Spring Totem (Rank 3)
		{10494, "LEFT", {0.67, 1.00, 0.80}}, --Mana Spring Totem (Rank 4)
		{10534, "TOPLEFT", {0.05, 1.00, 0.50}}, --Fire Resistance Totem (Rank 2)
		{10535, "TOPLEFT", {0.05, 1.00, 0.50}}, --Fire Resistance Totem (Rank 3)
		{10596, "TOPLEFT", {0.33, 1.00, 0.20}}, --Nature Resistance Totem (Rank 1)
		{10598, "TOPLEFT", {0.33, 1.00, 0.20}}, --Nature Resistance Totem (Rank 2)
		{10599, "TOPLEFT", {0.33, 1.00, 0.20}}, --Nature Resistance Totem (Rank 3)
		{16191, "BOTTOMLEFT", {0.67, 1.00, 0.80}}, --Mana Tide Totem (Rank 1)
		{16237, "RIGHT", {0.2, 0.2, 1}}, --Ancestral Fortitude
		{17355, "BOTTOMLEFT", {0.67, 1.00, 0.80}}, --Mana Tide Totem (Rank 2)
		{17360, "BOTTOMLEFT", {0.67, 1.00, 0.80}}, --Mana Tide Totem (Rank 3)
		{25909, "TOP", {0.00, 0.00, 0.50}}, --Tranquil Air
		{29203, "TOPRIGHT", {0.7, 0.3, 0.7}}, --Healing Way
		{5672, "BOTTOM", {0.67, 1.00, 0.50}}, --Healing Stream Totem (Rank 1)
		{5677, "LEFT", {0.67, 1.00, 0.80}}, --Mana Spring Totem (Rank 1)
		{6371, "BOTTOM", {0.67, 1.00, 0.50}}, --Healing Stream Totem (Rank 2)
		{6372, "BOTTOM", {0.67, 1.00, 0.50}}, --Healing Stream Totem (Rank 3)
		{8182, "TOPLEFT", {0.54, 0.53, 0.79}}, --Frost Resistance Totem (Rank 1)
		{8185, "TOPLEFT", {0.05, 1.00, 0.50}}, --Fire Resistance Totem (Rank 1)
	},
	WARRIOR = {
		{11549, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 4)
		{11550, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 5)
		{11551, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 6)
		{25289, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 7)
		{5242, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 2)
		{6192, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 3)
		{6673, "TOPLEFT", {0.2, 0.2, 1}}, --Battle Shout (Rank 1)
	},
	MAGE = {
		{1008, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Amplify Magic (Rank 1)
		{10156, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Intellect (Rank 4)
		{10157, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Intellect (Rank 5)
		{10169, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Amplify Magic (Rank 3)
		{10170, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Amplify Magic (Rank 4)
		{10173, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Dampen Magic (Rank 4)
		{10174, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Dampen Magic (Rank 5)
		{12438, "CENTER", {0.00, 0.00, 0.50}}, --Slow Fall
		{1459, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Intellect (Rank 1)
		{1460, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Intellect (Rank 2)
		{1461, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Intellect (Rank 3)
		{23028, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Brilliance (Rank 1)
		{27127, "TOPLEFT", {0.89, 0.09, 0.05}}, --Arcane Brilliance (Rank 2)
		{604, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Dampen Magic (Rank 1)
		{8450, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Dampen Magic (Rank 2)
		{8451, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Dampen Magic (Rank 3)
		{8455, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Amplify Magic (Rank 2)
	},
	HUNTER = {
		{19506, "TOPLEFT", {0.89, 0.09, 0.05}}, --Trueshot Aura (Rank 1)
		{20905, "TOPLEFT", {0.89, 0.09, 0.05}}, --Trueshot Aura (Rank 2)
		{20906, "TOPLEFT", {0.89, 0.09, 0.05}}, --Trueshot Aura (Rank 3)
	},
	WARLOCK = {
		{11743, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Detect Greater Invisibility
		{2970, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Detect Invisibility
		{5597, "TOPLEFT", {0.89, 0.09, 0.05}}, --Unending Breath
		{6512, "TOPRIGHT", {0.2, 0.8, 0.2}}, --Detect Lesser Invisibility
	},
	PET = {
		-- Warlock Imp
		{11766, "BOTTOMLEFT", {0.89, 0.09, 0.05}}, --Blood Pact (Rank 4)
		{11767, "BOTTOMLEFT", {0.89, 0.09, 0.05}}, --Blood Pact (Rank 5)
		{6307, "BOTTOMLEFT", {0.89, 0.09, 0.05}}, --Blood Pact (Rank 1)
		{7804, "BOTTOMLEFT", {0.89, 0.09, 0.05}}, --Blood Pact (Rank 2)
		{7805, "BOTTOMLEFT", {0.89, 0.09, 0.05}}, --Blood Pact (Rank 3)
		-- Warlock Felhunter
		{19480, "BOTTOMLEFT", {0.2, 0.8, 0.2}}, --Paranoia
	},
}

-- Filter this. Pointless to see.
K.UnimportantBuffs = {
	[SpellName(113942)] = true, -- Demonic: Gateway
	[SpellName(117870)] = true, -- Touch of The Titans
	[SpellName(123981)] = true, -- Perdition
	[SpellName(126434)] = true, -- Tushui Champion
	[SpellName(126436)] = true, -- Huojin Champion
	[SpellName(131493)] = true, -- B.F.F. Friends forever!
	[SpellName(143625)] = true, -- Brawling Champion
	[SpellName(15007)] = true, -- Ress Sickness
	[SpellName(170616)] = true, -- Pet Deserter
	[SpellName(182957)] = true, -- Treasures of Stormheim
	[SpellName(182958)] = true, -- Treasures of Azsuna
	[SpellName(185719)] = true, -- Treasures of Val"sharah
	[SpellName(186401)] = true, -- Sign of the Skirmisher
	[SpellName(186403)] = true, -- Sign of Battle
	[SpellName(186404)] = true, -- Sign of the Emissary
	[SpellName(186406)] = true, -- Sign of the Critter
	[SpellName(188741)] = true, -- Treasures of Highmountain
	[SpellName(199416)] = true, -- Treasures of Suramar
	[SpellName(225787)] = true, -- Sign of the Warrior
	[SpellName(225788)] = true, -- Sign of the Emissary
	[SpellName(227723)] = true, -- Mana Divining Stone
	[SpellName(231115)] = true, -- Treasures of Broken Shore
	[SpellName(233641)] = true, -- Legionfall Commander
	[SpellName(23445)] = true, -- Evil Twin
	[SpellName(237137)] = true, -- Knowledgeable
	[SpellName(237139)] = true, -- Power Overwhelming
	[SpellName(239645)] = true, -- Fel Treasures
	[SpellName(239647)] = true, -- Epic Hunter
	[SpellName(239648)] = true, -- Forces of the Order
	[SpellName(239966)] = true, -- War Effort
	[SpellName(239967)] = true, -- Seal Your Fate
	[SpellName(239968)] = true, -- Fate Smiles Upon You
	[SpellName(239969)] = true, -- Netherstorm
	[SpellName(240979)] = true, -- Reputable
	[SpellName(240980)] = true, -- Light As a Feather
	[SpellName(240985)] = true, -- Reinforced Reins
	[SpellName(240986)] = true, -- Worthy Champions
	[SpellName(240987)] = true, -- Well Prepared
	[SpellName(240989)] = true, -- Heavily Augmented
	[SpellName(24755)] = true, -- Tricked or Treated
	[SpellName(25163)] = true, -- Oozeling"s Disgusting Aura
	[SpellName(26013)] = true, -- Deserter
	[SpellName(36032)] = true, -- Arcane Charge
	[SpellName(36893)] = true, -- Transporter Malfunction
	[SpellName(36900)] = true, -- Soul Split: Evil!
	[SpellName(36901)] = true, -- Soul Split: Good
	[SpellName(39953)] = true, -- A"dal"s Song of Battle
	[SpellName(41425)] = true, -- Hypothermia
	[SpellName(44212)] = true, -- Jack-o"-Lanterned!
	[SpellName(55711)] = true, -- Weakened Heart
	[SpellName(57723)] = true, -- Exhaustion (heroism debuff)
	[SpellName(57724)] = true, -- Sated (lust debuff)
	[SpellName(57819)] = true, -- Argent Champion
	[SpellName(57820)] = true, -- Ebon Champion
	[SpellName(57821)] = true, -- Champion of the Kirin Tor
	[SpellName(58539)] = true, -- Watcher"s Corpse
	[SpellName(71041)] = true, -- Dungeon Deserter
	[SpellName(72968)] = true, -- Precious"s Ribbon
	[SpellName(80354)] = true, -- Temporal Displacement (timewarp debuff)
	[SpellName(8326)] = true, -- Ghost
	[SpellName(85612)] = true, -- Fiona"s Lucky Charm
	[SpellName(85613)] = true, -- Gidwin"s Weapon Oil
	[SpellName(85614)] = true, -- Tarenar"s Talisman
	[SpellName(85615)] = true, -- Pamela"s Doll
	[SpellName(85616)] = true, -- Vex"tul"s Armbands
	[SpellName(85617)] = true, -- Argus" Journal
	[SpellName(85618)] = true, -- Rimblat"s Stone
	[SpellName(85619)] = true, -- Beezil"s Cog
	[SpellName(8733)] = true, -- Blessing of Blackfathom
	[SpellName(89140)] = true, -- Demonic Rebirth: Cooldown
	[SpellName(93337)] = true, -- Champion of Ramkahen
	[SpellName(93339)] = true, -- Champion of the Earthen Ring
	[SpellName(93341)] = true, -- Champion of the Guardians of Hyjal
	[SpellName(93347)] = true, -- Champion of Therazane
	[SpellName(93368)] = true, -- Champion of the Wildhammer Clan
	[SpellName(93795)] = true, -- Stormwind Champion
	[SpellName(93805)] = true, -- Ironforge Champion
	[SpellName(93806)] = true, -- Darnassus Champion
	[SpellName(93811)] = true, -- Exodar Champion
	[SpellName(93816)] = true, -- Gilneas Champion
	[SpellName(93821)] = true, -- Gnomeregan Champion
	[SpellName(93825)] = true, -- Orgrimmar Champion
	[SpellName(93827)] = true, -- Darkspear Champion
	[SpellName(93828)] = true, -- Silvermoon Champion
	[SpellName(93830)] = true, -- Bilgewater Champion
	[SpellName(94158)] = true, -- Champion of the Dragonmaw Clan
	[SpellName(94462)] = true, -- Undercity Champion
	[SpellName(94463)] = true, -- Thunder Bluff Champion
	[SpellName(95809)] = true, -- Insanity debuff (hunter pet heroism: ancient hysteria)
	[SpellName(97340)] = true, -- Guild Champion
	[SpellName(97341)] = true, -- Guild Champion
	[SpellName(97821)] = true -- Void-Touched
}

K.ChannelingTicks = {
	-- [SpellName(740)] = 4,		-- 宁静
	-- [SpellName(755)] = 3,		-- 生命通道
	-- [SpellName(5143)] = 5, 		-- 奥术飞弹
	-- [SpellName(12051)] = 3, 		-- 唤醒
	-- [SpellName(15407)] = 4,		-- 精神鞭笞
	-- [SpellName(6948)] = 4,		-- 精神鞭笞

	-- Warlock
	[SpellName(198590)] = 6, -- Drain Soul
	[SpellName(755)] = 6, -- Health Funnel
	[SpellName(234153)] = 6, -- Drain Life
	-- Priest
	[SpellName(64843)] = 4, -- Divine Hymn
	[SpellName(15407)] = 4, -- Mind Flay
	[SpellName(48045)] = 5, -- Mind Sear
	-- Mage
	[SpellName(5143)] = 5, -- Arcane Missiles
	[SpellName(12051)] = 3, -- Evocation
	[SpellName(205021)] = 10, -- Ray of Frost
	-- Druid
	[SpellName(740)] = 4, -- Tranquility

}