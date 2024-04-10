/// @description world control mod

// pt online exclusive
if instance_exists(obj_login)
or (instance_exists(obj_gms) && global.__chat)
or (safe_get(obj_onlinemenu, "selectedsearch") or safe_get(obj_onlinemenu, "selectedpassword"))
or safe_get(obj_shell, "isOpen")
	exit;

if !debug
{
	instance_destroy();
	exit;
}

// funny variables
var tempobj, tempvar, temparray, tempind, tempval, tempscript, temproom, temproom2, temp_fetchobjects, temp_objfind, frz, i, scrarg;
WC_modkp = -1; // reset keybind

WC_mx = device_mouse_x_to_gui(0);
WC_my = device_mouse_y_to_gui(0);

// set depth
if depth == 0
	depth = power(2, 31) - 1;

// console open
if WC_consoleopen
{
	// control
	if keyboard_check(vk_control)
	{
		// paste
		if keyboard_check_pressed(ord("V")) && clipboard_has_text()
			keyboard_string += clipboard_get_text();
		
		// copy
		if keyboard_check_pressed(ord("C")) && string_replace_all(keyboard_string, " ", "") != ""
		{
			clipboard_set_text(keyboard_string);
			console_log("Copied command to clipboard");
			keyboard_string = "";
		}
		
		// delete all
		if keyboard_check_pressed(vk_backspace)
			keyboard_string = "";
	}
	
	// command history
	if keyboard_check_pressed(vk_up) && ds_list_size(WC_lastconsoleenter) != 0
	{
		// previous command
		WC_lastconsoleenterind = max(WC_lastconsoleenterind - 1, 0);
		keyboard_string = ds_list_find_value(WC_lastconsoleenter, WC_lastconsoleenterind);
	}
	if keyboard_check_pressed(vk_down) && ds_list_size(WC_lastconsoleenter) != 0
	{
		// more recent commands
		WC_lastconsoleenterind += 1;
		if WC_lastconsoleenterind > ds_list_size(WC_lastconsoleenter) - 1
		{
			WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
			keyboard_string = "";
		}
		else
			keyboard_string = ds_list_find_value(WC_lastconsoleenter, WC_lastconsoleenterind);
	}
	
	if keyboard_string != ds_list_find_value(WC_lastconsoleenter, WC_lastconsoleenterind)
	&& ds_list_size(WC_lastconsoleenter) != 0
		WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
	
	// expand console
	if WC_consolebottom < WC_maxconsolebottom
	{
		WC_consolebottom += WC_maxconsolebottom / 10;
		WC_consolebottom = min(WC_consolebottom, WC_maxconsolebottom);
	}
	if WC_consolebottom > WC_maxconsolebottom
	{
		WC_consolebottom -= 20;
		WC_consolebottom = max(WC_consolebottom, WC_maxconsolebottom);
	}
	
	// scroll
	if WC_my <= WC_maxconsolebottom
	{
		if mouse_wheel_up()
			WC_consolescroll += 1;
		if mouse_wheel_down()
			WC_consolescroll -= 1;
		WC_consolescroll = clamp(WC_consolescroll, 0, ds_list_size(WC_consolelist));
	}
	
	// line
	WC_drawlinetimer -= 1;
	if WC_drawlinetimer <= 0
	{
		WC_drawline = !WC_drawline;
		WC_drawlinetimer = 30;
	}
	
	if WC_consoletext != keyboard_string
	{
		WC_drawline = true;
		WC_drawlinetimer = 60;
	}
	
	// type on the console
	WC_consoletext = keyboard_string;
	if keyboard_check_pressed(vk_return)
	{
		WC_consoleenter = WC_consoletext;
		keyboard_string = "";
		WC_consoletext = "";
	}
}
else if ds_list_size(WC_bindkey) != 0 && WC_assetfinder < 0 // press binds
{
	for (i = 0; i < ds_list_size(WC_bindkey); i++)
	{
		if keyboard_check_pressed(ds_list_find_value(WC_bindkey, i))
			scr_wcevaluate(ds_list_find_value(WC_bindmap, i));
	}
}

// console not open
if !WC_consoleopen
{
	WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
	WC_consolebottom = 0;
	
	if WC_assetfinder == -1
		WC_consolescroll = 0;
}

// open console
if keyboard_check_pressed(WC_togglekey) && !WC_creatingobj && !WC_selectobj && WC_assetfinder < 0
{
	WC_consoleenter = "";
	WC_consoleopen = !WC_consoleopen;
	keyboard_string = "";
	WC_consoletext = "";
}

