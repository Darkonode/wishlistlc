-------------------------------
-- Namespaces
-------------------------------
local _, namespace = ...
namespace.Utils = {}

local Utils = namespace.Utils

namespace.Raids = {"kara", "gruul", "magtheridon"}

function Utils:GetLoot(raid, filter)
	namespace.filter = filter or "all"
	namespace.filter = string.lower(namespace.filter)
	if raid == "kara" then
		namespace.Kara:FilterSearch()
	
	end
	if raid == "gruul" then
	
	else
	
	end
	return namespace.searchResult
end