local K = unpack(select(2, ...))

local _G = _G

local GetTalentTabInfo = _G.GetTalentTabInfo
local GetBonusBarOffset = _G.GetBonusBarOffset
local UnitStat = _G.UnitStat
local UnitAttackPower = _G.UnitAttackPower
local GetSpellInfo = _G.GetSpellInfo

-- Specialization Functions
local specializationID = {
	["DRUID"] = {
		[1] = 102, -- Balance
		[2] = 103, -- Feral
		[3] = 105, -- Restoration
	},
	["HUNTER"] = {
		[1] = 253, -- Beast Mastery
		[2] = 254, -- Marksmanship
		[3] = 255, -- Survival
	},
	["MAGE"] = {
		[1] = 62, -- Arcane
		[2] = 63, -- Fire
		[3] = 64, -- Frost
	},
	["PALADIN"] = {
		[1] = 65, -- Holy
		[2] = 66, -- Protection
		[3] = 67, -- Retribution
	},
	["PRIEST"] = {
		[1] = 256, -- Discipline
		[2] = 257, -- Holy
		[3] = 258, -- Shadow
	},
	["ROGUE"] = {
		[1] = 259, -- Assassination
		[2] = 260, -- Combat
		[3] = 261, -- Subtlety
	},
	["SHAMAN"] = {
		[1] = 262, -- Elemental
		[2] = 263, -- Enhancement
		[3] = 264, -- Restoration
	},
	["WARLOCK"] = {
		[1] = 265, -- Affliction
		[2] = 266, -- Demonology
		[3] = 267, -- Destruction
	},
	["WARRIOR"] = {
		[1] = 71, -- Arms
		[2] = 72, -- Fury
		[3] = 73, -- Protection
	}
}

local specializationIcons = {
	["DRUID"] = {
		[1] = "Spell_nature_starfall",			-- Balance
		[2] = "Ability_druid_catform",			-- Feral
		[3] = "Spell_nature_healingtouch"		-- Restoration
	},
	["HUNTER"] = {
		[1] = "Ability_hunter_beasttaming",		-- Beast Mastery
		[2] = "Ability_marksmanship",			-- Marksmanship
		[3] = "Ability_hunter_swiftstrike"		-- Survival
	},
	["MAGE"] = {
		[1] = "Spell_holy_magicalsentry",		-- Arcane
		[2] = "Spell_fire_firebolt02",			-- Fire
		[3] = "Spell_frost_frostbolt02"			-- Frost
	},
	["PALADIN"] = {
		[1] = "Spell_holy_holybolt",			-- Holy
		[2] = "Spell_holy_devotionaura",		-- Protection
		[3] = "Spell_holy_auraoflight"			-- Retribution
	},
	["PRIEST"] = {
		[1] = "Spell_holy_wordfortitude",		-- Discipline
		[2] = "Spell_holy_holybolt",			-- Holy
		[3] = "Spell_shadow_shadowwordpain"		-- Shadow
	},
	["ROGUE"] = {
		[1] = "Ability_rogue_eviscerate",		-- Assassination
		[2] = "Ability_backstab",				-- Combat
		[3] = "Ability_stealth"					-- Subtlety
	},
	["SHAMAN"] = {
		[1] = "Spell_nature_lightning",			-- Elemental
		[2] = "Spell_nature_lightningshield",	-- Enhancement
		[3] = "Spell_nature_magicimmunity"		-- Restoration
	},
	["WARLOCK"] = {
		[1] = "Spell_shadow_deathcoil",			-- Affliction
		[2] = "Spell_shadow_metamorphosis",		-- Demonology
		[3] = "Spell_shadow_rainoffire"			-- Destruction
	},
	["WARRIOR"] = {
		[1] = "Ability_rogue_eviscerate",		-- Arms
		[2] = "Ability_warrior_innerrage",		-- Fury
		[3] = "Ability_warrior_defensivestance"	-- Protection
	}
}

