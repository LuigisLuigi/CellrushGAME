/// @description Move the object and check for collisions with walls and solids
function scr_collide()
{
	__scr_collide = true;
	grounded = false;
	
	// Vertical
	repeat(abs(vsp))
	{
		if !scr_solid(x, y + sign(vsp))
			y += sign(vsp); 
		else
		{
			vsp = 0;
			break;
		}
	}

	// Horizontal
	repeat(abs(hsp)) 
	{
		// Move up slope
		if scr_solid(x + sign(hsp), y) && !scr_solid(x + sign(hsp), y - 1)
			y--
	
		// Move down slope
		if !scr_solid(x + sign(hsp), y) && !scr_solid(x + sign(hsp), y + 1) && scr_solid(x + sign(hsp), y + 2)
			y++;

		if !scr_solid(x + sign(hsp), y)
			x += sign(hsp); 
		else
		{
			hsp = 0;
			break;
		}
	}

	// Check if a wall is below me
	grounded |= scr_solid(x, y + 1)
	// Check if I'm on a platform
	grounded |= !place_meeting(x, y, obj_platform) && place_meeting(x, y + 1, obj_platform)
	
	//Gravity
	vsp = min(vsp + grav, 10);
	
	__scr_collide = true;
}

