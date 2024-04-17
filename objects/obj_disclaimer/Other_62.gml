if ds_map_find_value(async_load, "id") == req
{
	if ds_map_find_value(async_load, "status") == 0
	{
		str = ds_map_find_value(async_load, "result");
		
		var firstline = string_copy(str, 1, string_pos("\n", str) - 1);
		var ver;
		
		if string_digits(firstline) == firstline
			ver = real(firstline);
		else
			ver = 0;
		
		if ver != version
		{
			cancon = false;
			str = lang_string("disclaimer.outdated");
		}
		else
		{
			global.onlinemode = true;
			
			ini_open("saveData.ini");
			if ini_read_real("online", "disclaimer", false)
			{
				event_user(0);
				ini_close();
				exit;
			}
			ini_close();
			
			str = string_copy(str, string_pos("\n", str) + 1, string_length(str));
			cancon = true;
		}
	}
	else
		str = lang_string("disclaimer.error");
	event_user(1);
}