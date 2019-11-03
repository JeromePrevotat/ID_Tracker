message("TEST");

nb_id = 0;
id_table = {};

local function get_instance_id(nb_id)
	local i = 1;
	local tmp = {};
	while (i <= nb_id) do
		tmp[i - 1] = GetSavedInstanceInfo(i);
		i = i + 1;
	end;
	return tmp;
end;

local EventFrame = CreateFrame("Frame");
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
EventFrame:SetScript("OnEvent", update_id_file);
EventFrame:SetScript("OnEvent",
	function update_id_file(nb_id, id_table)
		nb_id = GetNumSavedInstances();
		id_table = get_instance_id(nb_id);
	end;
end);