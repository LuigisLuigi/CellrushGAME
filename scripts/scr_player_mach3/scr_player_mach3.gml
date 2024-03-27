function scr_player_mach3()
{
	#region not pogo noise
	if character != "N" or noisetype == 1
	{
		if windingAnim < 2000 && character == "P"
			windingAnim += 1;
		
		var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then railh = railmeet.spdh;
		hsp = xscale * movespeed + railh;
		
		mach2 = 100
		momentum = true
		
		move = key_right + key_left
		move2 = key_right2 + key_left2
		
		if fightball && global.coop
		{
			if object_index == obj_player1
			{
				x = obj_player2.x
				y = obj_player2.y
			}
			if object_index == obj_player2
			{
				x = obj_player1.x
				y = obj_player1.y
			}
		}
		if move == xscale
		{
			if movespeed < 24
			{
				if global.gameplay != 0 && sprite_index == spr_crazyrun
					movespeed += 0.1;
				else repeat (1 + scr_checkskin(checkskin.n_hardoween))
					movespeed += global.gameplay == 0 ? 0.1 : 0.025;
				
				scr_player_addslopemomentum(0.1, 0.2);
			}
			
			if sprite_index == spr_crazyrun && global.gameplay != 0
			{
				if !instance_exists(crazyruneffectid) && grounded
				{
					with instance_create(x, y, obj_crazyruneffect)
					{
						playerid = other.object_index
						other.crazyruneffectid = id
					}
				}
					
				if !place_meeting(x, y + 1, obj_water) && !place_meeting(x, y + 1, obj_transwater)
				{
					with instance_create(x, y, obj_dashcloud)
					{
						image_xscale = other.xscale
						sprite_index = spr_flamecloud
					}
				}
			}
		}
		if movespeed > 12 && move != xscale && !pizzapepper
			movespeed -= 0.1

		crouchslideAnim = true

		//Jump Stop
		if !key_jump2 && !jumpstop && vsp < 0.5 
		{
			vsp /= 10
			jumpstop = true
		}

		if grounded && vsp > 0
			jumpstop = false

		//Jump
		if input_buffer_jump < 8 && grounded && (move == xscale or move == 0)
		{
			jumpstop = false;
			input_buffer_jump = 8;
				
			scr_soundeffect(sfx_jump)
			if sprite_index != spr_fightball
			{
				image_index = 0
				sprite_index = spr_mach3jump
			}
				
			if (character != "N" && character != "V") or global.gameplay != 0
				vsp = -11
			else
				vsp = -13
		}

		//Sprites
		if !fightball && state == states.mach3
		{
			if sprite_index = spr_mach3jump && floor(image_index) == image_number - 1 
				sprite_index = spr_mach4

			if floor(image_index) == image_number - 1 && (sprite_index = spr_rollgetup or sprite_index = spr_mach3hit or sprite_index == spr_dashpadmach)
				sprite_index = spr_mach4

			if sprite_index = spr_mach2jump && grounded && vsp > 0
				sprite_index = spr_mach4

			if movespeed > 20 && sprite_index != spr_crazyrun && sprite_index != spr_snick_tumble
			{
				flash = true
				sprite_index = spr_crazyrun
			}
			else if movespeed <= 20 && sprite_index == spr_crazyrun
				sprite_index = spr_mach4
		}

		if sprite_index = spr_crazyrun && !instance_exists(crazyruneffectid)
		{
			with instance_create(x, y, obj_crazyrunothereffect)
			{
				playerid = other.object_index
				other.crazyruneffectid = id
			}
		}

		// Input buffer jumping
		if key_jump
			input_buffer_jump = 0

		//Back to other states
		//Machslide
		if sprite_index != spr_dashpadmach or spr_mach4 == spr_dashpadmach
		{
			if ((!key_attack && !fightball) && grounded && character != "S") or (character == "S" && (move == 0 or move != xscale) && grounded) && !fightball
			{
				sprite_index = spr_machslidestart
				scr_soundeffect(sfx_break)
				state = states.machslide
				image_index = 0
			}
				
			if move == -xscale && grounded && character != "S" && !fightball && vsp >= 0
			{
				scr_soundeffect(sfx_machslideboost)
				sprite_index = spr_mach3boost
				state = states.machslide
				image_index = 0
			}
		}
		
		//Machroll
		if key_down && !fightball && !place_meeting(x, y, obj_dashpad)
		{
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
			flash = false
			
			if global.gameplay == 0
				state = states.machroll
			else
			{
				state = states.tumble
				if !grounded
		            sprite_index = spr_mach2jump
		        else
		            sprite_index = spr_machroll
			}
			
			vsp = 10
			if character == "V"
				sprite_index = spr_playerV_divekickstart
		}
		
		// Climbwall
		var slop = scr_slope();
		var bump = climb_wall() && ((!place_meeting(x + hsp, y, obj_metalblock) && !place_meeting(x + hsp, y, obj_mach3solid)) or character == "V");
		
		if bump && (slop or !grounded)
		{
			if !grounded or (!scr_solidwall(x, y - 32) or place_meeting(x, y - 32, obj_destructibles))
			{
				wallspeed = movespeed;
				if global.gameplay == 0
					wallspeed = 10;
				else if vsp > 0
					wallspeed -= vsp;
				
				vsp = -wallspeed;
				state = states.climbwall;
			}
		}
		
		//Bump
		if state != states.climbwall && bump && (grounded or fightball)
		{
			with (fightball ? id : obj_player)
			{
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
				hsp = 2.5 * -xscale
				vsp = -3
				mach2 = 0
				image_index = 0
					
				instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
				fightball = false
			}
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
			with instance_create(x, y, obj_dynamite)
			{
				image_xscale = other.xscale
					movespeed = other.movespeed + 4
				vsp = -6
			}
		}
		
		if key_slap2 && global.gameplay != 0
			scr_player_dosuplexdash();
	}
	#endregion
	#region pogo noise
	else
	{
		hsp = xscale * movespeed
		move = key_right + key_left

		if !fightball
			vsp = 0

		//Move slightly
		if key_up && !fightball
			vsp = -3

		if key_down && !fightball
			vsp = 3

		if movespeed < 24 && move == xscale
		{
			if sprite_index != spr_snick_tumble
				movespeed += 0.1

			if !instance_exists(crazyruneffectid) && grounded
			{
				with instance_create(x, y, obj_crazyruneffect)
				{
					playerid = other.object_index	
					other.crazyruneffectid = id
				}
					
				if sprite_index == spr_crazyrun
				{
					with instance_create(x, y, obj_dashcloud) 
					{
						image_xscale = other.xscale
						sprite_index = spr_flamecloud
					}
				}
			}
		}
		else if movespeed > 12 && move != xscale && pizzapepper == 0
			movespeed -= 0.1

		//Pogo
		if key_attack2 && !fightball
		{
			sprite_index = spr_playerN_pogostart
			image_index = 0
			state = states.pogo
			pogospeed = movespeed
		}
		
		if !fightball
		{
			if movespeed > 20 && sprite_index != spr_crazyrun 
			{
				flash = true
				sprite_index = spr_crazyrun
			}
			else if movespeed <= 20 && sprite_index = spr_crazyrun
				sprite_index = spr_playerN_jetpackboost	
		}
			
		if key_jump2 && !fightball
		{
			scr_soundeffect(sfx_jump)
			scr_soundeffect(sfx_woosh)
			jumpstop = false
			vsp = -15
			state = states.jump
			sprite_index = spr_playerN_noisebombspinjump
			image_index = 0
			with instance_create(x,y,obj_jumpdust)
				image_xscale = other.xscale
		}

		//Machroll
		if key_down && !fightball && !place_meeting(x,y,obj_dashpad) && grounded
		{
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale
				
			flash = false
			sprite_index = spr_playerN_jetpackslide
			state = states.machroll
		}

		//Jump Stop
		if !key_jump2 && !jumpstop && vsp < 0.5 && fightball
		{
			vsp /= 10
			jumpstop = true
		}

		if grounded && vsp > 0 && fightball
			jumpstop = false

		//Jump
		if input_buffer_jump < 8 && grounded && !(move == 1 && xscale == -1) && !(move == -1 && xscale == 1) && fightball
		{
			input_buffer_jump = 8
			scr_soundeffect(sfx_jump)
			if sprite_index != spr_fightball
			{
				image_index = 0
				sprite_index = spr_mach3jump
			}

			vsp = -11
		}
			
		//Bump
		var bump = (scr_solidwall(x + hsp, y) or scr_solid_slope(x + hsp, y))
		&& (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting(x + hsp, y, obj_metalblock) && !place_meeting(x + hsp, y, obj_mach3solid));
		
		if bump
		{
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
			hsp = 2.5 * -xscale
			vsp = -3
			mach2 = 0
			image_index = 0
			instance_create(x + 10 * xscale, y + 10, obj_bumpeffect)
		}
	}
	#endregion
	
	// dash cloud effects
	if !instance_exists(dashcloudid) && grounded
	{
		var dashcloud = instance_create(x, y, obj_superdashcloud);
		with dashcloud
		{
			image_xscale = other.xscale
			other.dashcloudid = id
		}
		if fightball or (global.gameplay != 0 && sprite_index == spr_crazyrun)
			instance_create(x, y, obj_slapstar)
		
		if place_meeting(x, y + 1, obj_water)
			dashcloud.sprite_index = spr_watereffect;
		
		var transgenderjokehere = instance_place(x, y + 1, obj_transwater);
		if transgenderjokehere
		{
			dashcloud.sprite_index = spr_watereffect;
			if transgenderjokehere.sprite_index == spr_water_ss
				dashcloud.sprite_index = spr_watereffect_ss;
		}
	}
	
	// charge effect
	if !instance_exists(chargeeffectid)
	{
		with instance_create(x,y,obj_chargeeffect)
		{
			playerid = other.object_index	
			other.chargeeffectid = id
		}
	}

	// animation speeds
	if sprite_index == spr_mach4 or sprite_index == spr_fightball or sprite_index == spr_mach3jump or sprite_index == spr_mach2jump or sprite_index == spr_snick_tumble or sprite_index == spr_playerN_jetpackboost
		image_speed = 0.35
	if sprite_index == spr_rollgetup
		image_speed = 0.5
	if sprite_index == spr_mach3hit or (sprite_index == spr_dashpadmach && spr_mach4 != spr_dashpadmach) or sprite_index == spr_crazyrun
		image_speed = 0.75

	//Super Jump
	if key_up && !fightball && (!(character == "N" && noisetype == 0) && character != "V") && (grounded or character == "PP" or (character == "S" && global.gameplay == 0) or character == "SP") && (sprite_index != spr_dashpadmach or spr_mach4 == spr_dashpadmach)
	{
		sprite_index = spr_superjumpprep
		scr_soundeffect(sfx_superjumpprep);
		state = states.Sjumpprep
		hsp = 0
		image_index = 0
	}
	
	//Taunt
	if key_taunt2
		scr_player_taunt();
}

