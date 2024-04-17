hsp = 0
vsp = 0
image_speed = 0.35
object = instance_nearest(x, y, obj_warppoint)
player = obj_player1
storedstate = states.normal
storedmovespeed = 6
storedgrav = 0.5
storedimageindex = 0
storedspriteindex = spr_player_idle

if global.gameplay != 0
	vsp = 5;
rebound = false;

