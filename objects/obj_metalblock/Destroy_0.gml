if ds_list_find_index(global.saveroom, id) == -1
{
	var shit = global.gameplay == 0 ? 4 : 8;
	if sprite_index == spr_metalblock_ss
		shit = 8;
	
	repeat shit with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_metaldebris)
	{
		if other.sprite_index == spr_metalblock_ss
		{
			sprite_index = spr_metaldebris_ss;
			hsp = random_range(-8, 8);
		}
		else if other.sprite_index == spr_metalblock_NEW_ss
			sprite_index = spr_metaldebris_NEW_ss;
		else if other.sprite_index == spr_metalblockescape_ss
			sprite_index = spr_metalblockdebrisescape_ss;
		else if other.sprite_index == spr_metalbescape
			sprite_index = spr_metalblockdebrisescape;
		else if other.sprite_index == spr_hotmetalblock
			sprite_index = spr_metalblockharddebris;
		
		image_index = random(image_number);
		momentum = other.momentum;
	}
	
	with obj_camera
	{
		shake_mag = 20;
		shake_mag_acc = 40 / room_speed;
	}
	gp_vibration(1, 1, 0.8);
	
	scr_soundeffect(sfx_breakmetal)
	ds_list_add(global.saveroom, id) 
}
