if ds_list_find_index(global.saveroom, id) = -1
{
	if place_meeting(x, y, obj_tiles)
		scr_secretdebris();
	else
	{
		var rep = global.gameplay == 0 ? 4 : 2; // amount of debris
		
		var dsprite = -1, dimage_speed = 0;
		if sprite_index == spr_destroyable_ss
			dsprite = spr_debris_ss;
		if sprite_index == spr_towerblocksmall
		{
			dsprite = spr_towerblockdebris;
			dimage_speed = 0.35;
			
			with instance_create(x + irandom(sprite_width), y + irandom(sprite_height), obj_parryeffect)
		        sprite_index = spr_deadjohnsmoke
		}
		
		var var_struct = {
			image_xscale : abs(other.image_xscale),
			image_yscale : abs(other.image_yscale),
			momentum : other.momentum
		};
		
		repeat rep
		{
			with instance_create(x + irandom(sprite_width), y + irandom(sprite_height), obj_debris, var_struct)
			{
				if dsprite != -1
					sprite_index = dsprite;
				image_speed = dimage_speed;
			}
		}
	}
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id)
}