// console handler
if WC_consoleenter != ""
{
	if !WC_consolesilence && WC_consoleopen
		console_log("%..." + WC_consoleenter);
	
	if string_replace_all(WC_consoleenter, " ", "") != ""
	{
		// add to command history
		if !WC_consolesilence && WC_consoleopen
		{
			var alreadylogged = ds_list_find_index(WC_lastconsoleenter, WC_consoleenter);
			if alreadylogged != -1
				ds_list_delete(WC_lastconsoleenter, alreadylogged);
			ds_list_add(WC_lastconsoleenter, WC_consoleenter);
			WC_lastconsoleenterind = ds_list_size(WC_lastconsoleenter);
		}
		
		scr_wcevaluate(WC_consoleenter);
	}
	WC_consoleenter = "";
	WC_consolesilence = false;
}

// max size for console log
while ds_list_size(WC_consolelist) > power(2, 31) - 1
	ds_list_delete(WC_consolelist, power(2, 31) - 1);

// update frozen variables
if array_length(WC_frozenvar) != 0
{
	for (i = 0; i < array_length(WC_frozenvar); i++)
	{
		if WC_frozenvar[i] != undefined
		{
			if string_copy(WC_frozenvar[i], 1, 13) == "__WC_GLOBAL__"
				variable_global_set(string_replace(WC_frozenvar[i], "__WC_GLOBAL__", ""), WC_frozenval[i]);
			else if instance_exists(WC_frozenobj[i])
				variable_instance_set(WC_frozenobj[i], WC_frozenvar[i], WC_frozenval[i]);
		}
	}
}