local specializationInfoDB = { -- needs localized names
	[102] = {
		["name"] = "Balance",
		["description"] = "",
		["icon"] = "Spell_nature_starfall",
		["role"] = "DAMAGER",
		["class"] = "DRUID"
	},
	[103] = {
		["name"] = "Feral",
		["description"] = "",
		["icon"] = "Ability_druid_catform",
		["role"] = "TANK",
		["class"] = "DRUID"
	},
	[105] = {
		["name"] = "Restoration",
		["description"] = "",
		["icon"] = "Spell_nature_healingtouch",
		["role"] = "TANK",
		["class"] = "DRUID"
	},
	[253] = {
		["name"] = "Beast Mastery",
		["description"] = "",
		["icon"] = "Ability_hunter_beasttaming",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[254] = {
		["name"] = "Marksmanship",
		["description"] = "",
		["icon"] = "Ability_marksmanship",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[255] = {
		["name"] = "Survival",
		["description"] = "",
		["icon"] = "Ability_hunter_swiftstrike",
		["role"] = "DAMAGER",
		["class"] = "HUNTER"
	},
	[62] = {
		["name"] = "Arcane",
		["description"] = "",
		["icon"] = "Spell_holy_magicalsentry",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[63] = {
		["name"] = "Fire",
		["description"] = "",
		["icon"] = "Spell_fire_firebolt02",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[64] = {
		["name"] = "Frost",
		["description"] = "",
		["icon"] = "Spell_frost_frostbolt02",
		["role"] = "DAMAGER",
		["class"] = "MAGE"
	},
	[65] = {
		["name"] = "Holy",
		["description"] = "",
		["icon"] = "Spell_holy_holybolt",
		["role"] = "HEALER",
		["class"] = "PALADIN"
	},
	[66] = {
		["name"] = "Protection",
		["description"] = "",
		["icon"] = "Spell_holy_devotionaura",
		["role"] = "TANK",
		["class"] = "PALADIN"
	},
	[67] = {
		["name"] = "Retribution",
		["description"] = "",
		["icon"] = "Spell_holy_auraoflight",
		["role"] = "DAMAGER",
		["class"] = "PALADIN"
	},
	[256] = {
		["name"] = "Discipline",
		["description"] = "",
		["icon"] = "Spell_holy_wordfortitude",
		["role"] = "HEALER",
		["class"] = "PRIEST"
	},
	[257] = {
		["name"] = "Holy",
		["description"] = "",
		["icon"] = "Spell_holy_holybolt",
		["role"] = "HEALER",
		["class"] = "PRIEST"
	},
	[258] = {
		["name"] = "Shadow",
		["description"] = "",
		["icon"] = "Spell_shadow_shadowwordpain",
		["role"] = "DAMAGER",
		["class"] = "PRIEST"
	},
	[259] = {
		["name"] = "Assassination",
		["description"] = "",
		["icon"] = "Ability_rogue_eviscerate",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[260] = {
		["name"] = "Combat",
		["description"] = "",
		["icon"] = "Ability_backstab",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[261] = {
		["name"] = "Subtlety",
		["description"] = "",
		["icon"] = "Ability_stealth",
		["role"] = "DAMAGER",
		["class"] = "ROGUE"
	},
	[262] = {
		["name"] = "Elemental",
		["description"] = "",
		["icon"] = "Spell_nature_lightning",
		["role"] = "DAMAGER",
		["class"] = "SHAMAN"
	},
	[263] = {
		["name"] = "Enhancement",
		["description"] = "",
		["icon"] = "Spell_nature_lightningshield",
		["role"] = "DAMAGER",
		["class"] = "SHAMAN"
	},
	[264] = {
		["name"] = "Restoration",
		["description"] = "",
		["icon"] = "Spell_nature_magicimmunity",
		["role"] = "HEALER",
		["class"] = "SHAMAN"
	},
	[265] = {
		["name"] = "Affliction",
		["description"] = "",
		["icon"] = "Spell_shadow_deathcoil",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[266] = {
		["name"] = "Demonology",
		["description"] = "",
		["icon"] = "Spell_shadow_metamorphosis",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[267] = {
		["name"] = "Destruction",
		["description"] = "",
		["icon"] = "Spell_shadow_rainoffire",
		["role"] = "DAMAGER",
		["class"] = "WARLOCK"
	},
	[71] = {
		["name"] = "Arms",
		["description"] = "",
		["icon"] = "Ability_rogue_eviscerate",
		["role"] = "DAMAGER",
		["class"] = "WARRIOR"
	},
	[72] = {
		["name"] = "Fury",
		["description"] = "",
		["icon"] = "Ability_warrior_innerrage",
		["role"] = "DAMAGER",
		["class"] = "WARRIOR"
	},
	[73] = {
		["name"] = "Protection",
		["description"] = "",
		["icon"] = "Ability_warrior_defensivestance",
		["role"] = "TANK",
		["class"] = "WARRIOR"
	},
}

function K.GetSpecialization()
	local current = {}
	local primaryTree = 1
	for i = 1, 3 do
		_, _, current[i] = GetTalentTabInfo(i, "player", nil)
		if current[i] > current[primaryTree] then
			primaryTree = i
		end
	end

	return primaryTree
end

function K.GetSpecializationRole()
	local tree = K.GetSpecialization()
	local role
	if ((K.Class == "PALADIN" and tree == 2) or (K.Class == "WARRIOR" and tree == 3)) or (K.Class == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		role = "TANK"
	elseif ((K.Class == "PALADIN" and tree == 1) or (K.Class == "DRUID" and tree == 3) or (K.Class == "SHAMAN" and tree == 3) or (K.Class == "PRIEST" and tree ~= 3)) then
		role = "HEALER"
	else
		local int = select(2, UnitStat("player", 4))
		local agi = select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player")
		local ap = base + posBuff + negBuff

		if (((ap > int) or (agi > int)) and not (K.Class == "SHAMAN" and tree ~= 1 and tree ~= 3) and not AuraUtil.FindAuraByName(GetSpellInfo(24858), "player")) or K.Class == "ROGUE" or K.Class == "HUNTER" or (K.Class == "SHAMAN" and tree == 2) then
			role = "MELEE" -- ordinarily "DAMAGER"
		else
			role = "CASTER" -- ordinarily "DAMAGER"
		end
	end

	return role
end

function K.GetSpecializationInfo(specIndex)
	local id = specializationID[K.Class][specIndex]
	local name, description, _, background = GetTalentTabInfo(specIndex)
	local icon = "Interface\\ICONS\\"..specializationIcons[K.Class][specIndex]
	local role = K.GetSpecializationRole()
	if role == "CASTER" or role == "MELEE" then
		role = "DAMAGER"
	end

	local primaryStat = ""
	return id, name, description, icon, background, role, primaryStat
end

function K.GetSpecializationInfoByID(specID)
	if specializationInfoDB[specID] then
		local id = specID
		local name = specializationInfoDB[specID].name
		local description = specializationInfoDB[specID].description
		local icon = "Interface\\ICONS\\"..specializationInfoDB[specID].icon
		local role = specializationInfoDB[specID].role
		local class = specializationInfoDB[specID].class

		if name then
			return id, name, description, icon, role, class
		end
	end
end

UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned or function(unit) -- Needs work
	if unit == "player" then
		local role = K.GetSpecializationRole()
		if role == "MELEE" or role == "CASTER" then
			role = "DAMAGER"
		else
			role = role or ""
		end
		return role
	end
end