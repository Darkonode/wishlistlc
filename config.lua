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
	},
	version = "v0.2",
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
--			local TabName = "WLC_ConfigWinTab" .. SelectedTabID
			_G["WLC_ConfigWinTab" .. SelectedTabID].content:Hide()
		end
	end
	
	PanelTemplates_SetTab(tab:GetParent(), tab:GetID())
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

--Clicking an item in the item frame
local function OnClickItemFrameItem(self, motion)
	print(self:GetText())
end

--Update item frame after change
local function UpdateItemFrame(self, elements)
	index = 0
	local first_elem = true
	for key, item in next, namespace.Kara.searchResult do
		local buttonName = "%parentButton".. key
		
		if _G[buttonName] then
			if first_elem then
				_G[buttonName]:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4 - i*10)
				first_elem = false
			else
				_G[buttonName]:SetPoint("TOPLEFT", buttonName, "TOPLEFT", 4, -4 - i*10)
			end
			index = index + 1
			_G[buttonName]:SetShown(not self.buttonName:IsShown())
			
		else
			if first_elem then
				self.buttonName = CreateFrame("Button", buttonName, self, "OptionsListButtonTemplate")
				self.buttonName:SetPoint("TOPLEFT", buttonName, "TOPLEFT", 4, -4 - i*10)
				self.buttonName:SetSize(192, 10)
				self.buttonName:SetHighlightTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2")
				self.buttonName:SetText(item.name)
				self.buttonName.tooltipText = item.slot
				self.buttonName:SetScript("OnEnter", OnEnter)
				self.buttonName:SetScript("OnLeave", OnLeave)
				self.buttonName:SetScript("OnClick", OnClickItemFrameItem)
				first_elem = false
				
				
			else
				self.buttonName = CreateFrame("Button", buttonName, self, "OptionsListButtonTemplate")
				self.buttonName:SetPoint("TOPLEFT", buttonName, "TOPLEFT", 4, -4 - i*10)
				self.buttonName:SetSize(192, 10)
				self.buttonName:SetHighlightTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2")
				self.buttonName:SetText(item.name)
				self.buttonName.tooltipText = item.slot
				self.buttonName:SetScript("OnEnter", OnEnter)
				self.buttonName:SetScript("OnLeave", OnLeave)
				self.buttonName:SetScript("OnClick", OnClickItemFrameItem)
			end
			index = index + 1
		end
	end
end

--Update wishlist frame after change
local function UpdateWishlistFrame(self)

end

--Delete item from wishlist
local OnClickWishlistItem (self)
	namespace.Kara:DeleteFromWishlist(self)
	UpdateWishlistFrame(self:GetParent())
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
	
	-----------------------------
	-- Item frame options list buttons
	-----------------------------
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