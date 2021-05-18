-------------------------------
-- Namespaces
-------------------------------
local _, namespace = ...
namespace.Utils = {}

local Utils = namespace.Utils

namespace.Raids = {"kara", "gruul", "magtheridon"}

function Utils:GetLoot(raid, filter)
	namespace.filter = filter or "all"
	if raid == "kara"
		namespace.Kara:FilterSearch()
	
	if raid == "gruul"
	
	else
	
	end
	return namespace.searchResult
end