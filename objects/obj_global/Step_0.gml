// anti cheat
if global.saveslot == "" && !instance_exists(obj_gms) && room != characterselect
	global.saveslot = "1";

if onlinemode != global.onlinemode && !debug
{
	onlinemode = global.onlinemode;
	if room != Realtitlescreen && room != characterselect
		room_goto(room_of_dog);
}

// hub outside barrier
if !global.timeattack && global.modifier == -1
{
	if instance_exists(tabarrier)
		instance_deactivate_object(tabarrier);
}
else
{
	instance_activate_object(tabarrier);
	if instance_exists(tabarrier)
	{
		with obj_player while place_meeting(x, y, other.tabarrier)
			x++;
	}
}

// modifier shit
if global.modifier == mods.no_toppings
	global.failedmod = (global.toppings > 0);
else
	toppingsprite = -1;

if global.modifier == -1
	global.failedmod = false;

// switch fullscreen
if global.option_fullscreen && !window_get_fullscreen()
{
	switch global.option_resolution
	{
		case 0: window_set_size( 480, 270 ); break;
		case 1: window_set_size( 960, 540 ); break;
		case 2: window_set_size( 1920, 1080 ); break;
	}
}
global.option_fullscreen = window_get_fullscreen();

