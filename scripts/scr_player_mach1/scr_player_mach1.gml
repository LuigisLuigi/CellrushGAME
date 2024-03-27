function scr_player_mach1()
{
	if character != "S"
	{
		mask_index = spr_player_mask;
		if scr_solid(x, y)
		{
			state = states.crouch;
			mask_index = spr_crouchmask;
			exit;
		}
	}
	
	dir = xscale
	move = key_left + key_right;

	landAnim = false
	if scr_solid(x + xscale, y) && (!place_meeting(x + xscale, y, obj_slope) or scr_solidwall(x, y - 1) or scr_solid_slope(x + xscale, y))
	{
		mach2 = 0 
		state = states.normal
		movespeed = 0
	}
	
	machhitAnim = false
	crouchslideAnim = true

	var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then railh = railmeet.spdh;
	hsp = xscale * movespeed + railh;
	
	//Turn
	if xscale == -move
	{
		sprite_index = spr_mach1
		momentum = false
		mach2 = 0
		movespeed = 6
		image_index = 0
		xscale = move
	}
	
	//Mach2
	if grounded
	{
		if movespeed < 8
			movespeed += 0.075
		else
		{
			state = states.mach2
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
		}
	}

	//Fall off
	if !grounded && sprite_index != spr_airdash1 
		sprite_index = spr_airdash2
	if sprite_index == spr_airdash1 && floor(image_index) == image_number - 1
		sprite_index = spr_airdash2
	
	//Back to other states
	//Normal
	if (!key_attack && character != "S") or (character == "S" && move == 0)
	{
		state = states.normal
		image_index = 0
	}


	//Jump Stop
	if (!key_jump2) && jumpstop = false && vsp < 0.5 
	{
		vsp /= 10
		jumpstop = true
	}

	if grounded && vsp > 0
		jumpstop = false

	if scr_solid(x+xscale,y)  && !place_meeting(x+sign(hsp),y,obj_slope)
	{
		movespeed = 0
		state = states.normal	
	}


	image_speed = 0.5

	


	//Effects
	if !instance_exists(dashcloudid) && grounded
	with instance_create(x,y,obj_dashcloud)
	{
		image_xscale = other.xscale
		other.dashcloudid = id
	}

	if grounded && sprite_index != spr_mach1 && vsp > 0
	{
		sprite_index = spr_mach1
		image_index = 0
	}
	
	//Jump
	if key_jump && grounded 
	{
		scr_soundeffect(sfx_jump)
		sprite_index = spr_airdash1
		dir = xscale
		momentum = true
		vsp = -11
		
		jumpAnim = true
		image_index = 0
	}

	//Snick peelout
	if key_attack && !scr_solid(x + xscale, y) && character == "S" && grounded
	{
		state = states.handstandjump
		movespeed = 0
	}
		
	//Vigilante revolver
	if key_slap2 && character == "V"
	{
		vsp = -5
		state = states.revolver	
		image_index = 0
		sprite_index = spr_playerV_airrevolver
		image_index = 0
		with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
			shotgun = true
		scr_soundeffect(sfx_killingblow)
	}
	
	//Vigilante Dynamite
	if key_shoot2 && character == "V" && !instance_exists(obj_dynamite)
	{
		vsp = -5

		state = states.dynamite
		image_index = 0
		sprite_index = spr_playerV_dynamitethrow
		with instance_create(x,y,obj_dynamite)
		{
			image_xscale = other.xscale
			movespeed = other.movespeed + 4
			vsp = -6
		}
	}
	
	//Manual Freefall
	/*
	if key_down && !grounded
	{
		if !shotgunAnim
		{
			image_index = 0
			state = states.freefallprep
			sprite_index = spr_bodyslamstart
			vsp =-5
		}
		else
		{
			image_index = 0
			state = states.freefallprep
			sprite_index = spr_shotgunjump1
			vsp = -5
			
			with instance_create(x +xscale*30,y+60,obj_shotgunbullet)
			{
				sprite_index = sprite10391
				spdh = -10
				spd = 0
			}
			with instance_create(x +xscale*30,y+60,obj_shotgunbullet)
			{
				sprite_index = sprite10391
				spdh = -10
				spd = 5
			}
			with instance_create(x +xscale*30,y+60,obj_shotgunbullet)
			{
				sprite_index = sprite10391
				spdh = -10
				spd = -5
			}
		}
	}
	*/
	
	//Taunt
	if key_taunt2 
		scr_player_taunt();
}