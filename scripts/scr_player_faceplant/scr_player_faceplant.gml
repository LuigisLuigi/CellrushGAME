function scr_player_faceplant()
{
	hsp = xscale * movespeed 
	move = key_right + key_left
	
	if scr_stylecheck(0)
	{
		if movespeed < 10 && grounded
			movespeed += 0.5
		else if !grounded
			movespeed = 10;
	}
	else
	{
		momentum = true;
		if movespeed < 12 && character != "SP"
			movespeed += 0.5;
		
		if key_slap2
			input_buffer_faceplant = 0;
	}
	
	//Bump
	if scr_solid(x + hsp, y) && !place_meeting(x + hsp, y, obj_slope) && !place_meeting(x + hsp, y, obj_destructibles)
	{
		audio_stop_sound(sfx_Nspin)

		sprite_index = spr_hitwall
		scr_soundeffect(sfx_groundpound)
		scr_soundeffect(sfx_bumpwall)
		
		with obj_camera
		{
			shake_mag = 20;
			shake_mag_acc = 40 / room_speed;
		}
		
		hsp = 0
		image_speed = 0.35

		with obj_baddie
		{
			if point_in_camera(x, y, view_camera[0])
			{
				stun = true
				alarm[0] = 200
				ministun = false
				vsp = -5
				hsp = 0
			}
		}
		flash = false

		state = states.bump
		hsp = -2.5
		vsp = -3
		mach2 = 0
		image_index = 0
		instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
	}
	
	if floor(image_index) >= image_number - 1 && input_buffer_faceplant >= 8
	{
		image_speed = 0.35
		if !scr_stylecheck(0) && character != "SP"
		{
			if movespeed < 12
				movespeed = 12;
		}
		if key_attack && (character != "N" or noisetype == 1)
			state = states.mach2;
		else
			state = states.normal;
		grav = basegrav;
	}
	
	if key_down && grounded && vsp > 0
	{
		grav = basegrav;
		sprite_index = spr_crouchslip;
		machhitAnim = 0;
		state = states.crouchslide;
		movespeed = 15;
	}
	image_speed = 0.5
	
	//Effects
	if !instance_exists(obj_dashcloud2) && grounded && movespeed > 5
	with instance_create(x, y, obj_dashcloud2)
		image_xscale = other.xscale
}
