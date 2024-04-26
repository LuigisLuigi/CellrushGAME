// logged out message
if instance_exists(obj_gms)
{
	instance_destroy(obj_gms);
	with obj_roomname
	{
		message = lang_string("online.loggedout");
		global.roommessage = message;
		showtext = true;
		alarm[0] = 200;
	}
}
if variable_global_exists("logged")
	global.logged = false;

// sertif being a dumbass
global.optimize = 0;
global.autotile = true;
global.loadeditor = false;
global.jukebox = -1;

// clear excess players
while instance_number(obj_player) > 1
	instance_destroy(instance_find(obj_player, instance_number(obj_player) - 1));

// reset player properly
with obj_player
{
	global.modifier = -1;
	global.hatunlock = [true];
	
	scr_playerreset();
	state = states.titlescreen;
	targetDoor = "A";
	character = "P";
	
	paletteselect = check_shaders();
	
	petfollow = -1;
	hatsprite = -1;
	noisetype = (global.gameplay == 0 ? 0 : 1);
	x = 480;
	y = 402;
	scr_characterspr();
}
/*
with obj_shell
	WC_debug = false;
global.panic = false;
global.snickchallenge = false;
global.snickrematch = false;
*/
room_speed = 60;
if !instance_exists(obj_fadein)
	instance_create(0, 0, obj_fadein);

