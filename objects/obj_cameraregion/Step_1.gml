if place_meeting(x, y, obj_player)
{
	if !col
	{
		with obj_camera
		{
			if other.boundary_x
			{
				limitcam[0] = _camx;
				limitcam[2] = _camx + _camw;
			}
			if other.boundary_y
			{
				limitcam[1] = _camy;
				limitcam[3] = _camy + _camh;
			}
		}
	}
	col = true;
}
else if !permanent
	col = false;

