function scr_player_machroll()
{
	var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then railh = railmeet.spdh;
	hsp = xscale * movespeed + railh;
	
	mach2 = 100
	machslideAnim = true
	
	move = key_right + key_left
	
	switch character
	{
		default:
		if character != "N" or (character == "N" && noisetype == 1)
		{ 
			//Bump
			if (scr_solidwall(x + xscale,y) or scr_solid_slope(x + sign(hsp), y)) && !place_meeting(x + sign(hsp), y, obj_destructibles)
			{
				scr_soundeffect(sfx_bumpwall)
				
				hsp = 0
				image_speed = 0.35
				
				flash = false
				combo = 0
				state = states.bump
				hsp = 2.5 * -xscale
				vsp = -3
				mach2 = 0
				image_index = 0
				instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
			}

			if !instance_exists(dashcloudid) && grounded
			with instance_create(x, y + 43, obj_cloudeffect)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
			
			if grounded && sprite_index != spr_playerV_divekickstart
				sprite_index = spr_machroll 
			else if sprite_index != spr_dive 
			{
				sprite_index = spr_dive 
				vsp = 10
			}
			if scr_slope() && global.gameplay != 0
                movespeed += 0.1
			image_speed = 0.8
		
			if !key_down && state != states.bump && (!scr_solid(x, y - 32) or character == "S")
			{
				image_index = 0
				scr_soundeffect(sfx_rollgetup)
				if character != "S"
					sprite_index = spr_rollgetup
				
				if movespeed < 12 or global.gameplay == 0
				{
					state = states.mach2;
					if character == "S"
						sprite_index = spr_mach;
				}
				else
				{
					state = states.mach3;
					if character == "S"
						sprite_index = spr_mach4;
				}
			}
			
			// Breakdance
			if key_shoot2 && character == "P" && !scr_checkskin(checkskin.p_anton) && global.gameplay != 1
			{
				sprite_index = spr_player_breakdancesuper
				movespeed = 14
				state = states.punch
			}
		}
		else
		{
			//Bump
			if (scr_solidwall(x + xscale,y) or scr_solid_slope(x + sign(hsp), y)) && !place_meeting(x + sign(hsp), y, obj_destructibles)
			{
				scr_soundeffect(sfx_bumpwall)
				
				hsp = 0
				image_speed = 0.35
				
				flash = false
				combo = 0
				state = states.bump
				hsp = 2.5 * -xscale
				vsp = -3
				mach2 = 0
				image_index = 0
				instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
			}
			
			if (!key_down or !grounded) && state != states.bump
			{
				image_index = 0
				scr_soundeffect(sfx_rollgetup)
				state = states.mach3
				sprite_index = spr_playerN_jetpackboost
			}
			
			if !instance_exists(dashcloudid) && grounded
			with instance_create(x, y + 43, obj_cloudeffect)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
			image_speed = 0.8
		}
		break
	   
		case "V":
			//Animations
			if sprite_index == spr_playerV_divekickstart && floor(image_index) >= image_number - 1
				sprite_index = spr_playerV_divekick
			
			//Bump
			if scr_solidwall(x + xscale,y) or scr_solid_slope(x + sign(hsp), y)
			{
				scr_soundeffect(sfx_bumpwall)
				
				hsp = 0
				image_speed = 0.35
				
				flash = false
				combo = 0
				state = states.bump
				hsp = 2.5 * -xscale
				vsp = -3
				mach2 = 0
				image_index = 0
				instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
			}
			
			if !instance_exists(dashcloudid) && grounded
			with instance_create(x, y + 43, obj_cloudeffect)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
			
			if sprite_index != spr_playerV_divekickstart
			{
				if grounded
					sprite_index = spr_machroll
				else
				{
					if sprite_index != spr_dive 
					{
						sprite_index = spr_dive 
						vsp = 10
					}
				}
			}
			image_speed = 0.8
			
			if !key_down && !scr_solid(x + 27 * xscale, y - 32) && !scr_solid(x, y - 32)
			{
				image_index = 0
				scr_soundeffect(sfx_rollgetup)
				sprite_index = spr_rollgetup
			
				if movespeed < 12 or global.gameplay == 0
					state = states.mach2;
				else
					state = states.mach3;
			}
	}
}

