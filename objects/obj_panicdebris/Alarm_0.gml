if global.panic && (!instance_exists(obj_secretfound) or global.gameplay == 0)
{
	var xx = 0, w = room_width, yy = 0;
	if room == custom_lvl_room
	{
		xx = _camx;
		yy = _camy;
		w = _camw;
		
		with obj_camera
		{
			if bound_camera && instance_exists(player)
			{
				xx = player.cam.x;
				yy = player.cam.y;
				w = player.cam_width;
			}
		}
	}
	
	repeat min(round(w / 960), 8)
	{
		array_push(debris, {
			x : irandom_range(xx, w),
			y : yy + 10,
			ang : irandom_range(1, 360),
			img : irandom_range(0, 5),
			vsp : random_range(-4, 0),
			hsp : random_range(-4, 4),
		});
	}
	alarm[0] = 5;
}

