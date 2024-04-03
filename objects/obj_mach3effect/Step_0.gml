if !sync && instance_exists(playerid)
{
	if visible
		visible = playerid.visible;
	
	if (playerid.state == states.mach2 or playerid.state == states.mach1 or playerid.state == states.mach3)
	&& !sugary
    {
        var p = 4
        var m = playerid.movespeed - p
        var t = 12 - p
        image_alpha = clamp(m / t, 0, 1)
    }
	
	with playerid
    {
        if place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart)
            other.visible = false
    }
	depth = playerid.depth + 1;
}
