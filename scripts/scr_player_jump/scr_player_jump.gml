function scr_player_jump()
{
	landAnim = true
	if !momentum
		hsp = move * movespeed;
	else
		hsp = xscale * movespeed;
	hsp += railmovespeed * raildir
	
	if dir != xscale
	{
		dir = xscale
		movespeed = 2
		facehurt = false
	}
	
	move = key_left + key_right;
	if move != xscale
		movespeed = 2;
	
	if movespeed == 0
		momentum = false;
	
	if scr_solidwall(x + hsp, y)
	{
		movespeed = 0;
		mach2 = 0;
	}
	
	//Movespeed
	var _acc = 0.5;
	var _msp = global.gameplay != 0 ? 8 : 6;
	if scr_checkskin(checkskin.n_hardoween)
	{
		_acc = 0.25;
		_msp = 8;
	}
	if character == "SP"
		_msp = 7;
	
	if move != 0 
	{
		if movespeed < _msp
			movespeed += _acc
		else if floor(movespeed) == _msp
			movespeed = _msp
		
		if scr_solidwall(x + xscale, y) && move == xscale
			movespeed = 0
	}
	else
		movespeed = 0
	
	if movespeed > _msp
		movespeed -= 0.1

	//Turn
	if dir != xscale 
		dir = xscale
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

	if move != 0
		xscale = move

	//Wallcling
	if character == "N" && wallclingcooldown == 10 && noisetype == 0
	{
		if scr_solid(x + xscale, y) && key_jump
		{
			scr_soundeffect(sfx_step)
			
			state = states.hang
			sprite_index = spr_playerN_wallclingstart
			image_index = 0
			xscale *= -1
			vsp = 0
			doublejump = false
		}
		
		//Noise double jump
		else if key_jump && !doublejump && sprite_index != spr_freefall && sprite_index != spr_facestomp
		{
			scr_soundeffect(sfx_woosh)
			jumpAnim = true
			sprite_index = spr_playerN_doublejump
			image_index = 0
			jumpstop = false
			vsp = -9
			with instance_create(x, y, obj_highjumpcloud2)
				image_xscale = other.xscale
			doublejump = true
		}
	}
	
	if global.mort && (sprite_index == spr_pmortjump or sprite_index == spr_pmortjumpstart)
	{
		if vsp > 6
			vsp = 6;
		if !key_jump2
		{
			grav = basegrav;
			sprite_index = spr_fall;
		}
	}
	if key_jump
	{
		if global.mort && sprite_index != spr_pmortjump && sprite_index != spr_suplexbump
		{
			repeat 6 with instance_create(x, y, obj_debris)
				sprite_index = spr_feather;
			
			scr_soundeffect(sfx_woosh);
			sprite_index = spr_pmortjumpstart;
			image_index = 0;
			
			jumpAnim = false;
			jumpstop = false;
			grav = 0.25;
			mort = 1;
			doublejump = false;
		}
	}
	if sprite_index != spr_pmortjump
		grav = basegrav;

	//Input jumping
	if (grounded && (input_buffer_jump < 8) && !key_down && !key_attack && vsp > 0) && !(sprite_index = spr_facestomp or sprite_index = spr_freefall)
	{
		input_buffer_jump = 8;
		scr_soundeffect(sfx_jump)
		
		if sprite_index != spr_shotgunshoot
		{
			if shotgunAnim && character != "SP"
				sprite_index = spr_shotgunjump
			else if global.minutes <= 0 && global.seconds <= 0
			&& character == "P" && !instance_exists(obj_toppinwarrior)
				sprite_index = spr_player_hurtjump
			else
				sprite_index = spr_jump
		}

		instance_create(x,y,obj_highjumpcloud2)
		stompAnim = false
		
		vsp = -11
		
		state = states.jump
		jumpAnim = true
		jumpstop = false
		image_index = 0
		if !scr_stylecheck(2)
			movespeed = 2
		freefallstart = 0
		
		grav = 0;
	}


	///Back to other states

	//Normal
	if (grounded && vsp > 0) && (!key_attack or character == "S")
	{
		if suplexmove && character == "SP" && sprite_index != spr_suplexbump
			flash = true
		
		scr_soundeffect(sfx_step)
		if key_attack or sprite_index == spr_shotgunshoot
			landAnim = false
		if sprite_index == spr_pmortjump or sprite_index == spr_pmortjumpstart
			sprite_index = spr_pmortland;
		if sprite_index != spr_shotgunshoot
			image_index = 0;
		
		instance_create(x, y, obj_landcloud)
		input_buffer_secondjump = 0
		state = states.normal
		jumpAnim = true
		jumpstop = false

		freefallstart = 0
		grav = basegrav;
	}
	
	//Dynamite jump effect
	if floor(image_index) >= image_number -1 && sprite_index == spr_playerV_superjump
	{
		with instance_create(x, y + 25, obj_balloonpop)
			sprite_index = spr_shotgunimpact
	}
	
	//Input buffer jumping
	if key_jump
		input_buffer_jump = 0
	
	//Falling Animation
	if character != "S" && sprite_index != spr_pmortjump
	{
		if vsp > 5
			fallinganimation ++

		if fallinganimation >= 40 && fallinganimation < 80
			sprite_index = spr_facestomp

		if fallinganimation >= 80 
			sprite_index = spr_freefall
	}
	
	//Animations
	if !stompAnim
	{
		if !jumpAnim
		{
			if sprite_index == spr_playerN_doublejump
				sprite_index = spr_playerN_doublejumpfall
			
			if sprite_index == spr_pmortjumpstart
				sprite_index = spr_pmortjump
	
			if sprite_index == spr_airdash1
				sprite_index = spr_airdash2

			if sprite_index == spr_shotgunjump
				sprite_index = spr_shotgunfall

			if sprite_index == spr_playerV_superjump
				sprite_index = spr_playerV_fall

			if sprite_index == spr_jump
				sprite_index = spr_fall

			if sprite_index == spr_player_hurtjump
				sprite_index = spr_player_hurtjump2

			if sprite_index == spr_player_Sjumpstart
				sprite_index = spr_player_Sjump

			if sprite_index == spr_shotgunjump1
				sprite_index = spr_shotgunjump2
			
			if sprite_index == spr_shotgun_shootair
				sprite_index = spr_shotgun_fall
			
			if sprite_index == spr_suplexcancel
				sprite_index = spr_fall

			if sprite_index == spr_suplexland
				sprite_index = spr_fall

			if sprite_index == spr_shotgunshoot
				sprite_index = spr_shotgunfall
			
			if sprite_index == spr_playerSP_candytransitionup
				sprite_index = spr_playerSP_candyup

			if sprite_index == spr_stompprep
			{
				stompAnim = true
				sprite_index = spr_stomp
			}
		}
	}
	else
	{
		if sprite_index == spr_stompprep && floor(image_index) == image_number - 1
			sprite_index = spr_stomp
	}

	//Vigilante Dynamite
	if key_shoot2 && character = "V" && !instance_exists(obj_dynamite)
	{
		if move = 0
			movespeed = 0
		state = states.dynamite
		image_index = 0
		sprite_index = spr_playerV_dynamitethrow
		with instance_create(x,y,obj_dynamite)
		{
			image_xscale = other.xscale
			movespeed = 6
			vsp = -6
		}
		grav = basegrav;
	}

	//Manual Freefall
	if key_down2
	{
		image_index = 0
		state = states.freefallprep
		
		if global.gameplay != 0
			vsp = -6
		else if character != "N" && character != "V"
			vsp = -5
		else
			vsp = -7
		
		if !shotgunAnim
			sprite_index = spr_bodyslamstart
		else
		{
			sprite_index = spr_shotgunjump1
			if (character != "N" or global.gameplay != 0) && character != "SP"
			{
				scr_soundeffect(sfx_killingblow)
				if global.gameplay != 0
					vsp = -11
				
				with instance_create(x, y + 60, obj_shotgunbullet)
				{
					sprite_index = sprite10391
					spdh = -10
					spd = 0
					shotgun = true
				}
				with instance_create(x, y + 60, obj_shotgunbullet)
				{
					sprite_index = sprite10391
					spdh = -10
					spd = 5
					shotgun = true
				}
				with instance_create(x, y + 60, obj_shotgunbullet)
				{
					sprite_index = sprite10391
					spdh = -10
					spd = -5
					shotgun = true
				}
			}
		}
		grav = basegrav;
	}
	
	image_speed = 0.3;
	if sprite_index == spr_suplexcancel or (jumpstop && jumpAnim && !stompAnim)
		image_speed = 0.4;

	//Chainsaw Pogo
	//if key_chainsaw2 && !grounded
	//{
	//with instance_create(x,y,obj_chainsawpogohitbox)
	//{
	//image_xscale = other.xscale
	//}
	//instance_create(x + (-xscale * 20),y+30,obj_chainsaweffect)
	//image_index = 0
	//sprite_index = spr_player_chainsawpogo1
	//state = states.chainsawpogo
	//}


	//Freefall
	if grounded && (sprite_index == spr_facestomp or sprite_index == spr_freefall)
	{
		with obj_baddie
		{
			if point_in_camera(x, y, view_camera[0])
			{
				vsp = -7
				hsp = 0
			}
		}
		with obj_camera
		{
			shake_mag = 10;
			shake_mag_acc = 30 / room_speed;
		}
		
		audio_stop_sound(sfx_groundpound)
		scr_soundeffect(sfx_groundpound)
		image_index = 0
		if character == "SP"
			sprite_index = spr_playerSP_machfreefallland
		else
			sprite_index = spr_bodyslamland
		state = states.freefallland
		grav = basegrav;
	}
	
	//Suplex Dash
	if key_slap2 && (character != "S" && character != "V")
	{
		if key_up && global.gameplay != 0 && character == "SP" && sprite_index != spr_breakdanceuppercutend
		{
			// Breakdance up
			scr_soundeffect(sfx_suplexdash);
				
			state = states.punch;
			image_index = 0;
			sprite_index = spr_breakdanceuppercut;
			vsp = -7;
			movespeed = hsp;
			instance_create(x, y, obj_highjumpcloud2);
			//instance_create(x, y, obj_swingdinghitbox);
			
			grav = basegrav;
		}
		else if !suplexmove
		{
			state = states.handstandjump;
			scr_player_dosuplexdash();
		}
	}

	// Breakdance
	if key_shoot2 && (!shotgunAnim or character == "SP")
	{
		// mortimer
		if global.mort
		{
			scr_soundeffect(sfx_killingblow);
			scr_soundeffect(sfx_enemyprojectile);
			with instance_create(x + xscale * 20, y, obj_shotgunbullet)
			{
				image_xscale = other.xscale;
				sprite_index = spr_mortprojectile;
			}
				
			sprite_index = spr_pmortthrow
			image_index = 0
			state = states.pistol
			mort = true
				
			with obj_camera
			{
				shake_mag = 3
				shake_mag_acc = 3 / room_speed
			}
		}
		
		// antonball
		else if scr_checkskin(checkskin.p_anton)
		{
			if !instance_exists(obj_antonball)
			{
				scr_soundeffect(sfx_enemyprojectile);
				with instance_create(x, y, obj_antonball)
				{
					hsp = 6 * other.xscale;
					if other.key_up
						vsp = -6;
					canhit = false;
					alarm[0] = 15;
				}
			}
			else
				instance_destroy(obj_antonball);
		}
		
		else if global.gameplay != 1
		{
			if character == "P"
			{
				// breakdance
				scr_soundeffect(sfx_breakdance);
				vsp = -4;
				movespeed = 9;
				state = states.punch;
				sprite_index = spr_player_breakdancestart;
				breakdance = 35;
				image_index = 0;
				instance_create(x, y, obj_swingdinghitbox);
				
				grav = basegrav;
			}
			
			// noise bomb
			if character == "N"
			{
				scr_soundeffect(sfx_noisewoah)
				state = states._throw
				sprite_index = spr_playerN_noisebombthrow
				image_index = 0
				with instance_create(x,y,obj_playerbomb)
				{
					movespeed = 7
					vsp = -7
					image_xscale = other.xscale
				}
				grav = basegrav;
			}
		}
		
		// bullet
		else if (character == "P" or character == "N") && global.bullet > 0
		{
			if !scr_solid_player(x + xscale * 20, y) or place_meeting(x + xscale * 20, y, obj_destructibles)
			{
				global.bullet--;
				sprite_index = spr_pistolshot
				image_index = 0
				state = states.pistol
				shot = true
					
				with obj_camera
				{
					shake_mag = 3;
					shake_mag_acc = 3 / room_speed;
				}
					
				scr_soundeffect(sfx_killingblow);
				if character == "N"
				{
					with instance_create(x, y, obj_playerbomb)
					{
						kick = true
						movespeed = 15
						image_xscale = other.xscale
					}
				}
				else
				{
					with instance_create(x + xscale * 20, y, obj_shotgunbullet)
					{
						while scr_solid(x, y)
							y++;
						pistol = true
						if other.character == "P"
							sprite_index = spr_peppinobullet
						image_xscale = other.xscale
					}
				}
			}
			else
			{
				image_index = 0
				state = states.bump
				hsp = -xscale * 2
				vsp = -2
			}
		}
	}

	// Shotgun
	else if key_shoot2 && state == states.jump
	{
		if shoot_buffer <= 0 && key_shoot2
		{
			grav = basegrav;
			if global.gameplay == 0
			{
				// shoot in old gameplay
				state = states.shotgun
				
				with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
					shotgun = true;
				if character != "N"
				{
					with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
					{
						spdh = 4
						shotgun = true;
					}
					with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
					{
						spdh = -4
						shotgun = true;
					}
				}
			}
			else
			{
				// shoot in new gameplay
				shoot_buffer = shoot_max;
				with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
				{
					image_xscale = other.xscale;
					shotgun = true;
				}
				with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
				{
					image_xscale = other.xscale;
					shotgun = true;
					spdh = 4;
				}
				with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
				{
					image_xscale = other.xscale;
					shotgun = true;
					spdh = -4;
				}
			}
			
			// detail
			jumpAnim = true;
			
			sprite_index = spr_shotgunshoot;
			image_index = 0;
			scr_soundeffect(sfx_killingblow);
			
			with instance_create(x, y, obj_pistoleffect)
				image_xscale = other.xscale;
		}
	}
	
	//Jetpack flash
	if character == "N" && pogochargeactive or pizzapepper > 0
	{
		if key_attack2
		{
			scr_soundeffect(sfx_noisewoah)
			state = states.Sjumpprep
			image_index = 0
			if !key_up
				sprite_index = spr_playerN_jetpackstart
			else
				sprite_index = spr_superjumpprep
			hsp = 0
			vsp = 0
			
			grav = basegrav;
		}
	}
	
	if !key_attack or move != xscale
		mach2 = 0

	//Land Mach1
	if key_attack && grounded && fallinganimation < 40 && (!(character == "N" && noisetype == 0) && character != "S" && !(character == "SP" && shotgunAnim))
	{
		if pizzapepper == 0
		{
			if movespeed < 6 or global.gameplay == 0
				movespeed = 6
			sprite_index = spr_mach1
			jumpAnim = true
			state = global.gameplay == 0 ? states.mach1 : states.mach2
			image_index = 0
		}
		else
		{
			movespeed = 21
			sprite_index = spr_crazyrun
			jumpAnim = true
			state = states.mach3
			movespeed = 20
		}
		grav = basegrav;
	}

	//Vigilante Boots 
	//if key_attack && character = "V" && grounded
	//{
	//image_index = 0
	///sprite_index = spr_playerV_bootsout
	//state = states.boots
	//movespeed = 2
	//}
	
	//Pogo
	if key_attack && ((character == "N" && noisetype == 0) or (character == "SP" && shotgunAnim)) && state != states.Sjumpprep && !key_slap2 && pizzapepper <= 0
	{
		sprite_index = spr_playerN_pogostart
		if character == "SP"
			sprite_index = spr_playerSP_canefall
		image_index = 0
		state = states.pogo
		grav = basegrav;
	}

	if floor(image_index) >= image_number -1
		jumpAnim = false
	
	//Vigilante revolver
	if key_slap2 && character = "V"
	{
		vsp = -5
		state = states.revolver	
		image_index = 0
		sprite_index = spr_playerV_airrevolver
		image_index = 0
		with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
			shotgun = true
		scr_soundeffect(sfx_killingblow)
		grav = basegrav;
	}
	
	//Taunt
	if key_taunt2 
		scr_player_taunt();
	
	if sprite_index == spr_shotgunshoot
	{
		landAnim = false
		machslideAnim = false
		image_speed = 0.45
		
		if image_index >= image_number - 1
			sprite_index = spr_shotgunfall
	}
}

