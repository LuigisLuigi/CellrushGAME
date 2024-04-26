function scr_soundeffect()
{
	var snd = argument[irandom(argument_count - 1)];
	return scr_soundeffect_ext(snd);
}
function scr_soundeffect_ext(snd, loops = false)
{
	// old mach sound
	if instance_exists(obj_music) && global.machsound == 1
	&& snd == sfx_break
		snd = sfx_machslide;
	
	// replace timesup sound
	if snd == mu_timesup && scr_checkskin(checkskin.p_anton)
		snd = mu_antondeath;
	
	// player character specific sounds
	if instance_exists(obj_player)
	{
		if !((snd == sfx_parry or snd == sfx_taunt) && object_index == obj_coolpineapple)
		{
			if obj_player.character == "SP"
			{
				if snd == sfx_parry
					snd = sfx_parrySP;
				if snd == sfx_collecttoppin
					snd = sfx_toppinjingleSP;
				if snd == sfx_collecttopping
					snd = sfx_toppingSP;
			}
			if obj_player.character == "PP"
			{
				if asset_get_type(audio_get_name(snd) + "_PP") == asset_sound
					snd = asset_get_index(audio_get_name(snd) + "_PP");
			}
		}
	}
	
	// stop collect sound
	if snd == sfx_collecttopping or snd == sfx_toppingSP
		audio_stop_sound(snd);
	if snd == sfx_breakblock1 or snd == sfx_breakblock2
	{
		audio_stop_sound(sfx_breakblock1);
		audio_stop_sound(sfx_breakblock2);
	}
	
	var sndplay = audio_play_sound(snd, 0, loops);
	if room != rm_disclaimer
		audio_sound_gain(sndplay, global.soundvolume, 0);
	
	if snd == sfx_collecttopping && scr_stylecheck(2)
		audio_sound_pitch(sndplay, random_range(0.95, 1.05));
	return sndplay;
}

