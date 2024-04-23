if ds_list_find_index(global.saveroom, id) = -1
{
	if sprite_index == spr_bigdestroyablehard_ss
	{
		with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			sprite_index = spr_bigdebrisbandage_ss
			momentum = other.momentum
		}
	}
	
	if place_meeting(x, y, obj_tiles)
		scr_secretbigdebris();
	else
	{
		var rep = global.gameplay == 0 ? 7 : 8;
		for(var i = 0; i <= rep; i++)
		{
			with instance_create(x + irandom(sprite_width), y + irandom(sprite_height), obj_debris)
			{
				image_xscale = abs(other.image_xscale);
				image_yscale = abs(other.image_yscale);
			
				if other.sprite_index == spr_bigdestroyable_ss
					sprite_index = spr_bigdebris_ss;
				else
					sprite_index = spr_bigdebris;
				
				momentum = other.momentum;
				
				if other.sprite_index == spr_towerblock
				{
					image_speed = 0.35
					sprite_index = spr_towerblockdebris
				}
			}
		}
	}
	
	if global.gameplay != 0
	{
		repeat 3
	    {
	        with instance_create(x + random_range(0, 64), y + random_range(0, 64), obj_parryeffect)
	        {
	            sprite_index = spr_deadjohnsmoke
	            image_speed = 0.35
	        }
	    }
	}
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id) 
}

