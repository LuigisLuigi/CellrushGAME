function scr_player_uppunch() {

	move = key_left + key_right;


	if grounded
	{
		//Turn

		if dir != xscale
		{
		dir = xscale
		movespeed = 2 
		facehurt = false

		}


	jumpstop = false


		anger = 100
		var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then railh = railmeet.spdh;
		hsp = move * movespeed + railh;


		//Movespeed

		if move != 0 
		{
		if movespeed < 7
		{
		movespeed += 0.5
		}
		else if floor(movespeed)= 7 
		{
		movespeed = 7
		}
		}
		else
		movespeed = 0

		if movespeed > 7
		movespeed -= 0.1


	
		if move != 0
	{

	if movespeed < 3 && move != 0
	image_speed = 0.35
	else if movespeed > 3 && movespeed < 6 
	image_speed = 0.45
	else
	image_speed = 0.60
	}
	else 
	image_speed = 0.35
	
	}


	if !grounded
	{

		if momentum = false
		hsp = move * movespeed;
		else
		hsp = xscale * movespeed

		if move != xscale && momentum = true && movespeed != 0 
		{
		movespeed -= 0.05
		}

		if movespeed = 0
		momentum = false

		if (move = 0 && momentum = false) or scr_solid(x+(hsp),y)
		{
		movespeed = 0
		mach2 = 0
		}
		if move != 0 && movespeed < 7
		movespeed += 0.25
		if movespeed > 7 
		movespeed -= 0.05

		if ((scr_solid(x+1,y) && move == 1) or (scr_solid(x-1,y) && move == -1))
		{
		movespeed = 0
		}

		//Turn

		if dir != xscale 
		{
		mach2 = 0
		dir = xscale
		movespeed = 0 
		}
		if move = -xscale
		{
		mach2 = 0
		movespeed = 0 
		momentum = false
		}

		landAnim = true


		//Jump Stop
		if (!key_jump2) && jumpstop = false && vsp < 0.5 && stompAnim =false
		{
		vsp /= 5
		jumpstop = true
		}

		//Ladder Buffer
		if ladderbuffer > 0
		ladderbuffer --

		//Hit head
		if scr_solid(x,y-1) && jumpstop = false && jumpAnim = true
		{
		vsp = grav
		jumpstop = true
		}
	

	
	
	
	}
	jumpAnim = true
	dashAnim = true
	landAnim = false

	moveAnim = true
	stopAnim = true
	crouchslideAnim = true
	crouchAnim = true

	if floor(image_index) = image_number -1 or move = -xscale
	{
	state = states.normal
	}

	//Animations
	sprite_index = spr_uppunch
	image_speed = 0.35


}
