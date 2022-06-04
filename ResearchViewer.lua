local name, _ = ...

local ResearchViewer = {}
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
		{ type = 111, id = 461, name = "The Box of Many Things" },
		{ type = 111, id = 474, name = "Cypher Research Console" },
		{ type = 111, id = 476, name = "Pocopoc Customization" },
		["Kyrian (hidden research trees)"] = {
			{ type = 111, id = 308, name = "Transport Network" },
			{ type = 111, id = 312, name = "Anima Conductor" },
			{ type = 111, id = 316, name = "Command Table" },
			{ type = 111, id = 320, name = "Path of Ascension" },
			{ type = 111, id = 357, name = "Pelagos" },
			{ type = 111, id = 360, name = "Kleia" },
			{ type = 111, id = 365, name = "Mikanikos" },
			{ type = 111, id = 345, name = "Channel Anima" },
			{ type = 111, id = 393, name = "Bastion - Covenant Abilities" },
		},
		["Night Fea (hidden research trees)"] = {
			{ type = 111, id = 307, name = "Transport Network" },
			{ type = 111, id = 311, name = "Anima Conductor" },
			{ type = 111, id = 315, name = "Command Table" },
			{ type = 111, id = 319, name = "The Queen's Conservatory" },
			{ type = 111, id = 275, name = "Dreamweaver" },
			{ type = 111, id = 276, name = "Niya" },
			{ type = 111, id = 334, name = "Korayn" },
			{ type = 111, id = 346, name = "Channel Anima" },
			{ type = 111, id = 397, name = "Ardenweald - Covenant Abilities" },
		},
		["Necrolord  (hidden research trees)"] = {
			{ type = 111, id = 310, name = "Transport Network" },
			{ type = 111, id = 313, name = "Anima Conductor" },
			{ type = 111, id = 318, name = "Command Table" },
			{ type = 111, id = 321, name = "Abomination Factory" },
			{ type = 111, id = 325, name = "Plague Deviser Marileth" },
			{ type = 111, id = 330, name = "Emeni" },
			{ type = 111, id = 349, name = "Bonesmith Heirmir" },
			{ type = 111, id = 347, name = "Channel Anima" },
			{ type = 111, id = 395, name = "Maldraxxus - Covenant Abilities" },
		},
		["Venthyr (hidden research trees)"] = {
			{ type = 111, id = 309, name = "Transport Network" },
			{ type = 111, id = 314, name = "Anima Conductor" },
			{ type = 111, id = 317, name = "Command Table" },
			{ type = 111, id = 324, name = "The Ember Court" },
			{ type = 111, id = 368, name = "Nadjia the Mistblade" },
			{ type = 111, id = 392, name = "Theotar the Mad Duke" },
			{ type = 111, id = 304, name = "General Draven" },
			{ type = 111, id = 348, name = "Channel Anima" },
			{ type = 111, id = 396, name = "Revendreth - Covenant Abilities" },
		},
	},
	BFA = {
		{ type = 9, id = 152, name = "War Research - Horde" },
		{ type = 9, id = 153, name = "War Research - Aliance" },
		{ type = 9, id = 271, name = "MOTHER's Research" },
	},
	Legion = {
		{ type = 3, id = orderHalls[playerClass], name = "Your class Order Hall" },
		{ type = 3, id = 151, name = "Chromie event" },
		{ type = 3, id = orderHalls.DEATHKNIGHT, name = "Death Knight Order Hall" },
		{ type = 3, id = orderHalls.WARRIOR, name = "Warrior Order Hall" },
		{ type = 3, id = orderHalls.MONK, name = "Monk Order Hall" },
		{ type = 3, id = orderHalls.SHAMAN, name = "Shaman Order Hall" },
		{ type = 3, id = orderHalls.DRUID, name = "Druid Order Hall" },
		{ type = 3, id = orderHalls.WARLOCK, name = "Warlock Order Hall" },
		{ type = 3, id = orderHalls.HUNTER, name = "Hunter Order Hall" },
		{ type = 3, id = orderHalls.MAGE, name = "Mage Order Hall" },
		{ type = 3, id = orderHalls.PALADIN, name = "Paladin Order Hall" },
		{ type = 3, id = orderHalls.DEMONHUNTER, name = "Demon Hunter Order Hall" },
		{ type = 3, id = orderHalls.ROGUE, name = "Rogue Order Hall" },
		{ type = 3, id = orderHalls.PRIEST, name = "Priest Order Hall" },
	},
}
ResearchViewer.neverImplemented = {
	Shadowlands = {
		{ type = 111, id = 150, name = "Unnamed research" },
		{ type = 111, id = 272, name = "Nadjia the Mistblade" },
		{ type = 111, id = 327, name = "Bastion - Resevoir Upgrades" },
		{ type = 111, id = 328, name = "Ardenweald - Resevoir Upgrades" },
		{ type = 111, id = 329, name = "Maldraxxus- Resevoir Upgrades" },
		{ type = 111, id = 326, name = "Revendreth - Resevoir Upgrades" },
		{ type = 111, id = 465, name = "Device Upgrade Console" },
		{ type = 111, id = 466, name = "Progenitor Core" },
	},
	BFA = {
		{ type = 9, id = 468, name = "Progenitor Core JZB" },
		{ type = 9, id = 260, name = "Visions Research [NYI]" },
		{ type = 9, id = 263, name = "MOTHER's Research - Solo" },
		{ type = 9, id = 264, name = "MOTHER's Research - Group" },
		{ type = 9, id = 265, name = "MOTHER's Research - Gambler" },
		{ type = 9, id = 266, name = "MOTHER's Research - Speedrunner" },
		{ type = 9, id = 267, name = "MOTHER's Research - Explorer" },
		{ type = 9, id = 268, name = "MOTHER's Research - Milestones" },
	},
	Legion = {
		{ type = 3, id = 335, name = "Chris Test Tree Set" },
	},
}