// when you drag
if WC_candrag && WC_assetfinder < 0 && !WC_creatingobj && WC_selectobj == 0
{
	// stop dragging
	if mouse_check_button_released(mb_left)
	or (mouse_check_button_released(mb_middle) && !mouse_check_button(mb_left))
	{
		WC_dragobj = noone;
	
		if instance_exists(WC_fakedragobj)
		{
			with WC_fakedragobj
			{
				x = floor((mouse_x - other.WC_moffsetx) / other.WC_draggrid) * other.WC_draggrid;
				y = floor((mouse_y - other.WC_moffsety) / other.WC_draggrid) * other.WC_draggrid;
				
				if object_index == obj_otherplayer // pt online exclusive
					gms_p2p_send(p2p.wcdrag, player_id, x, y);
			}
			
			// just incase the object's coordinates are frozen
			for (i = 0; i < array_length(WC_frozenobj); i++)
			{
				if WC_fakedragobj == WC_frozenobj[i]
				{
					if WC_frozenvar[i] == "x"
						WC_frozenval[i] = WC_fakedragobj.x;
					if WC_frozenvar[i] == "y"
						WC_frozenval[i] = WC_fakedragobj.y;
				}
			}
			
			WC_fakedragobj = noone;
		}
	}

	// object gone failsafe
	if !instance_exists(WC_dragobj)
		WC_dragobj = noone;
	if !instance_exists(WC_fakedragobj)
		WC_fakedragobj = noone;

	// actually drag the object
	if instance_exists(WC_dragobj)
	{
		with WC_dragobj
		{
			x = floor((mouse_x - other.WC_moffsetx) / other.WC_draggrid) * other.WC_draggrid;
			y = floor((mouse_y - other.WC_moffsety) / other.WC_draggrid) * other.WC_draggrid;
			
			if object_index == obj_otherplayer // pt online exclusive
				gms_p2p_send(p2p.wcdrag, player_id, x, y);
		}
		
		// just incase the object's coordinates are frozen
		for (i = 0; i < array_length_1d(WC_frozenobj); i++)
		{
			if WC_dragobj == WC_frozenobj[i]
			{
				if WC_frozenvar[i] == "x"
					WC_frozenval[i] = WC_dragobj.x;
				if WC_frozenvar[i] == "y"
					WC_frozenval[i] = WC_dragobj.y;
			}
		}
	
		if mouse_check_button_pressed(mb_right)
			instance_destroy(WC_dragobj);
	}

	// start dragging the object
	if mouse_check_button_pressed(mb_left) && !(WC_consoleopen && WC_my <= WC_maxconsolebottom)
	{
		if keyboard_check(vk_control) && instance_exists(obj_player1) // drag player
		{
			WC_moffsetx = 0;
			WC_moffsety = 0;
		
			if keyboard_check(vk_alt)
				WC_fakedragobj = instance_find(obj_player1, 0);
			else
				WC_dragobj = instance_find(obj_player1, 0);
		}
		else if keyboard_check(vk_alt) // fake drag
		{
			WC_fakedragobj = collision_point(mouse_x, mouse_y, all, true, false);
			if instance_exists(WC_fakedragobj)
			{
				// pt exclusive
				if WC_fakedragobj.object_index == obj_baddiecollisionbox
				&& WC_prioritizebaddies
				{
					if instance_exists(WC_fakedragobj.baddieID)
						WC_fakedragobj = WC_fakedragobj.baddieID;
				}
				WC_moffsetx = mouse_x - WC_fakedragobj.x;
				WC_moffsety = mouse_y - WC_fakedragobj.y;
			}
		}
		else // normal drag
		{
			WC_dragobj = collision_point(mouse_x, mouse_y, all, true, false);
			if instance_exists(WC_dragobj)
			{
				// pt exclusive
				if WC_dragobj.object_index == obj_baddiecollisionbox
				&& WC_prioritizebaddies
				{
					if instance_exists(WC_dragobj.baddieID)
						WC_dragobj = WC_dragobj.baddieID;
				}
				WC_moffsetx = mouse_x - WC_dragobj.x;
				WC_moffsety = mouse_y - WC_dragobj.y;
			}
		}
	}

	// cancel fakedrag
	if mouse_check_button_pressed(mb_right) && instance_exists(WC_fakedragobj)
		WC_fakedragobj = noone;

	// duplicate the object
	if mouse_check_button_pressed(mb_middle) && !(WC_consoleopen && WC_my <= WC_maxconsolebottom)
	{
		if !instance_exists(WC_fakedragobj)
		{
			if !instance_exists(WC_dragobj)
				WC_dragobj = collision_point(mouse_x, mouse_y, all, false, false);
	
			if instance_exists(WC_dragobj)
			{
				with WC_dragobj
				{
					if other.WC_prioritizebaddies && object_index == obj_baddiecollisionbox // pt exclusive
					{
						var copy = noone;
						with baddieID
							copy = instance_copy(false);
						other.WC_dragobj = copy;
					}
					else
						other.WC_dragobj = instance_copy(false);
				}
				if !mouse_check_button(mb_left)
				{
					WC_moffsetx = mouse_x - WC_dragobj.x;
					WC_moffsety = mouse_y - WC_dragobj.y;
				}
				
				// pt exclusive
				if WC_prioritizebaddies
					with WC_dragobj
						boundbox = false;
			}
		}
		else
		{
			with WC_fakedragobj
			{
				var copyobj = instance_copy(false);
				copyobj.x = round(mouse_x - other.WC_moffsetx);
				copyobj.y = round(mouse_y - other.WC_moffsety);
			}
		}
	}

	// mass duplicate the object
	if keyboard_check(vk_control) && mouse_check_button(mb_middle) && instance_exists(WC_dragobj)
	{
		with WC_dragobj
			instance_copy(false);
	}
	if keyboard_check(vk_control) && mouse_check_button(mb_middle) && instance_exists(WC_fakedragobj)
	{
		with WC_fakedragobj
		{
			var copyobj = instance_copy(false);
			copyobj.x = round(mouse_x - other.WC_moffsetx);
			copyobj.y = round(mouse_y - other.WC_moffsety);
		}
	}
	
	// mass delete objects
	if mouse_check_button(mb_right) && keyboard_check(vk_control)
	{
		var delobj = collision_point(mouse_x, mouse_y, all, false, false);
		if instance_exists(delobj)
			instance_destroy(delobj);
	}
}
else
{
	WC_dragobj = noone;
	WC_fakedragobj = noone;
}

// going to rooms
if WC_modkp == vk_tab
{
	if keyboard_check(vk_control) // restart room
		room_restart();
	else
	{
		temproom = get_string("Go to room (index or full name)", room_get_name(room))
		if temproom == ""
			exit;
		if string_length(string_digits(temproom)) + string_count("-", temproom) + string_count(".", temproom) == string_length(temproom)
		{
			if room_exists(real(temproom))
			{
				show_message("Successfully traveled to " + room_get_name(real(temproom)) + " (index: " + temproom + ")");
				room_goto(real(temproom));
				with obj_player // pt exclusive
					targetDoor = "none";
			}
			else
				show_message("Room index out of range");
		}
		else
		{
			temproom2 = asset_get_index(temproom);
			if temproom2 == -1
				show_message("Room doesn't exist. Check for typos");
			else if asset_get_type(temproom) != asset_room
				show_message("The asset " + temproom + " isn't a room");
			else
			{
				show_message("Successfully traveled to " + temproom + " (index: " + string(temproom2) + ")");
				room_goto(temproom2);
				with obj_player // pt exclusive
					targetDoor = "none";
			}
		}
	}
}

