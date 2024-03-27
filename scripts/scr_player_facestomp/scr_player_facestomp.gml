function scr_player_facestomp() {
	move = key_left + key_right;
	jumpAnim = false
	hsp = move * movespeed;
	if (scr_solid(x+1,y) && xscale == 1) or (scr_solid(x-1,y) && xscale == -1)
	{
	movespeed = 0
	}

	if move = 0
	movespeed = 0

	if move != 0 && movespeed < 6
	movespeed += 0.5


	//Turn

	if  (xscale == 1 && move == -1) 
	{
	movespeed =0

	}

	if  (xscale == -1 && move == 1)  
	{

	movespeed = 0

	}

	   //Back to Jump
	   if !key_down 
	   {

	   state = states.jump
	}

	landAnim = true

	//Freefall
	if vsp > 0
	superslam ++
	else
	superslam = 0

	if vsp > 15
	{
	state = states.freefall
	superslam = 0
	}



	///Back to other states
		//Freefall Land
		if grounded && (!place_meeting(x,y+1,obj_destructibles) or place_meeting(x,y+1,obj_metalblock)) && vsp > 0
		{
	//	scr_sound(sfx_facestomp)
		state = states.freefallland
		jumpAnim = true
		jumpstop = false
		image_index = 0
	//	if !place_meeting(x,y,obj_water2)
		instance_create(x,y,obj_landcloud)
		freefallstart = 0
	//	audio_sound_gain(sfx_land, 0.7, 0);
	//if !(audio_is_playing(sfx_land))
	//audio_play_sound(sfx_land, 1, false)
		}

	


	//Animations
	if facestompAnim = false
	sprite_index = spr_player_facestomp
	else if
	facestompAnim = true
	{
	sprite_index = spr_player_facestomphit
	if floor(image_index) = 5
	facestompAnim = false
	}

	if move != 0
	xscale = move

	image_speed = 0.35

		//Input jumping

	if (grounded && (input_buffer_jump < 8) && vsp > 0) 
	{

	sprite_index = spr_player_hanstandjump
	stompAnim = false
	hsp = 0
	state = states.handstandjump
	jumpAnim = true
	jumpstop = false
	image_index = 0
	//if !place_meeting(x,y,obj_water2)
	instance_create(x,y,obj_landcloud)
	freefallstart = 0

	}
	
	//Input buffer jumping
	if key_jump
	input_buffer_jump = 0




}