function ResearchViewer:OnInitialize()
	ResearchViewerDB = ResearchViewerDB or {}
	self.db = ResearchViewerDB

	if not self.db.ldbOptions then
		self.db.ldbOptions = {
			hide = false,
		}
	end

	local original = C_Garrison.GetCurrentGarrTalentTreeID
	C_Garrison.GetCurrentGarrTalentTreeID = function()
		if ResearchViewer.selectedTreeInfo then return ResearchViewer.selectedTreeInfo.id end
		return original()
	end

	local ResearchViewerLDB = LibStub("LibDataBroker-1.1"):NewDataObject(
		name,
		{
			type = "data source",
			text = "Research Viewer",
			icon = "interface/icons/inv_misc_book_11.blp",
			OnClick = function()
				if IsShiftKeyDown() then
					ResearchViewer.db.ldbOptions.hide = true
					LibDBIcon:Hide(name)
					return
				end
				ResearchViewer:OpenResearchView()
			end,
			OnTooltipShow = function(tooltip)
				tooltip:AddLine("Research Viewer")
				tooltip:AddLine("|cffeda55fClick|r to view various research trees from the field.")
				tooltip:AddLine("|cffeda55fShift-Click|r to hide this button. ('/rv reset' to restore)")
			end,
		}
	)
	LibDBIcon:Register("ResearchViewer", ResearchViewerLDB, self.db.ldbOptions)

	EventRegistry:RegisterCallback('GarrisonTalentButtonMixin.TalentTooltipShown',
		function(self, tooltip, talentInfo, talentTreeId)
			local talentId = talentInfo.id

			if(talentId) then
				local text = "|cFFEE6161Order Advancement ID|r " .. talentId
				if(not self:AlreadyAdded(text, tooltip)) then
					tooltip:AddLine(text)
				end
				tooltip:Show()
			end
		end,
		self
	)

	SLASH_RESEARCH_VIEWER1 = "/rv"
	SLASH_RESEARCH_VIEWER2 = "/researchviewer"
	SlashCmdList["RESEARCH_VIEWER"] = function(message)
		if message == "reset" then
			wipe(ResearchViewer.db.ldbOptions)
			ResearchViewer.db.ldbOptions.hide = false
			ResearchViewer.db.lastSelected = nil

			LibDBIcon:Hide(name)
			LibDBIcon:Show(name)
			return
		end
		ResearchViewer:OpenResearchView()
	end
