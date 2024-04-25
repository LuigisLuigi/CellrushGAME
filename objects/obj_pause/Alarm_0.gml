/// @description restart (levels are in step)
with all
	if !persistent instance_destroy(id, false);

var timeattack = global.timeattack;
var snickrematch = global.snickrematch;

global.pizzacoin = global.pizzacoinstart;

audio_resume_all();
if !audio_is_playing(global.jukebox)
	audio_stop_all();
instance_activate_all();
global.music = -1;

// player reset shit
pause = 0;
scr_playerreset();
with obj_player
	targetDoor = "A";

global.snickrematch = snickrematch; // stored

// modifier
global.failedmod = false;
if global.modifier != -1
{
	with obj_drpc_updater
		event_user(3);
}

// go to da levels
if gotoroom != -1
	room_goto_new(gotoroom);

/*
// reset time attack
global.timeattack = timeattack;
with obj_timeattack
	alarm[1] = 60;
*/

// create nice fadeout instead of just a cut into the level
with instance_create(0, 0, obj_fadeout)
{
	fadealpha = 1;
	fadein = true;
}
