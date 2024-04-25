if live_call()
	return live_result;

gototitle = room == hub_room1 or room == hub_roomSAGE or room == hub_roomE2 or room == cowboytask or room == Titlescreen or room == Scootertransition;
with obj_player
{
	if place_meeting(x, y, obj_startgate) && state == states.victory
		gototitle = false;
}

if check_online()
	gms_self_set("pause", pause);

if instance_exists(obj_pausefadeout) && (instance_exists(obj_fadeout) or !canpause)
	instance_destroy(obj_pausefadeout);

// start pausing
if !pause && !instance_exists(obj_fadeout) && !instance_exists(obj_pausefadeout)
{
	var kstart = false;
	if instance_exists(obj_player)
		kstart = obj_player.key_start;
	else
	{
		scr_getinput();
		kstart = key_start;
	}
	
	// pressed pause button
	if kstart && (room != rank_room && room != Realtitlescreen && room != timesuproom && room != characterselect && room != editor_entrance)
	{
		keyboard_clear(global.key_jump);
		
		if !check_race() && (!instance_exists(obj_player1) or (obj_player1.state != states.grabbed && obj_player1.baddiegrabbedID != obj_otherplayer))
		{
			selected = 0;
			objectlist = [];
			instance_create(x, y, obj_pausefadeout);
		}
		else
			scr_soundeffect(sfx_denied);
	}
}

if pause && !instance_exists(obj_option)
{
	if !string_startswith(konami, "UUDDLRLR")
		scr_getinput();
	
	//DDP Always draw normally while paused
	application_surface_draw_enable(true)
	if instance_exists(obj_pausefadeout) && !obj_pausefadeout.fadein
		exit;
	
	// move
	if key_down2 && selected < 3
	{
		selected += 1
		scr_soundeffect(sfx_step)
	}

	if key_up2 && selected > 0
	{
		selected -= 1
		scr_soundeffect(sfx_step)
	}
	
	// RESTART LEVEL
	if key_jump && selected == 1
	{
		if !global.snickchallenge
		{
			var roomname = room_get_name(room);
			gotoroom = -1;
			
			if string_startswith(roomname, "entrance")
				gotoroom = entrance_1;
			else if string_startswith(roomname, "medieval")
				gotoroom = medieval_1;
			if string_startswith(roomname, "chateau")
				gotoroom = chateau_1;
			else if string_startswith(roomname, "ruin")
				gotoroom = ruin_1;
			else if string_startswith(roomname, "dungeon")
				gotoroom = dungeon_1;
			else if string_startswith(roomname, "floor1_")
				gotoroom = floor1_room0;
			else if string_startswith(roomname, "oldmansion_")
				gotoroom = oldmansion_9;
			else if string_startswith(roomname, "oldfactory_")
				gotoroom = oldfactory_0;
			else if string_startswith(roomname, "oldsewer_")
				gotoroom = oldsewer_0;
			else if string_startswith(roomname, "oldfreezer_")
				gotoroom = oldfreezer_1;
			else if string_startswith(roomname, "golf_")
				gotoroom = golf_1;
			else if string_startswith(roomname, "graveyard")
				gotoroom = graveyard_1;
			else if string_startswith(roomname, "farm")
				gotoroom = farm_1;
			else if string_startswith(roomname, "ufo")
				gotoroom = ufo_1;
			else if string_startswith(roomname, "dragonlair")
				gotoroom = dragonlair_1;
			else if string_startswith(roomname, "strongcold")
				gotoroom = strongcold_10;
			else if string_startswith(roomname, "beach")
				gotoroom = beach_1;
			else if string_startswith(roomname, "forest")
				gotoroom = forest_1;
			else if string_startswith(roomname, "kungfu")
				gotoroom = kungfu_1;
			else if string_startswith(roomname, "war")
				gotoroom = war_1;
			else if string_startswith(roomname, "space")
				gotoroom = space_1;
			
			else if string_startswith(roomname, "etb")
				gotoroom = etb_1;
			else if string_startswith(roomname, "ancient")
				gotoroom = ancient_1;
			else if string_startswith(roomname, "grinch")
				gotoroom = grinch_1;
			else if string_startswith(roomname, "sanctum")
				gotoroom = sanctum_1;
			
			else if string_startswith(roomname, "entryway")
				gotoroom = entryway_1;
			else if string_startswith(roomname, "cotton")
				gotoroom = cotton_1;
			else if string_startswith(roomname, "molasses")
				gotoroom = molasses_1;
			else if room == custom_lvl_room
				gotoroom = room;
			
			if gotoroom != -1
			{
				instance_activate_all();
				alarm[0] = 1;
			}
			else
				scr_soundeffect(sfx_enemyprojectile);
		}
		else if global.snickchallenge or global.snickrematch
		{
			instance_activate_all();
			alarm[2] = 1;
		}
	}
	
	// EXIT TO TITLE
	if key_jump && selected == 2
	{
		instance_activate_all();
		alarm[1] = 1;
	}
	
	// RESUME
	if key_jump && selected == 0
	{
		if !instance_exists(obj_pausefadeout)
			instance_create(x, y, obj_pausefadeout);
	}
	
	// OPTIONS
	if key_jump && selected == 3 && !instance_exists(obj_option)
	{
		scr_soundeffect(sfx_step);
		with instance_create(0, 0, obj_option)
		{
			if global.jukebox != -1
			{
				audio_resume_sound(global.jukebox);
				music = global.jukebox;
			}
			else if global.musicvolume > 0
			{
				music = scr_soundeffect_ext(mu_editor, true);
				audio_sound_gain(music, global.musicvolume, 0);
			}
		}
	}
	
	// konami code for old golf level funmode
	if alarm[0] == -1 && alarm[1] == -1 && alarm[2] == -1 && !global.funmode && string_startswith(room_get_name(room), "golf") && !global.timeattack
	{
		switch keyboard_lastkey
		{
			case vk_up:
				konami += "U";
				break;
			case vk_down:
				konami += "D";
				break;
			case vk_left:
				konami += "L";
				break;
			case vk_right:
				konami += "R";
				break;
			case global.key_jump:
				konami += "A";
				break;
			case global.key_slap:
				konami += "B";
				break;
		}
		if konami != "" && string_copy(konamiend, 1, string_length(konami)) != konami
			konami = "";
		
		if konami == konamiend
		{
			global.funmode = true;
			scr_soundeffect(sfx_collecttoppin);
			keyboard_clear(keyboard_lastkey);
			instance_create(x, y, obj_pausefadeout)
			konami = "";
		}
		keyboard_lastkey = -1;
	}
}
else
	konami = "";
