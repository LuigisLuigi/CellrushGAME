function scr_player_grab()
{
	if baddiegrabbedID == 0 or baddiegrabbedID == obj_null or !instance_exists(baddiegrabbedID)
	{
		state = states.normal;
		exit;
	}
	else with baddiegrabbedID
	{
		grabbed = true;
		state = states.grabbed;
		grabbedby = 1;
	}
	
	grav = basegrav
	move = key_left + key_right;
	
	if grounded
	{
		//Turn
		if dir != xscale && sprite_index != spr_swingding
		{
			dir = xscale
			if baddiegrabbedID.object_index != obj_pizzaballOLD
				movespeed = 2 
			
			facehurt = false
		}
		jumpstop = false
		anger = 100
		
		var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then railh = railmeet.spdh;
		
		if sprite_index != spr_swingding or global.gameplay == 0
			hsp = move * movespeed + railh;
		else
			hsp = xscale * movespeed + railh;

		//Movespeed
		if sprite_index != spr_swingding or global.gameplay == 0
		{
			if heavy == false
			{
				if move != 0
				{
					if movespeed < 6
						movespeed += 0.5
					else if floor(movespeed) == 6 
						movespeed = 6
				}
				else
					movespeed = 0

				if movespeed > 6
					movespeed -= 0.1
			}
			else
			{
				if move != 0
				{
					if movespeed < 4
						movespeed += 0.25
					else if floor(movespeed) == 4
						movespeed = 4
				}
				else
					movespeed = 0
				
				if movespeed > 4
					movespeed -= 0.1
			}
		}
		
		if sprite_index != spr_swingding
		{
			if baddiegrabbedID.object_index == obj_pizzaballOLD
				movespeed = 0;
			if move != 0
				xscale = move;
		}
	
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
	
	if sprite_index != spr_swingding or global.gameplay == 0
	{
		if !grounded
		{
			if dir != xscale && sprite_index != spr_swingding
			{
				dir = xscale

				if baddiegrabbedID.object_index != obj_pizzaballOLD
					movespeed = 2
				facehurt = false
			}
			
			if move != xscale && baddiegrabbedID.object_index != obj_pizzaballOLD
				movespeed = 2
			
			if !momentum
				hsp = move * movespeed;
			else
				hsp = xscale * movespeed

			if move != xscale && momentum && movespeed != 0 
				movespeed -= 0.05

			if movespeed = 0
				momentum = false

			if move != 0 && movespeed < 6
				movespeed += 0.5
			if movespeed > 6 
				movespeed -= 0.5

			if scr_solid(x + move, y)
				movespeed = 0
		}
		
		//Turn
		if dir != xscale && sprite_index != spr_swingding
		{
			dir = xscale
			if baddiegrabbedID.object_index != obj_pizzaballOLD
				movespeed = 2 
			facehurt = false
		}
		
		if move = -xscale
		{
			mach2 = 0
			momentum = false
		}

		landAnim = true
		
		//Jump Stop
		if !key_jump2 && !jumpstop && vsp < 0.5 && !stompAnim
		{
			vsp /= 10
			jumpstop = true
		}
		
		//Hit head
		if scr_solid(x, y - 1) && !jumpstop && jumpAnim
		{
			vsp = grav
			jumpstop = true
		}
		
		if sprite_index != spr_swingding
		{
			if baddiegrabbedID.object_index == obj_pizzaballOLD
				movespeed = 0;
			if move != 0
				xscale = move
		}
	}
	else
	{
		if scr_stylecheck(2)
		{
			hsp = xscale * movespeed;
		
			if scr_solid(x + xscale, y)
			&& (!place_meeting(x + sign(hsp), y, obj_slope) or scr_solid_slope(x + sign(hsp), y))
			&& !place_meeting(x + sign(hsp), y, obj_destructibles)
				xscale *= -1;
		
			if swingdingbuffer == 0 && !key_attack
				swingdingbuffer = -1;
			if swingdingbuffer == -1
				movespeed = Approach(movespeed, 0, 0.5);
		
			if movespeed == 0
				sprite_index = spr_haulingidle;
		}
		else
		{
			if grounded
	            movespeed = Approach(movespeed, 0, 0.25)
	        if movespeed <= 0
	            sprite_index = spr_haulingidle
	        swingdingendcooldown++
	        hsp = xscale * movespeed
			
	        if scr_solid(x + xscale, y) && (!place_meeting(x + sign(hsp), y, obj_slope) or scr_solid_slope(x + sign(hsp), y)) && !place_meeting(x + sign(hsp), y, obj_destructibles)
	        {
	            vsp = -4
	            sprite_index = spr_player_kungfujump
	            image_index = 0
	            state = states.punch
	            movespeed = -6
	        }
	        with instance_place(x + xscale, y, obj_destructibles)
	            instance_destroy()
		}
	}
	
	//Input buffer jumping
	if key_jump
		input_buffer_jump = 0

	//Input jumping
	if (grounded && input_buffer_jump < 8 && !key_down && !key_attack && vsp > 0) && sprite_index != spr_swingding
	{
		scr_soundeffect(sfx_jump)
		sprite_index = spr_haulingjump
		instance_create(x, y, obj_highjumpcloud2)
		if !heavy
			vsp = -11
		else
			vsp = -6
		image_index = 0
	}

	//Animations
	//Walk
	if grounded && move != 0 && sprite_index == spr_haulingidle && baddiegrabbedID.object_index != obj_pizzaballOLD
	{
		sprite_index = spr_haulingwalk
		image_index = 0
	}
	else if grounded && move == 0 && sprite_index == spr_haulingwalk
		sprite_index = spr_haulingidle
	
	if sprite_index == spr_haulingstart && floor(image_index) >= image_number - 1
		sprite_index = spr_haulingidle
	
	//Fall
	if (sprite_index == spr_haulingjump && floor(image_index) >= image_number - 1)
	or (!grounded && (sprite_index == spr_haulingwalk or sprite_index == spr_haulingidle))
		sprite_index = spr_haulingfall
	
	//Land
	if grounded && vsp > 0 && (sprite_index == spr_haulingfall or sprite_index == spr_haulingjump)
	{
		scr_soundeffect(sfx_step)
		instance_create(x, y, obj_landcloud)
		
		image_index = 0
		sprite_index = spr_haulingland
		if abs(hsp) > 0
			sprite_index = spr_haulingland2
		
		if global.gameplay == 0
			movespeed = 2
	}
	if spr_haulingland2 != spr_haulingland
	{
		if sprite_index == spr_haulingland2 && hsp == 0
			sprite_index = spr_haulingland;
		if sprite_index == spr_haulingland && abs(hsp) > 0
			sprite_index = spr_haulingland2;
	}
	
	if (sprite_index == spr_haulingland or sprite_index == spr_haulingland2) && floor(image_index) >= image_number - 1
		sprite_index = spr_haulingidle
	
	//Swing Ding
	if global.gameplay == 0
	{
		if move != 0 && move != lastmove && swingdingbuffer < 300
		{
			lastmove = move
			swingdingbuffer += 50
		}
		
		if swingdingbuffer > 0
			swingdingbuffer -= 1;
		
		if sprite_index == spr_swingding && swingdingbuffer < 150
			state = states.normal
		
		if swingdingbuffer > 300 && sprite_index != spr_swingding
		{
			sprite_index = spr_swingding
			with instance_create(x, y, obj_swingdinghitbox)
				playerid = other.object_index
			flash = true
		}
	}
	
	// tackle charge in remix
	if key_shoot2 && scr_stylecheck(2)
	{
		state = states.tacklecharge
		sprite_index = spr_charge
		scr_soundeffect(sfx_suplexdash)
	}
	
	if key_attack && sprite_index != spr_swingding
	{
		var did = true;
		if global.gameplay == 0
		{
			state = states.tacklecharge
			sprite_index = spr_charge
			scr_soundeffect(sfx_suplexdash)
		}
		else if scr_stylecheck(2)
		{
			if move != 0
				xscale = move
			swingdingbuffer = 0;
			sprite_index = spr_swingding;
			movespeed = 12;
			flash = true;
			instance_create(x, y, obj_swingdinghitbox);
			
			//Jump Stop
			if !key_jump2 && vsp < 0.5
				vsp /= 10;
		}
		else
			did = false;
		
		if did
		{
			if baddiegrabbedID.object_index == obj_pizzaballOLD
				global.golfhit += 1;
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
		}
	}
	
	if swingdingbuffer > 0 && global.gameplay != 0
	{
		swingdingbuffer--;
		if movespeed > 0
			movespeed -= 0.1;
	}
	
	//Throws
	if key_slap2 && (sprite_index != spr_swingding or swingdingendcooldown > 20 or scr_stylecheck(2))
	{
		if move != 0
			move = xscale
		
		state = states.finishingblow
		if sprite_index == spr_swingding
			sprite_index = spr_swingdingend
		else if !key_up
			sprite_index = choose(spr_finishingblow1, spr_finishingblow2, spr_finishingblow3, spr_finishingblow4, spr_finishingblow5)
		else if key_up
			sprite_index = spr_uppercutfinishingblow
		
		image_index = 0
		if global.gameplay == 0
		{
			hsp = 0
			movespeed = 0
		}
		else
			movespeed = hsp
	}
	
	if key_down && !grounded
	{
		if character == "SP"
		{
			if scr_stylecheck(0, 2)
				scr_soundeffect(sfx_jump);
			sprite_index = spr_piledriverstart;
		}
		else
			sprite_index = spr_piledriver;
		
		vsp = global.gameplay == 0 ? -6 : -5;
		state = states.superslam;
		image_index = 0;
		image_speed = 0.35;
	}
	
	//Crouch
	if key_down && grounded
	{
		state = states.crouch
		landAnim = false
		crouchAnim = true
		image_index = 0
		idle = 0
	}
	
	// Effects
	var step1 = 4;
	var step2 = 10;
	if character == "SP"
	{
		step1 = 2;
		step2 = 6;
	}
	
	if abs(hsp) > 0 && grounded && sprite_index == spr_haulingwalk && (floor(image_index) == step1 or floor(image_index) == step2)
	{
		if !steppy
			instance_create(x, y + 43, obj_cloudeffect);
		steppy = true;
	}
	else
		steppy = false;
	
	if sprite_index != spr_swingding
		image_speed = 0.35
	else if global.gameplay == 0
		image_speed = swingdingbuffer / 600
	else
		image_speed = 0.6;
}
