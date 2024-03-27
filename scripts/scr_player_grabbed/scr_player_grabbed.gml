function scr_player_grabbed()
{
	var player = -1;
	with obj_otherplayer
		if player_id == other.grabbedby
			player = id;
	
	if !instance_exists(player)
	{
		if noisebombcooldown <= 0
		{
			hurted = true;
			alarm[7] = 120;
		
			state = states.jump;
			sprite_index = spr_machfreefall;
		}
	}
	else
		noisebombcooldown = 10;
	
	xscale = -player.xscale

	/*
	if player.state = states.mach3 && fightball = true
	{
		x = obj_player1.x
		y = obj_player1.y
	}
	*/

	if player.state = states.grabbing or player.state = states.grab or player.state = states._throw or player.state = states.slam or player.state = states.tacklecharge
	{
		x = player.x 
		if !string_contains(sprite_get_name(player.sprite_index), "_haulingstart") 
		{
			y = player.y - 40
		}
		else
		if floor(player.image_index) = 0
		{
			y = player.y 
		}
		else
		if floor(player.image_index) = 1
		{
			y = player.y  -10
		}
		else
		if floor(player.image_index) = 2
		{
			y = player.y -20
		}
		else
		if floor(player.image_index) = 3
		{
			y = player.y -30
		}
		xscale = -player.xscale
	}
	with (player)
	{
		if !((state = states.grab) or (state == states.mach3 && fightball = true) or (state == states.finishingblow) or (state == states.grabbing) or (state == states._throw) or (state == states.slam) or (state == states.tacklecharge) or (state == states.punch) or (state == states.superslam) or (state == states.backkick) or (state == states.uppunch) or (state == states.shoulder))
		&& !string_contains(sprite_get_name(sprite_index), "_haulingstart") or pause
		{
			other.x = x 
			other.y = y 
			other.state = states.hurt
			other.alarm[8] = 60
			other.alarm[7] = 120
			other.image_index = 0
		}
	}



	if player.state = states.tacklecharge
	{
		x = player.x + (player.xscale * 20)
		y = player.y	
	}


	if player.state = states.finishingblow && player.image_index < 5
	{
		x = player.x + (player.xscale * 60)
		y = player.y
	}

	if place_meeting(x,y,obj_swordhitbox)
	{
		scr_soundeffect(sfx_killingblow)
		scr_hurtplayer_weak(id, false);
		
		with player
		{
			if string_contains(sprite_get_name(sprite_index), "_uppercut")
			{
				other.movespeed = 0
				other.vsp = -25
			}
			else
			{
				other.movespeed = 15
				other.vsp = -6
			}
		}
	}
	
	if (player.state = states.superslam && string_contains(sprite_get_name(player.sprite_index), "_piledriver") && !string_contains(sprite_get_name(player.sprite_index), "_piledriverland"))
	{
		if string_startswith(sprite_get_name(player.sprite_index), "spr_player_")
		{
			if floor(player.image_index) = 0
			{
				//depth = 0
				x = player.x + (player.xscale * 10)
				y = player.y
			}
			if floor(player.image_index) = 1
			{
				//depth = 0
				x = player.x + (player.xscale * 5)
				y = player.y
			}
			if floor(player.image_index) = 2
			{
				//depth = 0
				x = player.x 
				y = player.y
			}
			if floor(player.image_index) = 3
			{
				//depth = 0
				x = player.x + (player.xscale * -5)
				y = player.y
			}
			if floor(player.image_index) = 4
			{
				//depth = 0
				x = player.x + (player.xscale * -10)
				y = player.y
			}
			if floor(player.image_index) = 5
			{
				//depth = -8
				x = player.x + (player.xscale * -5)
				y = player.y
			}
			if floor(player.image_index) = 6
			{
				//depth = -8
				x = player.x 
				y = player.y
			}
			if floor(player.image_index) = 7
			{
				//depth = -8
				x = player.x + (player.xscale * 5)
				y = player.y
			}
		}
		else
		{
			x = player.x 
			y = player.y - 40
		}
	}





	if (player.state = states.grab && string_contains(sprite_get_name(player.sprite_index), "_swingding"))
	{
		if floor(player.image_index) = 0
		{
			//depth = -8
			x = player.x + (player.xscale * 25)
			y = player.y
		}
		if floor(player.image_index) = 1
		{
		//	depth = -8
			x = player.x 
			y = player.y
		}
		if floor(player.image_index) = 2
		{
		//	depth = -8
			x = player.x + (player.xscale * -25)
			y = player.y
		}
		if floor(player.image_index) = 3
		{
		//	depth = 0
			x = player.x + (player.xscale * -50)
			y = player.y
		}
		if floor(player.image_index) = 4
		{
			//depth = 0
			x = player.x + (player.xscale * -25)
			y = player.y
		}
		if floor(player.image_index) = 5
		{
		//	depth = 0
			x = player.x 
			y = player.y
		}
		if floor(player.image_index) = 6
		{
		//	depth = 0
			x = player.x + (player.xscale * 25)
			y = player.y
		}
		if floor(player.image_index) = 7
		{
		//	depth = 0
			x = player.x + (player.xscale * 50)
			y = player.y
		}
	}

	if string_contains(sprite_get_name(player.sprite_index), "_piledriverland")
	&& floor(player.image_index) < player.image_number-1
	{
		with obj_camera
		{
			if shake_mag <= 0
			{
				shake_mag=3;
				shake_mag_acc=3/room_speed;
			}
		}
	}

	if (string_contains(sprite_get_name(player.sprite_index), "_piledriverland") && floor(player.image_index) >= player.image_number-2)
	or player.state == states.jump
	{
		thrown = true
		instance_create(x,y,obj_slapstar)
		instance_create(x,y,obj_baddiegibs)
		flash = true

		x = player.x
		y = player.y
		state = states.hurt
		hsp = -xscale * 10
		vsp = -10
		alarm[8] = 60
		alarm[7] = 120
	}

	if player.state != states.mach3
		sprite_index = spr_hurt
	else
	{
		sprite_index = spr_fightball
		image_index = player.image_index
	}
	
	// get out
	move = key_left + key_right;
	if move != 0 && move != lastmove && swingdingbuffer < 500
	{
		lastmove = move;
		swingdingbuffer += 50;
		shake = 5;
	}
	if swingdingbuffer > 0
		swingdingbuffer -= 1
	
	if swingdingbuffer >= 500
	{
		hurted = true;
		alarm[7] = 120;
		
		scr_soundeffect(sfx_jump);
		
		state = states.jump;
		jumpstop = true;
		vsp = -8;
		sprite_index = spr_jump;
		
		flash = true;
		gms_p2p_send(p2p.pvp_stopgrab, grabbedby);
	}

	image_speed = 0.4
}