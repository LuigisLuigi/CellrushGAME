if room == rm_editor exit;

if ds_list_find_index(global.saveroom, id) = -1 && !global.snickchallenge
{
	if sprite_index == spr_bigbreakable_NEW
	{
		scr_sleep(5)
	    with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_parryeffect)
	        sprite_index = spr_bigpizzablockdead
	}
	else
	{
		repeat 6 with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
		{
			image_xscale = abs(other.image_xscale)
			image_yscale = abs(other.image_yscale)
		
			if other.sprite_index == spr_halloweenbigblock
			or other.sprite_index == spr_xmasbigblock
				sprite_index = spr_halloweenbigdebris
			else if other.sprite_index == spr_destroyable2big_ss
				sprite_index = spr_bigpizzadebris_ss
			else if other.sprite_index == spr_destroyable2big_NEW_ss
				sprite_index = spr_bigpizzadebris_NEW_ss
			else if other.sprite_index == spr_bigbreakable_PP
				sprite_index = spr_bigpizzadebris_PP
			else
				sprite_index = spr_bigpizzadebris
			
			momentum = other.momentum;
		}
	}
	
	if content == noone
	{
		if global.gameplay != 0
		{
			scr_failmod(mods.no_toppings);
			
			global.heattime += 10
	        global.heattime = clamp(global.heattime, 0, 60)
	        global.combotime += 10
	        global.combotime = clamp(global.combotime, 0, 60)
			
	        var val = heat_calculate(100)
	        global.collect += val
			
	        scr_soundeffect(sfx_collecttopping)
	        with instance_create(x + sprite_width / 2, y, obj_smallnumber)
	            number = string(val)
		}
		else
		{
			with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_pizzaslice)
				hsp = 2
			with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_pizzaslice)
				hsp = -2
		}
	}
	else
		instance_create(x + sprite_width / 2, y, content);
	
	create_baddiegibsticks(x + sprite_width / 2, y + sprite_height / 2);
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id) 
}