// start creating objects
if WC_modkp == ord("1")
{
	if keyboard_check(vk_control) // object list
	{
		temp_fetchobjects = "There are " + string(instance_number(all)) + " instances in this room:\n"
		
		for (i = 0; i < instance_number(all); i += 1)
			temp_fetchobjects = temp_fetchobjects + "\n" + object_get_name(instance_find(all, i).object_index);
		
		show_message(temp_fetchobjects);
	}
	else
	{
		tempobj = get_string("Create object:\nInput the object's name", "");
		if tempobj == ""
			exit;
		
		WC_tempobj = asset_get_index(tempobj);
		if WC_tempobj == -1
		{
			show_message("Asset " + tempobj + " doesn't exist. Check for typos");
			exit;
		}
		else if asset_get_type(tempobj) != asset_object
		{
			show_message("The asset " + tempobj + " isn't an object");
			exit;
		}
		
		WC_creatingobj = true;
	}
}

// clicking to create objects
if WC_creatingobj
{
	WC_consoleopen = false;
	WC_dragobj = noone;
	WC_fakedragobj = noone;
	
	if mouse_check_button_pressed(mb_left) or (mouse_check_button(mb_left) && keyboard_check(vk_control))
		instance_create(floor(mouse_x / WC_draggrid) * WC_draggrid, floor(mouse_y / WC_draggrid) * WC_draggrid, WC_tempobj);
	
	if mouse_check_button_pressed(mb_right)
		WC_creatingobj = false;
}

// set variable
if WC_modkp == ord("3")
{
	if keyboard_check(vk_shift)
	{
		// global
		tempvar = get_string("Input global variable name here", "");
		if tempvar == ""
			exit;
		if variable_global_exists(tempvar) && is_array(variable_global_get(tempvar))
		{
			show_message("The global variable " + tempvar + " is an array. Set arrays with the array command");
			exit;
		}
		
		if variable_global_exists(tempvar)
			tempval = get_string("Overwriting existing value from global." + tempvar + " to...", variable_global_get(tempvar));
		else
			tempval = get_string("Creating new global variable global." + tempvar + " with value...", "")
		
		if tempval == ""
			exit;
		
		if asset_get_index(tempval) != -1 // asset
		{
			variable_global_set(tempvar, asset_get_index(tempval));
			show_message("Set global variable global." + string(tempvar) + " to asset " + tempval);
		}
		else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
		// number
		{
			variable_global_set(tempvar, real(tempval));
			show_message("Set global variable global." + string(tempvar) + " to number " + tempval);
		}
		else if tempval == "undefined" // undefined
		{
			variable_global_set(tempvar, undefined);
			show_message("Set global variable global." + string(tempvar) + " to undefined");
		}
		else // string
		{
			tempval = string_replace(tempval, "\\", "");
			variable_global_set(tempvar, tempval);
			show_message("Set global variable global." + string(tempvar) + " to string " + tempval);
		}
		
		for (i = 0; i < array_length(WC_frozenobj); i++)
		{
			if "__WC_GLOBAL__" + tempvar == WC_frozenvar[i]
				WC_frozenval[i] = variable_global_get(tempvar);
		}
	}
	else
	{
		WC_selectobj = 1;
		WC_tempobj = noone;
	}
}

