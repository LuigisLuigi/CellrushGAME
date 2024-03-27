function scr_player_crouchjump()
{
	move = key_left + key_right;
	
	//Falling Animation
	mask_index = spr_crouchmask
	hsp = move * movespeed;


	//Movespeed
	movespeed = 4
	
	//Jump Stop
	if !key_jump2 && !jumpstop && jumpAnim
	{
		vsp /= 2
		jumpstop = true
	}

	//Hit head
	if scr_solid_player(x, y - 1) && vsp < 0 && !jumpstop && jumpAnim
	{
		vsp = grav
		jumpstop = true
	}
	
	///Back to other states
	//Crouch
	if grounded 
	{
		if key_down
			state = states.crouch
		else
		{
			state = states.normal
			landAnim = true
		}
			
		instance_create(x,y,obj_landcloud)
		sprite_index = spr_crouch
		jumpAnim = true
		crouchAnim = true
		image_index = 0
		jumpstop = false
		scr_soundeffect(sfx_step)
	}
	
	//Animations
	if jumpAnim
	{
		if !shotgunAnim or character == "SP"
			sprite_index = spr_crouchjump
		else
		{
			if character == "P"
				sprite_index = spr_shotgun_crouchjump1;
			else
				sprite_index = spr_crouchjump
		}
		
		if floor(image_index) = image_number - 1
			jumpAnim = false
	}
	else
	{
		if !shotgunAnim or character == "SP"
			sprite_index = spr_crouchfall
		else
		{
			if character == "P"
				sprite_index = spr_shotgun_crouchjump2;
			else
				sprite_index = spr_crouchfall;
		}
	}
	
	if move != 0
		xscale = move

	image_speed = 0.35
}