if room == rm_editor exit;

//Scared
var p = instance_nearest(x, y, obj_player);
if p.x > x - 400 && p.x < x + 400 && sprite_index != spr_angry
	sprite_index = spr_angry
else if !(p.x > x - 400 && p.x < x + 400) && sprite_index == spr_angry
{
	sprite_index = spr_happy
	alarm[0] = 100
}

if place_meeting(x, y, obj_otherplayer)
	image_alpha = 0.5;
else
	image_alpha = 1;

// fade meatophobia
if global.musicvolume > 0 && global.jukebox == -1
{
	if song != -1 && audio_is_playing(song)
	{
		if global.panic
		{
			audio_stop_sound(song);
			song = -1;
		}
		else
		{
			if audio_is_paused(song)
				audio_resume_sound(song);
			
			var vol = 1;
			if scr_stylecheck(2)
				vol = clamp((1 - (point_distance(x, y, p.x, p.y) / 300)) + 1, 0, 1);
			if room == custom_lvl_room && instance_exists(obj_player1.cam)
			{
				if !rectangle_in_rectangle(
				x - sprite_xoffset, y - sprite_yoffset, x + sprite_xoffset - 1, y + sprite_yoffset - 1,
				obj_player1.cam.x, obj_player1.cam.y, obj_player1.cam.x + obj_player1.cam_width, obj_player1.cam.y + obj_player1.cam_height)
					vol = 0;
			}
			
			var mv = global.musicvolume;
			audio_sound_gain(song, vol * mv, 2000);
			audio_sound_gain(global.music, mv - (vol * mv), 2000);
		}
	}
	else if !global.panic
	{
		audio_stop_sound(song);
		song = -1;
	
		if ((room != dungeon_10 && !string_startswith(room_get_name(room), "dragonlair")) or scr_checkskin(checkskin.p_anton))
		&& !audio_is_playing(mu_warintro) && !audio_is_playing(mu_warintro_pc)
		&& !(room == custom_lvl_room && global.disableescapemusic)
		{
			if global.musicgame == 1
				song = scr_soundeffect_ext(mu_dungeondepth_pc, true);
			else if scr_checkskin(checkskin.p_anton)
				song = scr_soundeffect_ext(mu_antondepth, true);
			else if check_sugary()
				song = scr_soundeffect_ext(mu_gummyharry, true)
			else
				song = scr_soundeffect_ext(mu_dungeondepth, true);
			
			audio_sound_gain(song, 0, 0);
		}
	}
}

