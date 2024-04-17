if ds_list_find_index(global.saveroom, id) == -1
{
	with obj_camera
	{
		shake_mag = 20;
		shake_mag_acc = 40 / room_speed;
	}
	gp_vibration(1, 1, 0.8);
	
	scr_soundeffect(sfx_breakmetal)
	ds_list_add(global.saveroom, id) 
	
	scr_secretbigdebris(,,spr_secretmetaldebris);
}

