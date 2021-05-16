-------------------------------
-- Namespaces
-------------------------------
local _, namespace = ...
namespace.Config = {}

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
	}
}

-------------------------------
-- Event handlers
-------------------------------
function Config:Toggle()
	local menu = ConfigWin or Config:CreateMenu()
	menu:SetShown(not menu:IsShown())
end

function Config:GetThemeColor()
	local c = defaults.theme
	return c.r, c.g, c.b, c.hex
end

local function Tab_OnClick(self)
	local SelectedTabID = PanelTemplates_GetSelectedTab(self:GetParent())
	if (SelectedTabID) then
		if (SelectedTabID ~= self:GetID()) then
			local TabName = "WLC_ConfigWinTab" .. SelectedTabID
			_G[TabName].content:Hide()
		end
	end
	
	PanelTemplates_SetTab(self:GetParent(), self:GetID())
	self.content:Show()
end

-------------------------------
-- Config function
-------------------------------

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

local function PopulateTabs(tab, raid)
	-----------------------------
	-- Wishlist frame
	-----------------------------
	tab.WishlistFrame = CreateFrame("Frame", nil, tab, "InsetFrameTemplate")

	tab.WishlistFrame:SetSize(200, 230)
	tab.WishlistFrame:SetPoint("TOPRIGHT", ConfigWin, "TOPRIGHT", -10, -45)

	tab.WishlistFrame.title = tab.WishlistFrame:CreateFontString(nil, "OVERLAY")
	tab.WishlistFrame.title:SetFontObject("GameFontNormal")
	tab.WishlistFrame.title:SetPoint("BOTTOMLEFT", tab.WishlistFrame, "TOPLEFT", 5, 3)
	tab.WishlistFrame.title:SetText(raid .. " wishlist:")

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
	tab.ItemFrame = CreateFrame("Frame", nil, tab, "InsetFrameTemplate")
	
	tab.ItemFrame:SetSize(200, 212)
	tab.ItemFrame:SetPoint("TOPRIGHT", tab.WishlistFrame, "TOPLEFT", -10, 0)

	tab.ItemFrame.title = tab.ItemFrame:CreateFontString(nil, "OVERLAY")
	tab.ItemFrame.title:SetFontObject("GameFontNormal")
	tab.ItemFrame.title:SetPoint("BOTTOMLEFT", tab.ItemFrame, "TOPLEFT", 5, 3)
	tab.ItemFrame.title:SetText(raid .. " drops:")
	
	-----------------------------
	-- Item frame search bar
	-----------------------------
	tab.searchBar = CreateFrame("EditBox", nil, tab, "SearchBoxTemplate")
	tab.searchBar:SetPoint("BOTTOM", tab.ItemFrame, "BOTTOM", 2, -16)
	tab.searchBar:SetSize(195, 15)
end

function Config:CreateMenu()

	ConfigWin = CreateFrame("Frame", "WLC_ConfigWin", UIParent, "BasicFrameTemplate")
	ConfigWin:SetSize(600, 300)
	ConfigWin:SetPoint("CENTER", UIParent, "CENTER")
	ConfigWin.title = ConfigWin:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ConfigWin.title:SetPoint("CENTER", ConfigWin.TitleBg, "CENTER", 0, 1)
	ConfigWin.title:SetText("Wislist Lootcouncil v0.1")


	local kara, gruul, magth = SetTabs(ConfigWin, 3, "Karazhan", "Gruul", "Magth")
	
	PopulateTabs(kara, "Karazhan")
	PopulateTabs(gruul, "Gruul's Lair")
	PopulateTabs(magth, "Magtheridon's Lair")

	ConfigWin:Hide()
	return ConfigWin
end