// all functions
if WC_selectobj != 0
{
	WC_creatingobj = false;
	WC_consoleopen = false;
	WC_dragobj = noone;
	WC_fakedragobj = noone;
	
	tempobj = collision_point(mouse_x, mouse_y, all, false, false);
	
	// pt exclusive
	if instance_exists(tempobj) && tempobj.object_index == obj_baddiecollisionbox
	&& WC_prioritizebaddies
	{
		if instance_exists(tempobj.baddieID)
			tempobj = tempobj.baddieID;
	}
	
	WC_tempobj = tempobj;
	var selected = false;
	
	// manual input
	if mouse_check_button_pressed(mb_middle)
	{
		var tempobj_name = get_string("Manual object selection:\nInput the object's name", "");
		if tempobj_name == ""
		{
			WC_selectobj = 0;
			WC_tempobj = noone;
			exit;
		}
		else
		{
			tempobj = asset_get_index(tempobj_name);
			
			if tempobj == -1
			{
				show_message("Object " + tempobj_name + " doesn't exist. Check for typos");
				WC_selectobj = 0;
				WC_tempobj = noone;
				exit;
			}
			else if asset_get_type(tempobj_name) != asset_object
			{
				show_message("The asset " + tempobj_name + " isn't an object");
				WC_selectobj = 0;
				WC_tempobj = noone;
				exit;
			}
			else
			{
				if instance_number(tempobj) == 1
				{
					tempobj = instance_find(tempobj, 0);
					selected = true;
				}
				else if instance_number(tempobj) == 0
				{
					show_message("The object isn't in the room.");
					WC_selectobj = 0;
					WC_tempobj = noone;
					exit;
				}
				else if instance_number(tempobj) > 1
				{
					temp_objfind = get_integer("Multiple instances of this object were found. Specify which (0 to " + string(instance_number(tempobj) - 1) + ")", 0);
					tempobj = instance_find(tempobj, temp_objfind);
					if tempobj == noone
					{
						show_message("The object isn't in the room.");
						WC_selectobj = 0;
						WC_tempobj = noone;
						exit;
					}
					selected = true;
				}
			}
		}
	}
	
	if (mouse_check_button_pressed(mb_left) or selected) && instance_exists(tempobj)
	{
		WC_tempobj = noone;
		switch WC_selectobj
		{
			case 1: // set variable
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput variable name here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				if variable_instance_exists(tempobj, tempvar) && is_array(variable_instance_get(tempobj, tempvar))
					show_message("The variable " + tempvar + " is an array. Set arrays with the array command");
				
				if variable_instance_exists(tempobj, tempvar)
					tempval = get_string("Overwriting existing value from " + tempvar + " to...", string(variable_instance_get(tempobj, tempvar)));
				else
					tempval = get_string("Creating new variable " + tempvar + " with value...", "");
				
				if tempval == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if asset_get_index(tempval) != -1 // asset
				{
					variable_instance_set(tempobj, tempvar, asset_get_index(tempval));
					show_message("Set variable " + string(tempvar) + " to asset " + tempval);
				}
				else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
				// number
				{
					variable_instance_set(tempobj, tempvar, real(tempval));
					show_message("Set variable " + string(tempvar) + " to number " + tempval);
				}
				else if tempval == "undefined" // undefined
				{
					variable_instance_set(tempobj, tempvar, undefined);
					show_message("Set variable " + string(tempvar) + " to undefined");
				}
				else // string
				{
					tempval = string_replace(tempval, "\\", "");
					variable_instance_set(tempobj, tempvar, tempval);
					show_message("Set variable " + string(tempvar) + " to string " + tempval);
				}
				
				// set variable if frozen
				for (i = 0; i < array_length_1d(WC_frozenobj); i++)
				{
					if tempobj == WC_frozenobj[i] && tempvar == WC_frozenvar[i]
						WC_frozenval[i] = variable_instance_get(tempobj, tempvar);
				}
				break;
			
			case 2: // freeze variable
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput variable name to freeze here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar)
				{
					frz = array_length_1d(WC_frozenobj)
					for (i = 0; i < frz; i++)
					{
						// unfreeze variable
						if tempobj == WC_frozenobj[i] && tempvar == WC_frozenvar[i]
						{
							WC_frozenobj[i] = noone;
							WC_frozenvar[i] = undefined;
							WC_frozenval[i] = undefined;
							
							WC_selectobj = 0;
							show_message("UNFROZEN variable " + tempvar + " in object " + object_get_name(tempobj.object_index));
							exit;
						}
					}
					for (i = 0; i < frz; i++)
					{
						// find undefined slot to replace
						if WC_frozenvar[i] == undefined
							frz = i;
					}
					
					WC_frozenobj[frz] = tempobj;
					WC_frozenvar[frz] = tempvar;
					WC_frozenval[frz] = variable_instance_get(tempobj, tempvar);
					show_message("Frozen variable " + tempvar + " in object " + object_get_name(tempobj.object_index) + " to value of " + string(WC_frozenval[frz]));
				}
				else
					show_message("Variable " + tempvar + " doesn't exist. Check for typos");
				break;
			
			case 3: // execute script
				tempscript = get_string("Input script here", "");
				if tempscript == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				var get_script = asset_get_index(tempscript)
				if get_script == -1
				{
					show_message("Script " + tempscript + "doesn't exist");
					WC_selectobj = 0;
					exit;
				}
				if asset_get_type(tempscript) != asset_script
				{
					show_message("The asset " + tempscript + " isn't a script");
					WC_selectobj = 0;
					exit;
				}
				
				var script_argcount = get_integer("Number of arguments? (Max 10)", 0);
				i = 0;
				
				scrarg[0] = undefined;
				scrarg[1] = undefined;
				scrarg[2] = undefined;
				scrarg[3] = undefined;
				scrarg[4] = undefined;
				scrarg[5] = undefined;
				scrarg[6] = undefined;
				scrarg[7] = undefined;
				scrarg[8] = undefined;
				scrarg[9] = undefined;
				
				repeat clamp(script_argcount, 0, 10)
				{
					scrarg[i] = get_string("Type in the value for argument " + string(i), "");
					if asset_get_index(scrarg[i]) != -1 // asset
						scrarg[i] = asset_get_index(scrarg[i]);
					else if string_length(string_digits(scrarg[i])) + string_count("-", scrarg[i]) + string_count(".", scrarg[i]) == string_length(scrarg[i])
					// number
						scrarg[i] = real(scrarg[i]);
					else if scrarg[i] == "undefined" // undefined
						scrarg[i] = undefined;
					i++;
				}
				
				with tempobj
					script_execute(get_script, scrarg[0], scrarg[1], scrarg[2], scrarg[3], scrarg[4], scrarg[5], scrarg[6], scrarg[7], scrarg[8], scrarg[9])
				break;
			
			case 4: // debug
				WC_debuginfo = true;
				show_debug_overlay(WC_debuginfo);
				
				WC_debugselected = tempobj;
				WC_debugvarstart = 0;
				break;
			
			case 5: // set array
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput array name here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar) && !is_array(variable_instance_get(tempobj, tempvar))
				{
					show_message("The variable " + tempvar + " isn't an array.");
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar)
				{
					tempind = get_integer("Input which index in the array to access", 0);
					temparray = variable_instance_get(tempobj, tempvar);
				}
				else
					tempind = get_integer("Variable " + tempvar + " doesn't exist, creating new array.\nInput which index in the array to access", 0);
				
				if tempind < 0
				{
					show_message("Negative indexes are not allowed")
					WC_selectobj = 0;
					exit;
				}
				
				if tempind < array_length_1d(temparray) && temparray[tempind] != pointer_null
					tempval = get_string("Overwriting existing value from " + tempvar + "[" + string(tempind) + "] to...", temparray[tempind]);
				else
					tempval = get_string("Creating new index for " + tempvar + "[" + string(tempind) + "] with value of...", "");
				
				if tempval == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if asset_get_index(tempval) != -1 // asset
				{
					temparray[tempind] = asset_get_index(tempval);
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to asset " + tempval);
				}
				else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
				// number
				{
					temparray[tempind] = real(tempval);
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to number " + tempval);
				}
				else if tempval == "undefined"
				// undefined
				{
					temparray[tempind] = undefined;
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to undefined");
				}
				else // string
				{
					temparray[tempind] = string_replace(tempval, "\\", "");
					
					variable_instance_set(tempobj, tempvar, temparray);
					show_message("Set array " + string(tempvar) + "[" + string(tempind) + "] to string " + temparray[tempind]);
				}
				break;
			
			case 6: // monitor variable
				tempvar = get_string("Selected " + object_get_name(tempobj.object_index) + "\nInput variable to monitor here", "");
				if tempvar == ""
				{
					WC_selectobj = 0;
					exit;
				}
				
				if variable_instance_exists(tempobj, tempvar)
				{
					WC_varmonitor = tempvar;
					WC_varobj = tempobj;
					show_message("Now monitoring " + object_get_name(tempobj.object_index) + "." + tempvar);
					break;
				}
				else
					show_message("The variable \"" + tempvar + "\"" + " doesn't exist. Check for typos");
				break;
		}
		
		WC_selectobj = 0;
	}
	
	// cancel
	if mouse_check_button_pressed(mb_right)
		WC_selectobj = 0;
}

