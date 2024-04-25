// wrong room order dumbfuck
global.pastdisclaimer = false;
if !(room_first == rm_load && room_next(room_first) == Realtitlescreen)
{
	audio_stop_all();
	scr_soundeffect(sfx_pephurt);
	
	show_message("The room order does not match");
	game_end();
	exit;
}

// trace script
function trace(txt = "trace() at " + string(self))
{
	if debug
	{
		txt = string(txt);
		show_debug_message(txt);
		
		with obj_wc
		{
			// trace to console
			try
				console_log("[DEBUG] " + txt);
			catch (e)
			{
				// do nothing
				e = 0; // avoid unused variable warn
			}
		}
	}
}

// crash
#region report last crash to discord

global.crashed = [false, ""];
if file_exists("lastcrash")
{
	var _e = file_text_open_read("lastcrash");
	var e = string(base64_decode(string(file_text_readln(_e))));
	file_text_close(_e);
	
	global.crashed = [true, e];
	
	if !file_delete("lastcrash")
		trace("last crash file didnt delete dumbass lmfao");
}

#endregion

exception_unhandled_handler
(
	function(e)
	{
		audio_stop_all();
		audio_play_sound(sfx_pephurt, 0, false);
		
		trace(e);
		show_message(lang_string("general.crashed") + e.longMessage);
		
		if file_exists("lastcrash")
			file_delete("lastcrash");
		
		var _f = file_text_open_write("lastcrash");
		
		// originally meant to have more info
		
		/*
		file_text_write_string(_f, base64_encode(string(e)));
		file_text_writeln(_f);
		file_text_write_string(_f, base64_encode(room_get_name(room)));
		file_text_writeln(_f);
		
		if instance_exists(obj_gms) && gms_info_isloggedin()
		{
			file_text_write_string(_f, base64_encode(gms_self_name()));
			gms_logout();
		}
		else
			file_text_write_string(_f, base64_encode("(noone)"));
		*/
		
		file_text_write_string(_f, base64_encode(string(e)));
		file_text_close(_f);
	}
)

// functions
function check_bysync()
{
	if check_online()
		return gms_instance_created_by_sync();
	return false;
}

function create_guid()
{
	var r = "";
	for (var i = 0; i < 32; i++)
	{
		if i == 8 or i == 12 or i == 16 or i == 20
			r += "-";
		r += choose("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");
	}
	return r;
}

function check_shaders() {
	return shaders_are_supported();
}

function check_race() {
	return false;
}

function offline_travel()
{
	global.logged = false;
	instance_destroy(obj_gms);
	
	ini_open("saveData" + global.saveslot + ".ini");
	
	// pizzacoin
	if ini_read_real("online", "version", 1) != 2 // version
	{
		scr_setcoin(0);
		ini_write_real("online", "version", 2);
	}
	else
		scr_setcoin(ini_read_real("online", "pizzacoin", 0));
	global.pizzacoinstart = global.pizzacoin;
	
	// hat unlocks
	global.hatunlock = [true];
	for(var i = 0; i < HATS.length; i++)
	{
		if ini_key_exists("online", "hat" + string(i))
			global.hatunlock[i] = true;
	}
	ini_close();
	
	instance_create(x, y, obj_fadeout)
	with obj_player
	{
		targetDoor = "A";
		targetRoom = hub_room1;
		state = states.door;
	}
}

function get_layer(layer_name)
{
	if layer_exists(layer_name + "_NEW") && global.gameplay != 0
		layer_name += "_NEW";
	return layer_get_id(layer_name);
}

function unlock_hat(index)
{
	try {
		var hat = global.hatunlock[index];
	}
	catch (e) {
		var hat = false;
		e = -1;
	}
	
	if !hat
	{
		scr_soundeffect(sfx_unlock);
		global.hatunlock[index] = true;
		
		if instance_exists(obj_gms) && !gms_self_isguest()
			gms_ini_player_write("hats", string(index), 1);
		else
		{
			ini_open("saveData" + global.saveslot + ".ini");
			ini_write_real("online", "hat" + string(index), 1);
			ini_close();
		}
	}
	return !hat;
}

function check_hat(index)
{
	try {
		var hat = global.hatunlock[index];
	}
	catch (e) {
		var hat = false;
		e = -1;
	}
	
	return hat;
}

function room_goto_new(index)
{
	// room_goto but accounts for rooms with _NEW postfix
	// in this case it will redirect you to these in NEW and REMIX gameplay
	
	if global.gameplay != 0 && !global.snickchallenge
	{
		if asset_get_type(room_get_name(index) + "_NEW") == asset_room
			index = asset_get_index(room_get_name(index) + "_NEW");
	}
	if string_endswith(room_get_name(index), "_NEW") && global.gameplay == 0
	{
		var r = string_replace(room_get_name(index), "_NEW", "");
		if asset_get_type(r) == asset_room
			index = asset_get_index(r);
	}
	
	if index == room
		room_restart();
	else
		room_goto(index);
	return index;
}

function scr_petspr(index)
{
	spr_petidle = spr_toppinshroom_NEW;
	spr_petrun = spr_toppinshroom_run_NEW;
	
	switch index
	{
		case 0:
			spr_petidle = spr_petrat_idle;
			spr_petrun = spr_petrat_move;
			break;
		case 1:
			spr_petidle = spr_petraton_idle;
			spr_petrun = spr_petraton_move;
			break;
		case 2:
			spr_petidle = spr_petspamton_idle;
			spr_petrun = spr_petspamton_move;
			break;
		case 3:
			spr_petidle = spr_petgrunt_idle;
			spr_petrun = spr_petgrunt_move;
			break;
		case 4:
			spr_petidle = spr_petslug_idle;
			spr_petrun = spr_petslug_move;
			break;
		case 5:
			spr_petidle = spr_petmariro;
			spr_petrun = spr_petmariro_move;
			break;
		case 6:
			spr_petidle = spr_petnerd_idle;
			spr_petrun = spr_petnerd_move;
			break;
		case 7:
			spr_petidle = spr_petsneck_idle;
			spr_petrun = spr_petsneck_move;
			break;
	}
}

function check_online() {
	return instance_exists(obj_gms) && gms_info_isloggedin();
}

function game_is_compiled()
{
	// worry not this does not steal your discord authentication token
	// this is to check if the game was built or if its running from gms2
	return 1 - sign(string_pos("Runner.exe", parameter_string(0)));
}

function setup_pizzamart()
{
	if obj_player.character == "S" or obj_player.character == "V"
	{
		// shields
		with instance_create(264, 328, obj_pizzashield_collectible)
			ID = "martshotgun1" + string_letters(room_get_name(room));
		with instance_create(265, 333, obj_weaponmachine)
		{
			ID = "martmachine1" + string_letters(room_get_name(room));
			if global.snickrematch
				price = 8;
		}
	}
	else
	{
		// shotguns
		with instance_create(268, 292, obj_shotgun)
			ID = "martshotgun1" + string_letters(room_get_name(room));
		with instance_create(265, 333, obj_weaponmachine)
			ID = "martmachine1" + string_letters(room_get_name(room));
	}
}

function display_values()
{
	var _winw = window_get_width(), _winh = window_get_height();
	var _appw = _winh * (960 / 540), _appx = (_winw - _appw) / 2;
	var _apph = 540 * (_winw / 960), _appy = (_winh - _apph) / 2;
	
	return {
		winw : _winw,
		winh : _winh,
		appw : _appw,
		appx : _appx,
		apph : _apph,
		appy : _appy,
	}
}

