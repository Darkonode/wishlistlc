-------------------------------
-- Namespaces
-------------------------------
local _, namespace = ...

--------------------------------------
-- Custom Slash Command
--------------------------------------
namespace.commands = {
	["open"] = namespace.Config.Toggle, -- points to a function 'Toggle' in Config.lua
	
	["help"] = function()
		print(" ");
		namespace:Print("List of slash commands:")
		namespace:Print("|cff00cc66/wlc open|r - open addon");
		namespace:Print("|cff00cc66/wlc help|r - shows help info");
		print(" ");
	end
	
}

local function HandleSlashCommands(str)	
	if (#str == 0) then	
		-- User just entered "/wlc" with no additional args.
		namespace.commands.help();
		return;		
	end	
	
	local args = {};
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg);
		end
	end
	
	local path = namespace.commands; -- required for updating found table.
	
	for id, arg in ipairs(args) do
		arg = string.lower(arg)
		
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower();			
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args))); 
					return;					
				elseif (type(path[arg]) == "table") then				
					path = path[arg]; -- another sub-table found!
				end
			else
				-- does not exist!
				namespace.commands.help();
				return;
			end
		end
	end
end

function namespace:Print(...)
    local hex = select(4, self.Config:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "WislistLC " .. self.Config:GetAddonVersion() .. ": ");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

function namespace:init(event, name)
	if (name ~= "WishlistLC") then return end
	
	-------------------------------
	-- Slash commands
	-------------------------------
	-- Quicker reaload.
	SLASH_RELOADUI1 = "/rl"
	SlashCmdList.RELOADUI = ReloadUI

	-- Quicker access to frame stack.
	SLASH_FRAMESTK1 = "/fs"
	SlashCmdList.FRAMESTK = function()
		LoadAddOn('Blizzard_DebugTools')
		FrameStackTooltip_Toggle()
	end

	-- To be able to use arrow keys in edit box
	-- without rotating character.
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame" .. i .. "EditBox"]:SetAltArrowKeyMode(false)
	end

	-- Chat command for toggling addon window
	SLASH_WishlistLC1 = "/wlc"
	SlashCmdList.WishlistLC = HandleSlashCommands

	namespace:Print("Addon loaded.")
end

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", namespace.init)
