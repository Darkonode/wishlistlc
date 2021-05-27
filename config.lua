-------------------------------
-- Namespaces
-------------------------------
local _, namespace = ...
namespace.Config = {}
namespace.Raids = {"Karazhan", "Gruul", "Magth",}
namespace.currentRaid = 0
namespace.wishlists = {["Karazhan"] = {},["Gruul"] = {}, ["Magth"] = {},}
local Config = namespace.Config
local ConfigWin

--------------------------------------
-- Defaults (usually a database!)
--------------------------------------
local defaults = {
	theme = {
		r = 1, 
		g = 0.4,
		b = 0,
		hex = "Ff6b00"
	},
	version = "v0.3",
}

-------------------------------
-- Event handlers and misc.
-------------------------------
function Config:Toggle()
	local menu = ConfigWin or Config:CreateMenu()
	menu:SetShown(not menu:IsShown())
end

function Config:GetThemeColor()
	local c = defaults.theme
	return c.r, c.g, c.b, c.hex
end

function Config:GetAddonVersion()
	return defaults.version
end

--Clicking open a raid tab
local function Tab_OnClick(tab)
	local SelectedTabID = PanelTemplates_GetSelectedTab(tab:GetParent())
	if (SelectedTabID) then
		if (SelectedTabID ~= tab:GetID()) then
			_G["WLC_ConfigWinTab" .. SelectedTabID].content:Hide()
		end
	end
	
	PanelTemplates_SetTab(tab:GetParent(), tab:GetID())
	namespace.currentRaid = tab:GetID()
	tab.content:Show()
end

--Mouseover an item in the item or wishlist frame
local function OnEnter(self, motion)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self:GetText())
	GameTooltip:AddLine(tostring(self.tooltipText), 1, 1, 1)
	GameTooltip:Show()
end

--Stop mousing over an item
local function OnLeave(self, motion)
	GameTooltip:Hide()
end

--Update item frame after change
local function UpdateItemFrame()
	index = 1
	local first_elem = true
	local ButtonIndex = {}
	for key, element in next, tab.ItemFrameElements do
		element:Hide()
	end
	for key, item in next, namespace.Kara.searchResult do
		local buttonName = key .. "Button" 
		if first_elem then
			_G[buttonName]:SetPoint("TOPLEFT", tab.ItemScrollFrameChild, "TOPLEFT", 4, 0)
			first_elem = false
		else
			_G[buttonName]:SetPoint("TOPLEFT", ButtonIndex[index - 1], "TOPLEFT", 0, -11)
		end
		index = index + 1
		_G[buttonName]:Show(not self.buttonName:IsShown())
		table.insert(ButtonIndex, _G[buttonName])
	end
end

--Update wishlist frame after change
local function UpdateWishlistFrame(scrollChild, raid)
	local index = 1
	local first_elem = true
	for key, itemButton in next, namespace.wishlists[raid] do
		if first_elem then
			itemButton:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 4, 0)
			first_elem = false
		else
			button:SetPoint("TOPLEFT", namespace.wishlists[raid][index - 1], "TOPLEFT", 0, -11)
		end
		index = index + 1
	end
	scrollChild:SetSize(195, index * 11)
	
end
	
--Delete item from wishlist
local function OnClickWishlistButton (self)
	namespace.Kara:DeleteFromWishlist(self)
	UpdateWishlistFrame(self:GetParent())
end

-------------------------------
-- Config function
-------------------------------

--------------------------------------
--Clicking an item in the item frame--
--------------------------------------
-- Add the button that was pressed to the wishlist
-- and run update on the wishlist frame 
local function  OnClickItemFrameButton(self)
	local buttonName = self:GetName() .. "Wish"
	local raid = namespace.Raids[namespace.currentRaid]
	local parentName = raid .. "WishScrollFrame"
	if not _G[buttonName] then
		button = CreateFrame("Button", buttonName, _G[parentName],
		"OptionsListButtonTemplate")
		button:SetSize(178, 11)
		button:SetHighlightTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2")
		button:SetText(self:GetText())
		button.tooltipText = self.tooltipText
		button:SetScript("OnEnter", OnEnter)
		button:SetScript("OnLeave", OnLeave)
		button:SetScript("OnClick", OnClickItemFrameButton)
		table.insert(namespace.wishlists[raid], button)
	end
	UpdateWishlistFrame(_G[raid.."WishScrollChild"], raid)
