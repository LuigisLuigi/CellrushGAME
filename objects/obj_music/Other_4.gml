// prepare
if wait
{
	alarm[1] = 1;
	exit;
}

loopstart = -1;
loopend = -1;

lemusic = -1;
if global.musicvolume <= 0
{
	audio_stop_sound(global.music);
	exit;
}
if audio_is_playing(global.jukebox)
	exit;

roomname = room_get_name(room)
if string_endswith(roomname, "_NEW")
	roomname = string_replace(roomname, "_NEW", "");

var musplay = -1;
if scr_checkskin(checkskin.p_anton)
{
	// ANTONBALL
	if !global.panic && !global.snickchallenge
	{
		if string_contains(roomname, "secret")
			musplay = mu_antonsecret;
		else if room == hub_arcade or room == hub_roomPLN
			musplay = mu_antonsage;
		else if room == hub_outside3b2
			musplay = mu_antonpunchball;
		else if room != rank_room && room != timesuproom
			musplay = mu_antonlevel;
	}
}
else if (!global.panic or string_letters(roomname) == "dragonlair" or string_letters(roomname) == "grinch" or (instance_exists(obj_secretfound) && global.gameplay != 0))
&& !global.snickchallenge
{
	// room number
	var roomnumber = string_digits(roomname);
	if string_is_number(roomnumber)
		roomnumber = real(roomnumber);
	else
		roomnumber = 0;
	
	if instance_exists(obj_pepperman)
	{
		fadeoff = 0
		musplay = mu_chase
	}
	
	if string_letters(roomname) == "Realtitlescreen" or string_letters(roomname) == "Realtitlescreen"
	{
		fadeoff = 0
		musplay = mu_title
	}
	
	if room == editor_entrance
	{
		fadeoff = 0
		musplay = mu_editor
	}
	
	if string_startswith(roomname, "hub_room") or string_letters(roomname) == "Titlescreen" or string_letters(roomname) == "halloweenentrance"
	{
		if audio_is_playing(mu_tutorial)
			fadeoff = 0;
		
		musplay = mu_hub
	}
	if string_startswith(roomname, "hub_outside")
		musplay = mu_hub2
	if string_startswith(roomname, "hub_arcade")
		musplay = mu_hubarcade
	if string_startswith(roomname, "hub_roomSP") or string_startswith(roomname, "sugary_outer")
	{
		fadeoff = 0
		musplay = mu_sugaryhub
	}
	if string_startswith(roomname, "rm_test")
		musplay = mu_mall
	if string_startswith(roomname, "hub_roomE")
	{
		if room == hub_roomE2
		{
			fadeoff = 0
			musplay = mu_mall
		}
		else if room == hub_roomE3
		{
			fadeoff = 0
			musplay = mu_null
		}
		else
		{
			if audio_is_playing(mu_mall)
				fadeoff = 0;
				
			musplay = mu_hube
		}
	}
	
	if string_letters(roomname) == "PProom"
	{
		fadeoff = 0
		musplay = mu_tutorial
	}
	
	if string_letters(roomname) == "entrance"
	or (string_letters(roomname) == "entryway" && sugaryspire)
	{
		switch playerobj.character
		{
			default: musplay = mu_entrance break
			case "N": case "V": musplay = mu_noiseentrance break
			case "S": musplay = mu_snickentrance break
			case "SP": musplay = mu_waffle break
		}
	}
	
	if string_letters(roomname) == "dungeon"
	{
		musplay = !global.snickrematch ? mu_dungeon : mu_dungeon_re;
		if roomnumber > 8
		{
			fadeoff = 0;
			musplay = !global.snickrematch ? mu_dungeondepth : mu_dungeondepth_re;
		}
	}
	
	if string_letters(roomname) == "strongcold"
	{
		musplay = mu_strongcold
		if roomnumber == 1
		{
			fadeoff = 0
			musplay = mu_chateau
		}
		else if roomnumber > 8
		{
			fadeoff = 0
			musplay = mu_dungeondepth
		}
	}
	
	if string_letters(roomname) == "medieval" 
	{
		if global.snickrematch
			musplay = mu_phantom
		else
		{
			if roomnumber <= 2
				musplay = mu_medievalentrance;
			else if roomnumber <= 5
				musplay = mu_medievalremix;
			else
				musplay = mu_medieval;
		}
	}

	if string_letters(roomname) == "ruin" 
	{
		if global.snickrematch
			musplay = mu_apartment
		else
		{
			musplay = mu_ruin;
			if roomnumber > 6
				musplay = mu_ruinremix;
		}
	}

	if string_letters(roomname) == "chateau"
		musplay = mu_chateau
	
	if string_letters(roomname) == "farm" 
		musplay = mu_farm
	
	if string_letters(roomname) == "graveyard" 
		musplay = mu_graveyard

	if string_letters(roomname) == "ufo" 
		musplay = mu_pinball

	if string_letters(roomname) == "dragonlair" 
		musplay = mu_dragonlair

	if string_letters(roomname) == "beach" 
		musplay = mu_beach
	
	if string_letters(roomname) == "forest" 
	{
		musplay = mu_gnomeforest;
		if roomnumber < 4
			musplay = mu_forest;
		if roomnumber == 4
		{
			fadeoff = 0;
			musplay = mu_gustavo;
		}
	}
	
	if string_letters(roomname) == "kungfu" 
		musplay = mu_kungfu
	
	if string_startswith(roomname, "golf_")
	or string_letters(roomname) == "minigolf"
	{
		musplay = mu_minigolf;
		if scr_checkskin(checkskin.s_shit)
			musplay = mu_susgolf;
	}
	
	if string_letters(roomname) == "war" 
		musplay = mu_warintro
	
	if string_letters(roomname) == "space"
	{
		musplay = mu_space
		if global.gameplay == 1
			musplay = mu_pinball
	}
	
	if sugaryspire
	{
		if string_startswith(roomname, "cotton")
		{
			musplay = mu_cotton;
			if roomnumber >= 8
				musplay = mu_cotton2;
		}
		if string_startswith(roomname, "molasses")
			musplay = mu_swamp
		if string_startswith(roomname, "mines")
			musplay = mu_mines
		if string_startswith(roomname, "sugarytut")
		{
			fadeoff = 0
			musplay = mu_tutorial_ss
		}
	}
	
	// desert
	if string_startswith(roomname, "floor1_room")
	or string_startswith(roomname, "floor1_mart")
	{
		musplay = mu_desert;
		if roomnumber > 9
			musplay = mu_ufo;
	}

	// freezer
	if string_startswith(roomname, "oldfreezer_")
	{
		musplay = mu_freezer;
		if roomnumber > 6
			musplay = mu_freezer2;
	}

	// sewer
	if string_startswith(roomname, "oldsewer_")
	{
		musplay = mu_sewer;
		if roomnumber > 5
		{
			if audio_is_playing(mu_sewer)
				fadeoff = 0
			musplay = mu_sewer2
		}
	}

	// factory
	if string_startswith(roomname, "oldfactory_")
		musplay = mu_factory

	// etb
	if string_startswith(roomname, "etb_")
	{
		if roomnumber == 1
		{
			fadeoff = 0
			musplay = mu_tutorial
		}
		else
		{
			if audio_is_playing(mu_tutorial)
				fadeoff = 0;
			
			if scr_checkskin(checkskin.p_peter) && global.musicgame != 1
				musplay = music_onepizzaatatime
			else
				musplay = mu_ruin
		}
	}
	
	// ancient
	if string_letters(roomname) == "ancient"
		musplay = mu_ancient;
	
	// grinch
	if string_letters(roomname) == "grinch"
		musplay = mu_christmas;
	
	// la burrata temple
	if string_letters(roomname) == "sanctum"
		musplay = mu_sanctum;
	
	// mansion
	if string_startswith(roomname, "oldmansion_")
	{
		musplay = mu_mansion;
		if roomnumber > 8
			musplay = mu_forest;
	}
	
	// secrets
	if string_letters(roomname) == "entrancesecret"
	{
		musplay = mu_entrancesecret
		with obj_player
		{
			if character == "SP" musplay = mu_entrancesecretSP;
			if character == "PP" musplay = mu_entrancesecretPP;
		}
	}
	if string_letters(roomname) == "medievalsecret"
	or string_letters(roomname) == "ancientsecret"
	{
		musplay = mu_medievalsecret
		if global.snickrematch
			musplay = mu_medievalsecret_re;
	}
	if string_letters(roomname) == "ruinsecret"
	or string_letters(roomname) == "etbsecret"
	{
		musplay = mu_ruinsecret
		if global.snickrematch
			musplay = mu_ruinsecret_re;
	}
	if string_letters(roomname) == "dungeonsecret"
	{
		musplay = mu_dungeonsecret
		if global.snickrematch
			musplay = mu_dungeonsecret_re
	}
	if string_letters(roomname) == "chateausecret" 
		musplay = mu_chateausecret
	if string_letters(roomname) == "strongcoldsecret"
		musplay = mu_strongcoldsecret
	if string_startswith(roomname, "floor1_secret")
		musplay = mu_desertsecret
	if string_startswith(roomname, "oldmansion_secret")
		musplay = mu_mansionsecret
	if string_startswith(roomname, "oldsewer_secret")
		musplay = mu_sewersecret
	if string_letters(roomname) == "graveyardsecret" 
		musplay = mu_graveyardsecret
	if string_letters(roomname) == "farmsecret" 
		musplay = mu_farmsecret
	if string_letters(roomname) == "ufosecret" 
		musplay = mu_pinballsecret
	if string_letters(roomname) == "forestsecret"
		musplay = mu_forestsecret
	if string_letters(roomname) == "beachsecret"
		musplay = mu_beachsecret
	if string_letters(roomname) == "kungfusecret" 
		musplay = mu_kungfusecret
	if string_letters(roomname) == "spacesecret"
	{
		musplay = mu_spacesecret
		if global.gameplay == 1
			musplay = mu_pinballsecret
	}
	if string_letters(roomname) == "entrywaysecret"
	{
		if playerobj.character == "SP"
			musplay = mu_wafflesecret;
		else if playerobj.character == "PP"
			musplay = mu_entrancesecretPP_ss;
		else
			musplay = mu_entrancesecret_ss;
	}
	if string_letters(roomname) == "cottonsecret"
		musplay = mu_cottonsecret
	if string_letters(roomname) == "molassessecret"
		musplay = mu_swampsecret
	if string_letters(roomname) == "minessecret"
		musplay = mu_minessecret
	if string_letters(roomname) == "sanctumsecret"
		musplay = mu_sanctumsecret
	
	if room == custom_lvl_room
		alarm[0] = 4;
}

if musplay > -1
{
	// pizza castle
	if global.musicgame == 1
		musplay = scr_getmidi(musplay);
	
	// play the song
	if !audio_is_playing(musplay)
	{
		// try to remedy secret song looping main song
		if string_contains(audio_get_name(musplay), "secret")
			secretfadeoff = fadeoff;
		else if string_contains(audio_get_name(global.music), "secret")
		{
			if fadeoff < secretfadeoff
				fadeoff += round(secretfadeoff / audio_sound_length(global.music)) * audio_sound_length(global.music);
		}
		
		audio_stop_sound(global.music);
		pausedmusic = scr_sound(musplay);
		audio_sound_set_track_position(global.music, fadeoff % audio_sound_length(musplay));
	}
}

if forcefadeoff != -1
{
	audio_sound_set_track_position(global.music, forcefadeoff);
	forcefadeoff = -1;
}
audio_sound_pitch(global.music, musicpitch);