// out of bounds camera
if WC_modkp == ord("4")
{
	WC_oobcam = !WC_oobcam;
	
	if !WC_consoleopen
	{
		with obj_tv
		{
			showtext = true;
			if other.WC_oobcam
				message = "LIMITLESS CAMERA ON";
			else
				message = "LIMITLESS CAMERA OFF";
			alarm[0] = 50;
		}
	}
}

// pizza time and snick challenge
if WC_modkp == ord("5")
{
	// pt exclusive
	if keyboard_check(vk_control) && !WC_consoleopen
	{
		if global.snickchallenge
		{
			with obj_camera
				alarm[1] = -1;
			audio_stop_all();
			global.snickchallenge = false;
			
			with obj_music
				event_perform(ev_other, ev_room_start);
		}
		else
		{
			global.panic = false;
			global.wave = 0;
			global.maxwave = ((global.minutes * 60) + global.seconds) * 60;
			if global.panicbg
				scr_panicbg_init();
			global.snickchallenge = true;
			global.collect = 10000;
			
			with obj_camera
			{
				alarm[1] = 60;
				global.seconds = 59;
				global.minutes = 9;
			}
			
			if !instance_exists(obj_snickexe)
				instance_create(room_width / 2, -10, obj_snickexe);
		}
	}
	else if global.panic
	{
		with obj_camera
			alarm[1] = -1;
		audio_stop_all();
		global.panic = false;
		
		with obj_music
			event_perform(ev_other, ev_room_start);
	}
	else
	{
		global.snickchallenge = false;
		with instance_create(room_width + 1000, room_height + 1000, obj_hungrypillar)
			instance_destroy();
	}
}

