function scr_player_ladder()
{
	jumpAnim = true
	dashAnim = true
	landAnim = false
	moveAnim = true
	stopAnim = true
	crouchslideAnim = true
	crouchAnim = false
	machhitAnim = false
	turning = false
	jumpstop = false
	suplexmove = false
	movespeed = 0
	hsp = 0
	
	var upspd = (global.gameplay == 0 ? -2 : -6);
	var downspd = (global.gameplay == 0 ? 6 : 10);
	if key_up && !(place_meeting(x, y, obj_hookup) && !place_meeting(x, y + upspd, obj_hookup))
	{
		sprite_index = spr_laddermove
		vsp = upspd
		image_speed = 0.35
	}
	else if key_down
	{
		sprite_index = spr_ladderdown
		vsp = downspd
		image_speed = 0.35
	}
	else
	{
		sprite_index = spr_Ladder
		vsp = 0
	}
	
	if x != doorx && doorx != 0
	{
		if scr_stylecheck(2)
			x = Approach(x, doorx, 3);
		else
			x = doorx;
	}
	else
		doorx = 0;
	
	mach2 = 0
	jumpAnim = true
	dashAnim = true
	landAnim = false
	moveAnim = true
	stopAnim = true
	crouchslideAnim = true
	crouchAnim = true
	machhitAnim = false
	
	//Fall off
	var xx = (doorx == 0 ? x : doorx);
	if !place_meeting(xx, y + vsp, obj_ladder) && ladderbuffer <= 0
	{
		landAnim = false
		jumpAnim = false
		state = states.normal
		image_index = 0
		
		if !scr_solid_player(x, y + vsp)
			y += vsp;
		
		if vsp <= 0 && place_meeting(x, y - vsp, obj_ladder) && !hooked
		{
			for(var i = 0; i < 32; i++)
			{
				if scr_solid_player(x, y + i + 1)
				{
					y += i;
					grounded = true;
					break;
				}
			}
		}
		
		vsp = 0;
		hooked = false;
	}
	
	if key_jump or (input_buffer_jump < 8 && key_jump2)
	{
		input_buffer_jump = 8;
		
		hooked = false;
		sprite_index = spr_jump
		ladderbuffer = 20
		jumpAnim = true
		state = states.jump
		if key_down && global.gameplay != 0
            vsp = 5
        else
            vsp = -9
		image_index = 0
	}
	if key_down && grounded && !place_meeting(x, y, obj_platform) 
	{
		hooked = false;
		state = states.normal
		image_index = 0
	}
}
