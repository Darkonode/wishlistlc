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
-- Config function
-------------------------------
function Config:Toggle()
	local menu = ConfigWin or Config:CreateMenu()
	menu:SetShown(not menu:IsShown())
end

function Config:GetThemeColor()
	local c = defaults.theme
	return c.r, c.g, c.b, c.hex
end

function Config:CreateMenu()

	ConfigWin = CreateFrame("Frame", "WLC_ConfigWin", UIParent, "BasicFrameTemplateWithInset")
	ConfigWin:SetSize(600, 300)
	ConfigWin:SetPoint("CENTER", UIParent, "CENTER")

	ConfigWin.title = ConfigWin:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	ConfigWin.title:SetPoint("CENTER", ConfigWin.TitleBg, "CENTER", 5, 0)
	ConfigWin.title:SetText("Wislist Lootcouncil v0.1")

	-----------------------------
	-- Wishlist frame
	-----------------------------
	local WishlistFrame = CreateFrame("Frame", nil, ConfigWin, "InsetFrameTemplate")

	WishlistFrame:SetSize(200, 200)
	WishlistFrame:SetPoint("RIGHT", ConfigWin, "RIGHT", -15, 0)

	WishlistFrame.title = WishlistFrame:CreateFontString(nil, "OVERLAY")
	WishlistFrame.title:SetFontObject("GameFontNormal")
	WishlistFrame.title:SetPoint("CENTER", WishlistFrame, "TOP", 0, 10)
	WishlistFrame.title:SetText("Raid X " .. "wishlist:")

	-----------------------------
	-- Wishlist frame buttons
	-----------------------------
	-- Clear button
	ConfigWin.clearButton = CreateFrame("Button", nil, ConfigWin, "GameMenuButtonTemplate")
	ConfigWin.clearButton:SetPoint("CENTER", WishlistFrame, "BOTTOMRIGHT", -35, -15)
	ConfigWin.clearButton:SetSize(70, 25)
	ConfigWin.clearButton:SetText("Clear")
	ConfigWin.clearButton:SetNormalFontObject("GameFontNormalLarge")
	ConfigWin.clearButton:SetHighlightFontObject("GameFontHighlightLarge")

	-- Delete button
	ConfigWin.delButton = CreateFrame("Button", nil, ConfigWin, "GameMenuButtonTemplate")
	ConfigWin.delButton:SetPoint("CENTER", WishlistFrame, "BOTTOMRIGHT", -110, -15)
	ConfigWin.delButton:SetSize(70, 25)
	ConfigWin.delButton:SetText("Delete")
	ConfigWin.delButton:SetNormalFontObject("GameFontNormalLarge")
	ConfigWin.delButton:SetHighlightFontObject("GameFontHighlightLarge")

	ConfigWin:Hide()
	return ConfigWin
end