// freeze variables
if WC_modkp == ord("6")
{
	if keyboard_check(vk_control)
	{
		for (i = 0; i < array_length_1d(WC_frozenvar); i++)
		{
			WC_frozenobj[i] = noone;
			WC_frozenvar[i] = undefined;
			WC_frozenval[i] = undefined;
		}
		WC_frozenvar[0] = "";
		WC_frozenval[0] = "";
		show_message("Unfrozen all variables");
	}
	else if keyboard_check(vk_shift) // global
	{
		tempvar = get_string("Input global variable name to freeze here (don't put global.)", "");
		if tempvar == ""
		{
			WC_selectobj = 0;
			exit;
		}
		
		if variable_global_exists(tempvar)
		{
			frz = array_length_1d(WC_frozenobj);
			for (i = 0; i < frz; i++)
			{
				if "__WC_GLOBAL__" + tempvar == WC_frozenvar[i]
				{
					WC_frozenobj[i] = noone;
					WC_frozenvar[i] = undefined;
					WC_frozenval[i] = undefined;
					
					WC_selectobj = 0;
					show_message("UNFROZEN global variable " + tempvar);
					exit;
				}
			}
			for (i = 0; i < frz; i++)
			{
				// find undefined slot to replace
				if WC_frozenvar[i] == undefined
					frz = i;
			}
			
			WC_frozenobj[frz] = noone;
			WC_frozenvar[frz] = "__WC_GLOBAL__" + tempvar;
			WC_frozenval[frz] = variable_global_get(tempvar);
			
			show_message("Frozen global variable " + tempvar + " to value of " + string(WC_frozenval[frz]));
		}
		else
			show_message("Global variable " + tempvar + " doesn't exist. Check for typos");
	}
	else
	{
		WC_tempobj = noone;
		WC_selectobj = 2;
	}
}

// toggle invisible objects
if WC_modkp == ord("7")
	WC_showinvisible = !WC_showinvisible;

// execute script
if WC_modkp == ord("8")
{
	WC_tempobj = noone;
	WC_selectobj = 3;
}

// debug info
if WC_modkp == ord("9")
{
	if !(WC_debuginfo && (keyboard_check(vk_control) or keyboard_check(vk_shift)))
	{
		WC_debuginfo = !WC_debuginfo;
		show_debug_overlay(WC_debuginfo);
	}
	
	if WC_debuginfo
	{
		if keyboard_check(vk_control)
		{
			WC_tempobj = noone;
			WC_selectobj = 4;
		}
		else if keyboard_check(vk_shift)
		{
			WC_debugselected = global;
			WC_debugvarstart = 0;
		}
	}
	else
		WC_debugselected = noone;
}

// set arrays
if WC_modkp == ord("0")
{
	if keyboard_check(vk_shift) // global
	{
		tempvar = get_string("Input global array name here", "");
		if tempvar == ""
			exit;
		
		if variable_global_exists(tempvar) && !is_array(variable_global_get(tempvar))
		{
			show_message("The global variable " + tempvar + " isn't an array.");
			exit;
		}
		
		if variable_global_exists(tempvar)
		{
			tempind = get_integer("Input which index in the array to access", 0);
			temparray = variable_global_get(tempvar);
		}
		else
			tempind = get_integer("Variable " + tempvar + " doesn't exist, creating new array.\nInput which index in the array to access", 0);
		
		if tempind < 0
		{
			show_message("Negative indexes are not allowed");
			exit;
		}
		
		if tempind < array_length_1d(temparray) && temparray[tempind] != pointer_null
			tempval = get_string("Overwriting existing value from global." + tempvar + "[" + string(tempind) + "] to...", temparray[tempind]);
		else
			tempval = get_string("Creating new index for global." + tempvar + "[" + string(tempind) + "] with value of...", "");
		if tempval == ""
			exit;
		
		if asset_get_index(tempval) != -1 // asset
		{
			temparray[tempind] = asset_get_index(tempval);
			
			variable_global_set(tempvar, temparray);
			show_message("Set global array global." + string(tempvar) + "[" + string(tempind) + "] to asset " + tempval)
		}
		else if string_length(string_digits(tempval)) + string_count("-", tempval) + string_count(".", tempval) == string_length(tempval)
		// number
		{
			temparray[tempind] = real(tempval);
			
			variable_global_set(tempvar, temparray);
			show_message("Set global array global." + string(tempvar) + "[" + string(tempind) + "] to number " + tempval);
		}
		else if tempval == "undefined" // undefined
		{
			temparray[tempind] = undefined;
			
			variable_global_set(tempvar, temparray);
			show_message("Set global array global." + string(tempvar) + "[" + string(tempind) + "] to undefined");
		}
		else // string
		{
			temparray[tempind] = tempval;
			
			variable_global_set(tempvar, temparray);
			show_message("Set global array global." + string(tempvar) + "[" + string(tempind) + "] to string " + tempval);
		}
	}
	else
	{
		WC_selectobj = 5;
		WC_tempobj = noone;
	}
}

