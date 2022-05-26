local name, ns = ...

ResearchViewer = {};
local ResearchViewer = ResearchViewer
local LibDBIcon = LibStub("LibDBIcon-1.0")

local playerClass, _ = UnitClassBase("player")
local orderHalls = {
	["WARRIOR"] = 122,
	["PALADIN"] = 119,
	["HUNTER"] = 113,
	["ROGUE"] = 131,
	["PRIEST"] = 134,
	["DEATHKNIGHT"] = 128,
	["SHAMAN"] = 31,
	["MAGE"] = 116,
	["WARLOCK"] = 110,
	["MONK"] = 4,
	["DRUID"] = 107,
	["DEMONHUNTER"] = 125,
}

ResearchViewer.talentTrees = {
	Shadowlands = {
		{
			name = "The Box of Many Things",
			id = 461,
			type = 111,
		},
		{
			name = "Cypher Research Console",
			id = 474,
			type = 111,
		},
		{
			name = "Pocopoc Customization",
			id = 476,
			type = 111,
		},
	},
	BFA = {
		{
			name = "War Research - Horde",
			id = 152,
			type = 9,
		},
		{
			name = "War Research - Aliance",
			id = 153,
			type = 9,
		},
		{
			name = "MOTHER's Research",
			id = 271,
			type = 9,
		},
	},
	Legion = {
		{
			name = "Your class Order Hall",
			id = orderHalls[playerClass],
			type = 3,
		},
		{
			name = "Chromie event",
			id = 151,
			type = 3,
		},
		{
			name = "Death Knight Order Hall",
			id = orderHalls.DEATHKNIGHT,
			type = 3,
		},
		{
			name = "Warrior Order Hall",
			id = orderHalls.WARRIOR,
			type = 3,
		},
		{
			name = "Monk Order Hall",
			id = orderHalls.MONK,
			type = 3,
		},
		{
			name = "Shaman Order Hall",
			id = orderHalls.SHAMAN,
			type = 3,
		},
		{
			name = "Druid Order Hall",
			id = orderHalls.DRUID,
			type = 3,
		},
		{
			name = "Warlock Order Hall",
			id = orderHalls.WARLOCK,
			type = 3,
		},
		{
			name = "Hunter Order Hall",
			id = orderHalls.HUNTER,
			type = 3,
		},
		{
			name = "Mage Order Hall",
			id = orderHalls.MAGE,
			type = 3,
		},
		{
			name = "Paladin Order Hall",
			id = orderHalls.PALADIN,
			type = 3,
		},
		{
			name = "Demon Hunter Order Hall",
			id = orderHalls.DEMONHUNTER,
			type = 3,
		},
		{
			name = "Rogue Order Hall",
			id = orderHalls.ROGUE,
			type = 3,
		},
		{
			name = "Priest Order Hall",
			id = orderHalls.PRIEST,
			type = 3,
		},
	},
}
ResearchViewer.neverImplemented = {
	Shadowlands = {
		{
			name = "Unnamed research (150)",
			id = 150,
			type = 111,
		},
		{
			name = "Nadjia the Mistblade (272)",
			id = 272,
			type = 111,
		},
		{
			name = "Dreamweaver (275)",
			id = 275,
			type = 111,
		},
		{
			name = "Niya (276)",
			id = 276,
			type = 111,
		},
		{
			name = "General Draven (304)",
			id = 304,
			type = 111,
		},
		{
			name = "Transport Network (307)",
			id = 307,
			type = 111,
		},
		{
			name = "Transport Network (308)",
			id = 308,
			type = 111,
		},
		{
			name = "Transport Network (309)",
			id = 309,
			type = 111,
		},
		{
			name = "Transport Network (310)",
			id = 310,
			type = 111,
		},
		{
			name = "Anima Conductor (311)",
			id = 311,
			type = 111,
		},
		{
			name = "Anima Conductor (312)",
			id = 312,
			type = 111,
		},
		{
			name = "Anima Conductor (313)",
			id = 313,
			type = 111,
		},
		{
			name = "Anima Conductor (314)",
			id = 314,
			type = 111,
		},
		{
			name = "Command Table (315)",
			id = 315,
			type = 111,
		},
		{
			name = "Command Table (316)",
			id = 316,
			type = 111,
		},
		{
			name = "Command Table (317)",
			id = 317,
			type = 111,
		},
		{
			name = "Command Table (318)",
			id = 318,
			type = 111,
		},
		{
			name = "The Queen's Conservatory (319)",
			id = 319,
			type = 111,
		},
		{
			name = "Path of Ascension (320)",
			id = 320,
			type = 111,
		},
		{
			name = "Abomination Factory (321)",
			id = 321,
			type = 111,
		},
		{
			name = "The Ember Court (324)",
			id = 324,
			type = 111,
		},
		{
			name = "Plague Deviser Marileth (325)",
			id = 325,
			type = 111,
		},
		{
			name = "Revendreth - Resevoir Upgrades (326)",
			id = 326,
			type = 111,
		},
		{
			name = "Bastion - Resevoir Upgrades (327)",
			id = 327,
			type = 111,
		},
		{
			name = "Ardenweald - Resevoir Upgrades (328)",
			id = 328,
			type = 111,
		},
		{
			name = "Maldraxxus- Resevoir Upgrades (329)",
			id = 329,
			type = 111,
		},
		{
			name = "Emeni (330)",
			id = 330,
			type = 111,
		},
		{
			name = "Korayn (334)",
			id = 334,
			type = 111,
		},
		{
			name = "Channel Anima (345)",
			id = 345,
			type = 111,
		},
		{
			name = "Channel Anima (346)",
			id = 346,
			type = 111,
		},
		{
			name = "Channel Anima (347)",
			id = 347,
			type = 111,
		},
		{
			name = "Channel Anima (348)",
			id = 348,
			type = 111,
		},
		{
			name = "Bonesmith Heirmir (349)",
			id = 349,
			type = 111,
		},
		{
			name = "Pelagos (357)",
			id = 357,
			type = 111,
		},
		{
			name = "Kleia (360)",
			id = 360,
			type = 111,
		},
		{
			name = "Mikanikos (365)",
			id = 365,
			type = 111,
		},
		{
			name = "Nadjia the Mistblade (368)",
			id = 368,
			type = 111,
		},
		{
			name = "Theotar the Mad Duke (392)",
			id = 392,
			type = 111,
		},
		{
			name = "Bastion - Covenant Abilities (393)",
			id = 393,
			type = 111,
		},
		{
			name = "Maldraxxus - Covenant Abilities (395)",
			id = 395,
			type = 111,
		},
		{
			name = "Revendreth - Covenant Abilities (396)",
			id = 396,
			type = 111,
		},
		{
			name = "Ardenweald - Covenant Abilities (397)",
			id = 397,
			type = 111,
		},
		{
			name = "Device Upgrade Console (465)",
			id = 465,
			type = 111,
		},
		{
			name = "Progenitor Core (466)",
			id = 466,
			type = 111,
		},
	},
	BFA = {
		{
			name = "Progenitor Core JZB",
			id = 468,
			type = 9,
		},
		{
			name = "Visions Research [NYI]",
			id = 260,
			type = 9,
		},
		{
			name = "MOTHER's Research - Solo",
			id = 263,
			type = 9,
		},
		{
			name = "MOTHER's Research - Group",
			id = 264,
			type = 9,
		},
		{
			name = "MOTHER's Research - Gambler",
			id = 265,
			type = 9,
		},
		{
			name = "MOTHER's Research - Speedrunner",
			id = 266,
			type = 9,
		},
		{
			name = "MOTHER's Research - Explorer",
			id = 267,
			type = 9,
		},
		{
			name = "MOTHER's Research - Milestones",
			id = 268,
			type = 9,
		},
	},
	Legion = {
		{
			name = "Chris Test Tree Set (335)",
			id = 335,
			type = 3,
		},
	},
}

