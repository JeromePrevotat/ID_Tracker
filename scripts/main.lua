ID_Tracker = { }

message("DEBUG");

local EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent", function (this, event, ...)
	ID_Tracker[event](ID_Tracker, ...)
end);

function ID_Tracker:PLAYER_ENTERING_WORLD(init)

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
		id_table[i] = id_infos;	
		i = i + 1;
	end
end;

function ID_Tracker:SetDefaults()
	if not character_name or not character_realm then character_name, character_realm = UnitName("player") end;
	if not nb_id then nb_id = GetNumSavedInstances() end;
	if not id_table then id_table = {} end;
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
