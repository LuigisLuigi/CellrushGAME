if live_call() return live_result;
scr_getinput();

//Move Up and down
if menuto != -1
{
	if menuto < menu
	{
		camx = lerp(camx, -960, -0.5);
		if camx >= 960
		{
			if menu == 1
				optionselected = 3;
			if menu == 2
				optionselected = 5;
			
			menu = menuto;
			menuto = -1;
			camx = -960;
		}
	}
	else
	{
		camx = lerp(camx, 960, -0.5);
		if camx <= -960
		{
			menu = menuto;
			menuto = -1;
			camx = 960;
		}
	}
	exit;
}
else
	camx = lerp(camx, 0, 0.25);

if !instance_exists(obj_keyconfig) && !instance_exists(obj_erasegame)
{
	if !(instance_exists(obj_pause) && obj_pause.pause)
		var omax = 5;
	else
		omax = 4;
	
	if menu == 1
		omax = 3;
	if menu == 2
		omax = 14;
	
	var mov = -(key_up2 or keyboard_check_pressed(vk_up)) + (key_down2 or keyboard_check_pressed(vk_down));
	var movh = -(key_up or keyboard_check(vk_up)) + (key_down or keyboard_check(vk_down));
	
	if movh == 0
		holdkey = -1;
	if holdkey == 0
	{
		holdkeyt--;
		if holdkeyt <= 0
		{
			if optionselected + movh >= 0 && optionselected + movh <= omax
			{
				holdkeyt = 5;
				scr_soundeffect(sfx_step);
				optionselected += movh;
			}
			else
				holdkey = -1;
		}
	}
	
	if mov == -1
	{
		holdkey = 0;
		holdkeyt = 20;
		if optionselected > 0
		{
			optionselected -= 1
			scr_soundeffect(sfx_step)
		}
		else if menu == 2
		{
			optionselected = omax;
			scr_soundeffect(sfx_step)
		}
	}
	if mov == 1
	{
		holdkey = 0;
		holdkeyt = 20;
		if optionselected < omax
		{
			optionselected += 1
			scr_soundeffect(sfx_step)
		}
		else if menu == 2
		{
			optionselected = 0;
			scr_soundeffect(sfx_step)
		}
	}
}