ResearchViewer.selectedTreeInfo = nil
ResearchViewer.dropDown, ResearchViewer.initDropDown = nil, nil

local original = C_Garrison.GetCurrentGarrTalentTreeID
C_Garrison.GetCurrentGarrTalentTreeID = function()
	if ResearchViewer.selectedTreeInfo then return ResearchViewer.selectedTreeInfo.id end
	return original()
end

local hooked = false

local ResearchViewerLDB = LibStub("LibDataBroker-1.1"):NewDataObject(
	"ResearchViewer",
	{
		type = "data source",
		text = "Research Viewer",
		icon = "interface/icons/inv_misc_book_11.blp",
		OnClick = function()
			OrderHall_LoadUI()
			ResearchViewer.selectedTreeInfo = ResearchViewer.db and ResearchViewer.db.lastSelected or ResearchViewer.talentTrees.Shadowlands[2]
			ResearchViewer:initDropDown()
			ResearchViewer:OpenSelectedResearch()
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("Research Viewer")
			tooltip:AddLine("Click to view various research trees from the field.")
		end,
	}
)

LibDBIcon:Register("ResearchViewer", ResearchViewerLDB, { hide = false })

local frame = CreateFrame("FRAME")
local function OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local addonName = ...
		if addonName == name then
			ResearchViewerDB = ResearchViewerDB or {}
			ResearchViewer.db = ResearchViewerDB
		end
		if addonName == "Blizzard_OrderHallUI" then
			ResearchViewer:initDropDown()
		end
	end
