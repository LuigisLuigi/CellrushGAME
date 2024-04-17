/// @description switch editor music
if scr_checkskin(checkskin.p_anton)
{
	alarm[0] = 1;
	exit;
}
if audio_is_playing(global.jukebox)
	exit;

if (lemusic != obj_music_set.music_editor or (!audio_is_playing(lemusic) && audio_exists(lemusic)))
{
	var mus = obj_music_set.music_editor;
	if mus == mu_entrance
	{
		switch playerobj.character
		{
			default: mus = mu_entrance break
			case "N": case "V": mus = mu_noiseentrance break
			case "S": mus = mu_snickentrance break
			case "SP": mus = mu_waffle break
		}
	}
	var musfinal = mus;
	
	// pizza castle
	if global.musicgame == 1
		musfinal = scr_getmidi(musfinal);
	
	audio_stop_sound(global.music)
	scr_sound(musfinal)
	if continuous
	{
		audio_sound_set_track_position(global.music, fadeoff)
		continuous = false
	}
	pausedmusic = musfinal
	lemusic = mus
}
