if ds_list_find_index(global.saveroom, id) = -1
{
	if audio_is_playing(sfx_breakblock1) or audio_is_playing(sfx_breakblock2)
	{
		audio_stop_sound(sfx_breakblock1)
		audio_stop_sound(sfx_breakblock2) 
	}
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)

	ds_list_add(global.saveroom, id) 
	if is_array(layers)
		scr_secretbigdebris(,,,layers);
	else
		scr_secretbigdebris();
}