end
frame:HookScript('OnEvent', OnEvent)
frame:RegisterEvent('ADDON_LOADED')


function ResearchViewer:makeDropDownButton()
	local mainButton = CreateFrame("BUTTON", nil, OrderHallTalentFrame, "UIPanelButtonTemplate")
	local dropDown = CreateFrame("FRAME", nil, OrderHallTalentFrame, "UIDropDownMenuTemplate")

	mainButton = Mixin(mainButton, DropDownToggleButtonMixin)
	mainButton:OnLoad_Intrinsic()
	mainButton:SetScript("OnMouseDown", function(self)
		ToggleDropDownMenu(1, nil, dropDown, self, 204, 15, ResearchViewer.menuList or nil)
	end)

	mainButton.Icon = mainButton:CreateTexture(nil, "ARTWORK")
	local icon = mainButton.Icon
	icon:SetSize(10, 12)
	icon:SetPoint("Right", -5, 0)
	icon:SetTexture("Interface\\ChatFrame\\ChatFrameExpandArrow")

	mainButton:SetText("Select another Research tree")
	mainButton:SetSize(200, 22)
	mainButton:SetPoint("TOPRIGHT", 10, 20)

	dropDown:Hide()

	if IsAddOnLoaded("ElvUI") then
		unpack(ElvUI):GetModule("Skins"):HandleDropDownBox(dropDown)
		unpack(ElvUI):GetModule("Skins"):HandleButton(mainButton)
	end

	return mainButton, dropDown
end

function ResearchViewer:OpenSelectedResearch()
	OrderHallTalentFrame:SetGarrisonType(self.selectedTreeInfo.type, self.selectedTreeInfo.id)
	self.db.lastSelected = self.selectedTreeInfo
	ToggleOrderHallTalentUI()
	self.dropDownButton:Show()
	if not hooked then
		hooked = true
		OrderHallTalentFrame:HookScript("OnHide", function()
			ResearchViewer.selectedTreeInfo = nil
		end)
	end
end

function ResearchViewer:buildMenu(setValueFunc)
	local menu = {}

	for expansion, list in pairs(self.talentTrees) do
		local menuList = {}
		local ids = {}

		for _, value in pairs(list) do
			ids[value.id] = true
			table.insert(menuList, {
				text = value.name,
				func = setValueFunc,
				arg1 = value,
				checked = function() return C_Garrison.GetCurrentGarrTalentTreeID() == value.id end,
			})
		end

		table.insert(menu, {
			text = expansion,
			hasArrow = true,
			menuList = menuList,
			checked = function() return ids[C_Garrison.GetCurrentGarrTalentTreeID()] end,
		})
	end

	local neverImplementedMenu = {}
	for expansion, list in pairs(self.neverImplemented) do
		local menuList = {}
		local ids = {}

		for _, value in pairs(list) do
			ids[value.id] = true
			value.neverImplemented = true
			table.insert(menuList, {
				text = value.name,
				func = setValueFunc,
				arg1 = value,
				checked = function() return C_Garrison.GetCurrentGarrTalentTreeID() == value.id end,
			})
		end

		table.insert(neverImplementedMenu, {
			text = expansion,
			hasArrow = true,
			menuList = menuList,
			checked = function() return ids[C_Garrison.GetCurrentGarrTalentTreeID()] end,
		})
	end
	table.insert(menu, {
		text = "Never Implemented",
		hasArrow = true,
		menuList = neverImplementedMenu,
		checked = function() return ResearchViewer.selectedTreeInfo and ResearchViewer.selectedTreeInfo.neverImplemented end,
	})
	return menu
end

function ResearchViewer:initDropDown()
	if self.dropDownButton then return end
	self.dropDownButton, self.dropDown = self:makeDropDownButton()

	local function setValue(_, newValue)
		CloseDropDownMenus()

		ToggleOrderHallTalentUI()

		ResearchViewer.selectedTreeInfo = newValue
		ResearchViewer:OpenSelectedResearch()
	end

	self.menuList = self:buildMenu(setValue)
	EasyMenu(self.menuList, self.dropDown, self.dropDown, 0, 0)
end
