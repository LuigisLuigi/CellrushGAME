if room == rm_editor exit;

// collect
var player = instance_place(x, y, obj_player);
if player && player.state != states.gameover && player.state != states.hitlag
{
	if player.character == "V" 
		global.playerhealth = clamp(global.playerhealth + 10, 0, 100);
	global.heattime = 60;
	
	event_user(0);
}
if place_meeting(x, y, obj_antonball)
	event_user(0);