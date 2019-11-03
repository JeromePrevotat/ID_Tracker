message("DEBUG");

nb_id = 0;
id_table = {};

local EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent",
	function update_id_file(nb_id, id_table)
		nb_id = GetNumSavedInstances();
		local i = 1;
		while (i <= nb_id) do
			name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(i);
			id_table[i] = {name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress};
			i = i + 1;
		end;
	end;
end);
