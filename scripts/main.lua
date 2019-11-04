ID_Tracker = { }

message("DEBUG");

local EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent", function (this, event, ...)
	ID_Tracker[event](ID_Tracker, ...)
end);

function ID_Tracker:PLAYER_ENTERING_WORLD()

	self:SetDefaults()
	local i = 1;
	nb_id = GetNumSavedInstances();
	character_name, character_realm = UnitName("player");
		
	while (i <= nb_id and nb_id > 0) do
		name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i);
		id_infos = {
			["name"] = name, 
			["id"] = id,
			["reset"] = reset,
			["difficulty"] = difficulty,
			["locked"] = locked,
			["extended"] = extended,
			["instanceIDMostSig"] = instanceIDMostSig,
			["isRaid"] = isRaid,
			["maxPlayers"] = maxPlayers,
			["difficultyName"] = difficultyName,
			["numEncounters"] = numEncounters,
			["encounterProgress"] = encounterProgress,
		}
		id_table[character_name][i] = id_infos;	
		i = i + 1;
	end
end;

function ID_Tracker:SetDefaults()
	if not character_name or not character_realm then character_name, character_realm = UnitName("player") end;
	if not nb_id then nb_id = GetNumSavedInstances() end;
	if not id_table then id_table = {} end;
	
	character_exists = false;
	for key,value in pairs(id_table) do
		if key == character_name then character_exists = true end;
	end
	if not character_exists then id_table[character_name] = {} end;
	
	if not id_infos then
		id_infos = {
			["name"] = "", 
			["id"] = 0,
			["reset"] = 0,
			["difficulty"] = 0,
			["locked"] = false,
			["extended"] = false,
			["instanceIDMostSig"] = 0,
			["isRaid"] = false,
			["maxPlayers"] = 0,
			["difficultyName"] = "",
			["numEncounters"] = 0,
			["encounterProgress"] = 0,
		}
	end;
	return true;
end

SLASH_PRINT_ALL_ID1 = "/allmyid";
SLASH_FIND_FREE_BY_INSTANCE_NAME1 = "/whocan"

SlashCmdList["FIND_FREE_BY_INSTANCE_NAME"] = function (instance_name)
	local str = "";
	local character_free = true;
	local i = 1;
	for key,value in pairs(id_table) do
		if ((#id_table[key]) == 0) then str = str .. key .. "\n"
		else
			i = 1;
			character_free = true;
			while (i <= (#id_table[key])) do
				if (id_table[key][i]["name"] == instance_name)
				then character_free = false end 
				i = i + 1;
			end
			if character_free then str = str .. key .. "\n" end
		end
	end
	if str == "" then str = "All your characters are tag !" end
	message(str);
end

SlashCmdList["PRINT_ALL_ID"] = function ()
	local str = "";
	local i = 1;
	for key,value in pairs(id_table) do
		str = str .. key .. ":\n"
		i = 1;
		while (i <= (#id_table[key])) do
			str = str .. id_table[key][i]["name"] .. " " .. id_table[key][i]["difficultyName"] .. "\n"; 
			i = i + 1;
		end
	end
	message(str);
end
