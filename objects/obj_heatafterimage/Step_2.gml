if room == rank_room
	visible = false;

var hsp = 0, vsp = 0;
if instance_exists(obj_player1)
{
	mask_index = obj_player1.mask_index
	if (place_meeting(x, (y + 1), obj_slope) && scr_solid(x, (y + 1)))
	    y = obj_player1.y
	
	hsp = obj_player1.hsp;
	vsp = obj_player1.vsp - 1;
	
	if obj_player1.x == obj_player1.xprevious
		hsp = 0;
	if obj_player1.y == obj_player1.yprevious
		vsp = 0;
	
	if is_visible
	{
	    visible = obj_player1.visible
	    if place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart)
	        visible = false
	}
}

x += Vspeed + hsp;
y += Hspeed + vsp - 1;

visible = false
if !visible && surface_exists(surf)
	surface_free(surf);