end

local function SetTabs (frame, numTabs, ...)
	frame.numTabs = numTabs
	local tabs = {}
	local frameName = frame:GetName()
	
	for i = 1, numTabs do
		local tab = CreateFrame("Button", frameName.."Tab"..i, frame, "CharacterFrameTabButtonTemplate")
		tab:SetID(i)
		tab:SetText(select(i, ...))
		tab:SetScript("OnClick", Tab_OnClick)
		
		tab.content = CreateFrame("Frame", nil, ConfigWin)
		tab.content:SetSize(600, 300)
		tab.content:SetPoint("CENTER", tab, "CENTER")
		tab.content:Hide()
		
		table.insert(tabs, tab.content)
		
		if (i == 1) then
			tab:SetPoint("TOPLEFT", ConfigWin, "BOTTOMLEFT", 5, 1)
		else
			tab:SetPoint("TOPLEFT", _G[frameName.."Tab"..(i-1)], "TOPRIGHT", -14, 0)
		end
		
	end
	
	Tab_OnClick(_G[frameName.."Tab1"])
	
	return unpack(tabs)
end

-- Create everything that exists within the tabs and do an "all"
-- search of items
local function PopulateTabs(tab, raid)
	-----------------------------
	-- Wishlist frame
	-----------------------------
	tab.WishlistFrame = CreateFrame("Frame", raid .. "WishFrame", tab, "InsetFrameTemplate")

	tab.WishlistFrame:SetSize(200, 230)
	tab.WishlistFrame:SetPoint("TOPRIGHT", ConfigWin, "TOPRIGHT", -10, -45)

	tab.WishlistFrame.title = tab.WishlistFrame:CreateFontString(nil, "OVERLAY")
	tab.WishlistFrame.title:SetFontObject("GameFontNormal")
	tab.WishlistFrame.title:SetPoint("BOTTOMLEFT", tab.WishlistFrame, "TOPLEFT", 5, 3)
	tab.WishlistFrame.title:SetText(raid .. " wishlist:")
	
	-----------------------------
	-- Wishlist scroll frame
	-----------------------------
	tab.WishScrollFrame = CreateFrame("ScrollFrame", raid .. "WishScrollFrame", tab.WishlistFrame, "UIPanelScrollFrameTemplate")
	tab.WishScrollFrame:SetPoint("TOPLEFT", raid .. "WishFrameBg", "TOPLEFT", 0, -4)
	tab.WishScrollFrame:SetSize(200, 223)
	
	tab.WishScrollFrameChild = CreateFrame("Frame", raid .. "WishScrollChild", tab.WishScrollFrame)
	tab.WishScrollFrame.ScrollBar:SetPoint("TOPRIGHT", tab.WishScrollFrame, "TOPRIGHT", -24, 0)
	tab.WishScrollFrame:SetScrollChild(tab.WishScrollFrameChild)
	tab.WishScrollFrame:SetClipsChildren(true)

	-----------------------------
	-- Wishlist frame buttons
	-----------------------------
	-- Clear button
	tab.clearButton = CreateFrame("Button", nil, tab, "GameMenuButtonTemplate")
	tab.clearButton:SetPoint("CENTER", tab.WishlistFrame, "BOTTOMRIGHT", -30, -11)
	tab.clearButton:SetSize(60, 18)
	tab.clearButton:SetText("Clear")
	tab.clearButton:SetNormalFontObject("GameFontNormal")
	tab.clearButton:SetHighlightFontObject("GameFontHighlight")

	-- Delete button
	tab.delButton = CreateFrame("Button", nil, tab.clearButton, "GameMenuButtonTemplate")
	tab.delButton:SetPoint("TOPRIGHT", tab.clearButton, "TOPLEFT", -3, 0)
	tab.delButton:SetSize(60, 18)
	tab.delButton:SetText("Delete")
	tab.delButton:SetNormalFontObject("GameFontNormal")
	tab.delButton:SetHighlightFontObject("GameFontHighlight")
	
	-----------------------------
	-- Item frame
	-----------------------------
	tab.ItemFrame = CreateFrame("Frame", raid .. "ItemFrame", tab, "InsetFrameTemplate")
	
	tab.ItemFrame:SetSize(200, 212)
	tab.ItemFrame:SetPoint("TOPRIGHT", tab.WishlistFrame, "TOPLEFT", -10, 0)

	tab.ItemFrame.title = tab.ItemFrame:CreateFontString(nil, "OVERLAY")
	tab.ItemFrame.title:SetFontObject("GameFontNormal")
	tab.ItemFrame.title:SetPoint("BOTTOMLEFT", tab.ItemFrame, "TOPLEFT", 5, 3)
	tab.ItemFrame.title:SetText(raid .. " drops:")
	
	-----------------------------
	-- Item frame scroll frame
	-----------------------------
	tab.ItemScrollFrame = CreateFrame("ScrollFrame", nil, tab.ItemFrame, "UIPanelScrollFrameTemplate")
	tab.ItemScrollFrame:SetPoint("TOPLEFT", raid .. "ItemFrameBg", "TOPLEFT", 0, -4)
	tab.ItemScrollFrame:SetSize(200, 205)
	
	tab.ItemScrollFrameChild = CreateFrame("Frame", nil, tab.ItemScrollFrame)
	tab.ItemScrollFrame.ScrollBar:SetPoint("TOPRIGHT", tab.ItemScrollFrame, "TOPRIGHT", -24, 0)
	tab.ItemScrollFrame:SetScrollChild(tab.ItemScrollFrameChild)
	tab.ItemScrollFrame:SetClipsChildren(true)
	
	-----------------------------
	-- Item frame search bar
	-----------------------------
	tab.searchBar = CreateFrame("EditBox", nil, tab, "SearchBoxTemplate")
	tab.searchBar:SetPoint("BOTTOM", tab.ItemFrame, "BOTTOM", 2, -16)
	tab.searchBar:SetSize(195, 15)
	
	-----------------------------
	-- Item frame options list buttons
	-- Initially all buttons are shown
	-----------------------------
	namespace.Kara:FilterSearch()
	tab.ItemFrameElements = {}
	local ButtonIndex = {}
	local index = 1
	local first_elem = true
	for key, item in next, namespace.searchResult do
		local buttonName = key .. "Button"
		button = CreateFrame("Button", buttonName, tab.ItemScrollFrame, "OptionsListButtonTemplate")
		button:SetSize(178, 11)
		button:SetHighlightTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2")
		button:SetText(item.name)
		if item.slot then
			button.tooltipText = item.itemType .. ", " .. item.slot
		else
			button.tooltipText = item.itemType
		end
		if first_elem then
			button:SetPoint("TOPLEFT", tab.ItemScrollFrameChild, "TOPLEFT", 4, 0)
			first_elem = false
		else
			button:SetPoint("TOPLEFT", ButtonIndex[index - 1], "TOPLEFT", 0, -11)
		end
		button:SetScript("OnEnter", OnEnter)
		button:SetScript("OnLeave", OnLeave)
		button:SetScript("OnClick", OnClickItemFrameButton)
		
		tab.ItemFrameElements[buttonName] = button
		table.insert(ButtonIndex, button)
		index = index + 1
	end
	tab.ItemScrollFrameChild:SetSize(195, index * 11)
end

function Config:CreateMenu()

	ConfigWin = CreateFrame("Frame", "WLC_ConfigWin", UIParent, "BasicFrameTemplate")
	ConfigWin:SetSize(600, 300)
	ConfigWin:SetPoint("CENTER", UIParent, "CENTER")
	ConfigWin.title = ConfigWin:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ConfigWin.title:SetPoint("CENTER", ConfigWin.TitleBg, "CENTER", 0, 1)
	ConfigWin.title:SetText("Wislist Lootcouncil " .. Config.GetAddonVersion())


	local kara, gruul, magth = SetTabs(ConfigWin, 3, "Karazhan", "Gruul", "Magth")
	
	PopulateTabs(kara, "Karazhan")
	PopulateTabs(gruul, "Gruul's Lair")
	PopulateTabs(magth, "Magtheridon's Lair")

	ConfigWin:Hide()
	return ConfigWin
end