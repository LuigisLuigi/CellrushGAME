if room == rm_editor exit;

// fly towards player
if global.gameplay != 0
{
	var p = instance_nearest(x, y, obj_player);
	if p
	{
		if abs(distance_to_object(p) < 25 && !place_meeting(x, y, obj_destructibles) && !place_meeting(x, y, obj_iceblock))
		{
		    if !gotowardsplayer
		        scr_ghostcollectible()
		    gotowardsplayer = true
		}
		if gotowardsplayer
		{
		    move_towards_point(p.x, p.y, movespeed)
		    movespeed++
		}
	}
}

// collect
player = instance_place(x, y, obj_player);
if player && player.state != states.gameover && player.state != states.hitlag
	event_user(0);
if place_meeting(x, y, obj_antonball)
	event_user(0);
