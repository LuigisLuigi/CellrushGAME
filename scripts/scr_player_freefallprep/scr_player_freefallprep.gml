function scr_player_freefallprep()
{
	move = key_left + key_right;
	if !grounded
	{
		hsp = move * movespeed;
		if move != xscale && momentum && movespeed != 0 
			movespeed -= 0.05
		
		if movespeed == 0
			momentum = false

		if move == 0 && !momentum or scr_solid(x + hsp, y)
		{
			movespeed = 0
			mach2 = 0
		}
		if move != 0 && movespeed < 7
			movespeed += 0.25
		if movespeed > 7 
			movespeed -= 0.05

		if scr_solid(x + move, y)
			movespeed = 0

		//Turn
		if dir != xscale 
		{
			mach2 = 0
			dir = xscale
			movespeed = 0 
		}
		if move == -xscale
		{
			mach2 = 0
			movespeed = 0 
			momentum = false
		}
		if move != 0
			xscale = move
		if vsp > 0 && global.gameplay != 0
            vsp = 0
	}
	
	//Animations
	image_speed = 0.5
	
	if floor(image_index) >= image_number - 1 
	{
		if global.gameplay == 0
			vsp += 14
		state = states.freefall
		if !shotgunAnim
			sprite_index = spr_bodyslamfall
		else
			sprite_index = spr_shotgunjump3
	}
}