// reset window res
if WC_modkp == vk_numpad0
{
	// pt exclusive
	window_set_size(960, 540);
	if !WC_consoleopen
	{
		with obj_tv
		{
			showtext = true;
			message = "WINDOW RESOLUTION RESET";
			alarm[0] = 100;
		}
	}
}

// reset room saves
if WC_modkp == vk_numpad1
{
	// pt exclusive
	ds_list_clear(global.saveroom);
	ds_list_clear(global.baddieroom);
	if !WC_consoleopen
	{
		with obj_tv
		{
			showtext = true;
			message = "SAVEROOM AND BADDIEROOM RESET";
			alarm[0] = 100;
		}
	}
	room_restart();
}

// win level
if WC_modkp == vk_numpad2
{
	// pt exclusive
	if instance_exists(obj_player1)
	{
		audio_stop_all();
		
		if obj_player1.character != "S"
		{
			global.panic = true;
			global.snickchallenge = false;
			
			obj_player1.state = states.normal;
			obj_player1.grounded = true;
			obj_player1.key_up = true;
			obj_player1.key_up2 = true;
				
			with obj_player1
			{
				with instance_create_depth(obj_player1.x, obj_player1.y, 0, obj_exitgate)
				{
					image_index = 1;
					visible = false;
					event_perform(ev_collision, obj_player);
				}
			}
		}
		else
		{
			global.seconds = 1;
				
			global.panic = false;
			global.snickchallenge = false;
				
			with instance_create(obj_player1.x, obj_player1.y, obj_snicklevelend)
				image_index = image_number - 1;
		}
	}
	else
		show_message("Player 1 object doesn't exist");
}

// restart game
if WC_modkp == vk_numpad3
{
	audio_stop_all();
	game_restart();
}

// manually delete an object
if WC_modkp == vk_numpad4
{
	tempobj = get_string("Manual object deletion:\nInput the object's name", "")
	if tempobj != ""
	{
		WC_tempobj = asset_get_index(tempobj)
		if !object_exists(WC_tempobj)
			show_message("Object " + tempobj + " doesn't exist. Check for typos");
		else
		{
			if instance_number(WC_tempobj) == 1
			{
				WC_tempobj = instance_find(WC_tempobj, 0);
				show_message("Deleted object " + object_get_name(WC_tempobj.object_index));
				instance_destroy(WC_tempobj);
			}
			else if instance_number(WC_tempobj) <= 0
				show_message("The object isn't in the room");
			else if instance_number(WC_tempobj) > 1
			{
				temp_objfind = get_integer("Multiple instances of this object were found. Specify which (0 to " + string(instance_number(WC_tempobj) - 1) + ")", 0);
				WC_tempobj = instance_find(WC_tempobj, temp_objfind);
				
				if WC_tempobj == noone
					show_message("The object isn't in the room");
				else
				{
					show_message("Deleted object " + object_get_name(WC_tempobj.object_index));
					instance_destroy(WC_tempobj);
				}
			}
		}
	}
}

// monitor variables
if WC_modkp == vk_numpad6
{
	if WC_varmonitor != undefined
	{
		WC_varmonitor = undefined;
		WC_varobj = undefined;
	}
	else if keyboard_check(vk_control) // global
	{
		tempvar = get_string("Input global variable to monitor here", "");
		if tempvar == ""
			exit;
		if variable_global_exists(tempvar)
		{
			WC_varmonitor = tempvar;
			WC_varobj = global;
			show_message("Now monitoring global." + tempvar);
		}
		else
			show_message("The global variable \"" + tempvar + "\"" + " doesn't exist. Check for typos");
	}
	else
	{
		WC_selectobj = 6;
		WC_tempobj = noone;
	}
}

// travel rooms
/*
if keyboard_check_pressed(vk_insert) && room_exists(room_next(room))
{
	with obj_player // pt exclusive
		targetDoor = "none";
	room_goto_next();
}
if keyboard_check_pressed(vk_delete) && room_exists(room_previous(room))
{
	with obj_player // pt exclusive
		targetDoor = "none";
	room_goto_previous();
}
*/

// live execute exclusive
if WC_livestep != undefined
	live_snippet_call(WC_livestep);

// reset keybind
WC_modkp = -1;

// delete if multiple instances
if instance_number(object_index) > 1
	instance_destroy(instance_find(object_index, instance_number(object_index) - 1));