end

local frame = CreateFrame("FRAME")
local function OnEvent(_, event, ...)
	if event == "ADDON_LOADED" then
		local addonName = ...
		if addonName == name then
			ResearchViewer:OnInitialize()
		end
		if addonName == "Blizzard_OrderHallUI" then
			ResearchViewer:InitDropDown()
		end
	end
end
frame:HookScript('OnEvent', OnEvent)
frame:RegisterEvent('ADDON_LOADED')

function ResearchViewer:AlreadyAdded(textLine, tooltip)
	if textLine == nil then
		return false
	end

	for i = 1,15 do
		local tooltipFrame = _G[tooltip:GetName() .. "TextLeft" .. i]
		local textRight = _G[tooltip:GetName().."TextRight"..i]
		local text, right
		if tooltipFrame then text = tooltipFrame:GetText() end
		if text and string.find(text, textLine, 1, true) then return true end
		if textRight then right = textRight:GetText() end
		if right and string.find(right, textLine, 1, true) then return true end
	end
end

function ResearchViewer:MakeDropDownButton()
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

function ResearchViewer:OpenResearchView()
	OrderHall_LoadUI()
	ResearchViewer.selectedTreeInfo = ResearchViewer.db and ResearchViewer.db.lastSelected or ResearchViewer.talentTrees.Shadowlands[2]
	ResearchViewer:InitDropDown()
	ResearchViewer:OpenSelectedResearch()
end

local hooked = false
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

local isMenuItemChecked
do
	isMenuItemChecked = function(button)
		if button.arg1 and button.arg1.id then
			return button.arg1.id == C_Garrison.GetCurrentGarrTalentTreeID()
		end
		return button.arg2 and button.arg2[C_Garrison.GetCurrentGarrTalentTreeID()]
	end
end

function ResearchViewer:BuildFinalSubMenuItem(parentList, value, setValueFunc)
	table.insert(parentList, {
		text = string.format("%s (%d)", value.name, value.id),
		func = setValueFunc,
		arg1 = value,
		checked = isMenuItemChecked,
	})
end

function ResearchViewer:BuildSubMenuList(subMenuName, parentIdList, parentList, setValueFunc, list)
	local subMenuList = {}
	local subMenuIds = {}

	for key, value in pairs(list) do
		if (type(key) == "number") then
			if parentIdList then parentIdList[value.id] = true end
			subMenuIds[value.id] = true
			self:BuildFinalSubMenuItem(subMenuList, value, setValueFunc)
		else
			self:BuildSubMenuList(key, subMenuIds, subMenuList, setValueFunc, value)
		end
	end
	table.insert(parentList, {
		text = subMenuName,
		hasArrow = true,
		menuList = subMenuList,
		arg2 = subMenuIds,
		checked = isMenuItemChecked,
	})
end

function ResearchViewer:BuildMenu(setValueFunc)
	local menu = {}

	for expansion, list in pairs(self.talentTrees) do
		self:BuildSubMenuList(expansion, nil, menu, setValueFunc, list)
	end

	self:BuildSubMenuList("Never Implemented", nil, menu, setValueFunc, self.neverImplemented)

	return menu
end

function ResearchViewer:InitDropDown()
	if self.dropDownButton then return end
	self.dropDownButton, self.dropDown = self:MakeDropDownButton()

	local function setValue(_, newValue)
		CloseDropDownMenus()

		ToggleOrderHallTalentUI()

		ResearchViewer.selectedTreeInfo = newValue
		ResearchViewer:OpenSelectedResearch()
	end

	self.menuList = self:BuildMenu(setValue)
	EasyMenu(self.menuList, self.dropDown, self.dropDown, 0, 0)
end
