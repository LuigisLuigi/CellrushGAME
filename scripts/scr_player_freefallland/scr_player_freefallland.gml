function scr_player_freefallland()
{
	mach2 = 0
	jumpAnim = true
	dashAnim = true
	landAnim = false
	moveAnim = true
	stopAnim = true
	crouchslideAnim = true
	crouchAnim = false
	machhitAnim = false
	movespeed = 0
	
	facehurt = true
	start_running = true
	alarm[4] = 14
	vsp = 0
	hsp = 0
	
	if global.gameplay == 0
	{
		if floor(image_index) >= image_number - 1
		{
			sprite_index = spr_facehurtup
		    image_index = 0
			state = states.normal
		}
	}
	else
	{
		var img = 3;
		if character == "N" or character == "S"
			img = 2;
		
		if floor(image_index) >= img
		{
			if key_jump2 && scr_stylecheck(2)
			{
				state = states.jump
				vsp = -14;
				jumpstop = true;
				
				image_index = 0;
				if character == "P"
					sprite_index = spr_player_groundpoundjump;
				else if character == "S"
					sprite_index = spr_jump;
				else
					sprite_index = spr_machfreefall;
			}
			else
			{
		        sprite_index = spr_facehurtup
		        image_index = 0
		        state = states.normal
			}
		}
	}
	
	image_speed = 0.35
}