#region main options
if menu == 0
{
	//Full Screen
	if optionselected == 0
	{
		if (key_right2 or keyboard_check_pressed(vk_right)) && optionsaved_fullscreen == 0
		{
			scr_soundeffect(sfx_step)
			optionsaved_fullscreen = 1
		}
		if (-key_left2 or keyboard_check_pressed(vk_left)) && optionsaved_fullscreen == 1
		{
			scr_soundeffect(sfx_step)
			optionsaved_fullscreen = 0
		}
		
		if key_jump or keyboard_check_pressed(vk_enter)
		{
			scr_soundeffect(sfx_enemyprojectile)
			
			ini_open("saveData.ini");
			global.option_fullscreen = !optionsaved_fullscreen
			ini_write_real("Option", "fullscreen", global.option_fullscreen)  
			ini_close();
			
			window_set_fullscreen(global.option_fullscreen);
			
			with obj_roomname
			{
				showtext = true;
				message = "SAVED!";
				alarm[0] = 60;
			}
		}
	}
	else
		optionsaved_fullscreen = !global.option_fullscreen;
	
	//Resolution
	if optionselected == 1
	{
		if (key_right2 or keyboard_check_pressed(vk_right)) && optionsaved_resolution < 2
		{
			scr_soundeffect(sfx_step)
			optionsaved_resolution += 1
		}
		
		if (-key_left2 or keyboard_check_pressed(vk_left)) && optionsaved_resolution > 0
		{
			scr_soundeffect(sfx_step)
			optionsaved_resolution -= 1
		}
		
		if key_jump or keyboard_check_pressed(vk_enter)
		{
			scr_soundeffect(sfx_enemyprojectile)
			
			ini_open("saveData.ini");
			global.option_resolution = optionsaved_resolution
			ini_write_real("Option", "resolution", global.option_resolution)  
			ini_close();
			
			if !window_get_fullscreen()
			{
				switch optionsaved_resolution
				{
					case 0: window_set_size( 480, 270 ); break;
					case 1: window_set_size( 960, 540 ); break;
					case 2: window_set_size( 1920, 1080 ); break;
				}
			}
			
			with obj_roomname
			{
				showtext = true;
				message = "SAVED!";
				alarm[0] = 60;
			}
		}
	}
	else
		optionsaved_resolution = global.option_resolution;
	
	// key config
	if optionselected == 2 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		scr_soundeffect(sfx_step)
		visible = false
		instance_create(x, y, obj_keyconfig)
	}
	
	// audio settings
	if optionselected == 3 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		scr_soundeffect(sfx_step)
		menuto = 1
		optionselected = 0
		
		if instance_exists(obj_music) && global.musicvolume > 0
			music = global.music;
	}
	
	// gamepad vibration
	if optionselected == 4
	{
		if (key_right2 or keyboard_check_pressed(vk_right)) && optionsaved_vibration == 0
		{
			scr_soundeffect(sfx_step)
			optionsaved_vibration = 1
		}
		if (-key_left2 or keyboard_check_pressed(vk_left)) && optionsaved_vibration == 1
		{
			scr_soundeffect(sfx_step)
			optionsaved_vibration = 0
		}
		
		if key_jump or keyboard_check_pressed(vk_enter)
		{
			scr_soundeffect(sfx_enemyprojectile)
			global.gamepadvibration = !optionsaved_vibration
			
			ini_open("saveData.ini");
			ini_write_real("online", "gamepadvibration", global.gamepadvibration)  
			ini_close();
			
			gp_vibration(1, 1, 0.9);
			
			with obj_roomname
			{
				showtext = true;
				message = "SAVED!";
				alarm[0] = 60;
			}
		}
	}
	else
		optionsaved_vibration = !global.gamepadvibration;
	
	// other options
	if optionselected == 5 && !instance_exists(obj_keyconfig)
	&& ((key_jump or keyboard_check_pressed(vk_enter)))
	{
		scr_soundeffect(sfx_step)
		menuto = 2
		optionselected = 0
		camy = 0
	}

	//Finish
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
	{
		scr_soundeffect(sfx_enemyprojectile)
		with obj_mainmenuselect
			selected = false
		with obj_player
			state = 0;
		
		instance_destroy()
		audio_stop_sound(mu_editor);
		
		if audio_is_playing(global.jukebox)
			audio_pause_sound(global.jukebox);
	}
}
#endregion
#region sound options
else if menu == 1
{
	// master volume slider
	if optionselected == 0
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;
		
		global.mastervolume = clamp(global.mastervolume + move, 0, 1);
		if keyboard_check_pressed(ord("R"))
			global.mastervolume = 1;
	}
	audio_master_gain(!game_is_compiled() ? global.mastervolume / 2 : global.mastervolume);
	
	// music volume slider
	if optionselected == 1
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;
		
		if keyboard_check_pressed(ord("R"))
			global.musicvolume = 0.6;
		
		global.musicvolume = clamp(global.musicvolume + move, 0, 1);
		audio_sound_gain(music, global.musicvolume, 0);
		
		if global.musicvolume > 0 && !audio_is_playing(music)
		{
			if !instance_exists(obj_music)
			{
				global.music = -4;
				global.jukebox = -1;
				music = scr_soundeffect_ext(mu_editor);
			}
			else
			{
				with obj_music
				{
					forcefadeoff = 4.8;
					event_perform(ev_other, ev_room_start);
				}
				music = global.music;
			}
		}
	}
	
	// mach sound
	if optionselected == 2
	{
		audio_sound_gain(global.music, min(global.musicvolume, 0.2), 100);
		if (key_right2 or keyboard_check_pressed(vk_right)) && global.machsound == 1
			global.machsound = 0
		if (-key_left2 or keyboard_check_pressed(vk_left)) && global.machsound == 0
			global.machsound = 1
		
		var _sfx_mach2 = global.machsound == 0 ? sfx_mach2 : sfx_mach2_old
		
		if (audio_is_playing(sfx_mach2) && _sfx_mach2 != sfx_mach2)
		or (audio_is_playing(sfx_mach2_old) && _sfx_mach2 != sfx_mach2_old)
		{
			audio_stop_sound(sfx_mach2);
			audio_stop_sound(sfx_mach2_old);
			scr_soundeffect(_sfx_mach2);
		}
		if !audio_is_playing(sfx_mach2) && !audio_is_playing(sfx_mach2_old)
			scr_soundeffect(_sfx_mach2);
	}
	else
	{
		audio_sound_gain(global.music, global.musicvolume, 100);
		audio_stop_sound(sfx_mach2);
		audio_stop_sound(sfx_mach2_old);
	}
	
	// tower and castle
	if optionselected == 3
	{
		var mgprev = global.musicgame;
		if (key_right2 or keyboard_check_pressed(vk_right)) && global.musicgame < 1
			global.musicgame++;
		if (-key_left2 or keyboard_check_pressed(vk_left)) && global.musicgame > 0
			global.musicgame--;
		
		// refresh music
		if global.musicgame != mgprev && global.jukebox == -1
		{
			if instance_exists(obj_music)
			{
				audio_stop_sound(global.music);
				audio_stop_sound(music);
				
				with obj_music
					event_perform(ev_alarm, 1);
				music = global.music;
			}
			else
			{
				audio_stop_sound(global.music);
				global.music = -4;
				scr_soundeffect(sfx_step);
			}
		}
	}
	
	//Finish
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
	{
		scr_soundeffect(sfx_enemyprojectile)
		menuto = 0
		
		audio_stop_sound(sfx_mach2);
		audio_stop_sound(sfx_mach2_old);
		audio_sound_gain(global.music, global.musicvolume, 0);
		
		ini_open("saveData.ini");
		ini_write_real("online", "musicvolume", global.musicvolume)  
		ini_write_real("online", "mastervolume", global.mastervolume)
		ini_write_real("online", "machsound", global.machsound)
		ini_write_real("online", "musicgame", global.musicgame)
		ini_close();
		
		if global.musicvolume <= 0 && audio_is_playing(global.music)
		{
			audio_stop_sound(global.music);
			global.jukebox = -1;
		}
		
		with obj_roomname
		{
			showtext = true;
			message = "SAVED!";
			alarm[0] = 60;
		}
	}
}
#endregion
#region other options
else if menu == 2 && !instance_exists(obj_erasegame)
{
	var select = key_jump or keyboard_check_pressed(vk_enter);
	
	// erase game
	if optionselected == 0 && select
	{
		scr_soundeffect(sfx_step)
		visible = false
		instance_create(x, y, obj_erasegame)
	}
	
	// gameplay style
	if optionselected == 1
	{
		var move = key_left2 + key_right2;
		if select
		{
			global.gameplay++;
			scr_soundeffect(sfx_step);
		}
		else if move != 0
		{
			global.gameplay += move;
			scr_soundeffect(sfx_step);
		}
		if global.gameplay > 2
			global.gameplay = 0;
		if global.gameplay < 0
			global.gameplay = 2;
	}
	
	// panic bg
	if optionselected == 2 && select
	{
		if check_shaders()
		{
			global.panicbg = !global.panicbg;
			scr_soundeffect(sfx_step);
		}
		else
			scr_soundeffect(sfx_denied);
	}
	
	// panic melt
	if optionselected == 3
	{
		if select
		{
			global.panicmelt = !global.panicmelt;
			scr_soundeffect(sfx_step);
		}
	}
	
	// panic shake
	if optionselected == 4
	{
		if select
		{
			global.panicshake = !global.panicshake;
			scr_soundeffect(sfx_step);
		}
	}
	
	// panic change bg
	if optionselected == 5
	{
		if select
		{
			global.panicnightmare = !global.panicnightmare;
			scr_soundeffect(sfx_step);
		}
	}
	
	// secret debris
	if optionselected == 6
	{
		if select
		{
			global.secretdebris = !global.secretdebris;
			scr_soundeffect(sfx_step);
		}
	}
	
	// show names
	if optionselected == 7
	{
		if select
		{
			global.shownames = !global.shownames;
			scr_soundeffect(sfx_step);
		}
	}
	
	// chat bubbles
	if optionselected == 8
	{
		if select
		{
			global.chatbubbles = !global.chatbubbles;
			scr_soundeffect(sfx_step);
		}
	}
	
	// sync effects
	if optionselected == 9
	{
		if select
		{
			global.synceffect = !global.synceffect;
			scr_soundeffect(sfx_step);
		}
	}
	
	// streamer
	if optionselected == 10
	{
		if select
		{
			global.streamer = !global.streamer;
			scr_soundeffect(sfx_step);
		}
	}
	
	// drpc
	if optionselected == 11
	{
		if select
		{
			global.richpresence = !global.richpresence;
			scr_soundeffect(sfx_step);
		}
	}
	
	// fps count
	if optionselected == 12
	{
		if select
		{
			global.showfps = !global.showfps;
			scr_soundeffect(sfx_step);
		}
	}
	
	// camera smoothing slider
	if optionselected == 13
	{
		if keyboard_check(vk_shift)
			var move = (key_left2 + key_right2) * 0.01;
		else
			var move = (key_left + key_right) * 0.02;
		
		global.camerasmoothing = clamp(global.camerasmoothing + move, 0, 1);
	}
	
	// input display
	if optionselected == 14
	{
		if select
		{
			global.inputdisplay = !global.inputdisplay;
			scr_soundeffect(sfx_step);
		}
	}
	
	//Finish
	if (key_slap2 or keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig)
	{
		scr_soundeffect(sfx_enemyprojectile)
		menuto = 0
		
		ini_open("saveData.ini");
		ini_write_real("online", "gameplay", global.gameplay)
		with obj_player
			noisetype = (global.gameplay == 0 ? 0 : 1);
		
		ini_write_real("online", "panicmelt", global.panicmelt)  
		ini_write_real("online", "panicbg", global.panicbg)  
		ini_write_real("online", "panicshake", global.panicshake)
		ini_write_real("online", "panicnightmare", global.panicnightmare)
		
		ini_write_real("online", "secretdebris", global.secretdebris)
		ini_write_real("online", "shownames", global.shownames)
		ini_write_real("online", "chatbubbles", global.chatbubbles)
		ini_write_real("online", "synceffect", global.synceffect)
		ini_write_real("online", "richpresence", global.richpresence)
		ini_write_real("online", "streamer", global.streamer)
		ini_write_real("online", "showfps", global.showfps)
		ini_write_real("online", "camerasmoothing", global.camerasmoothing)
		ini_write_real("online", "inputdisplay", global.inputdisplay)
		ini_write_real("online", "gamepadvibration", global.gamepadvibration)
		ini_close();
		
		if obj_drpc_updater.running != global.richpresence
		{
			with obj_drpc_updater
			{
				if !running
					event_user(0);
				else
					event_user(1);
			}
		}
		
		if variable_global_exists("__chat_bubbles")
			global.__chat_bubbles = global.chatbubbles;
		
		with obj_roomname
		{
			showtext = true;
			message = "SAVED!";
			alarm[0] = 60;
		}
	}
}
#endregion