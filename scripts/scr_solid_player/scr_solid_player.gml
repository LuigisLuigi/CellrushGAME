/// @description Check if player is colliding, extra checks for ladders
function scr_solid_player(argX, argY, retcol = false)
{
	/// @param x
	/// @param y
	
	// Store old position
	var old_x = x
	var old_y = y
	var collide = noone;
	
	x = argX;
	y = argY;
	
	// Check if I'm over a tile
	var _solid = instance_place(x, y, obj_solid);
	var _ghostwall = instance_place(x, y, obj_ghostwall);
	
	if _ghostwall && state != states.ghost
		collide = _ghostwall;
	if _solid
		collide = _solid;
	
	// Check if I crossed a tile boundary and landed on a platform
	if place_meeting(x, y, obj_platform) && state != states.ladder
	{
		var instlist = ds_list_create();
		var numplat = instance_place_list(x, y, obj_platform, instlist, true);
		
		if y > old_y && bbox_bottom % 16 == 0
		{
			for(var i = numplat - 1; i >= 0; i--)
			{
				var inst = instlist[| i];
				if !place_meeting(x, old_y, inst) && place_meeting(x, y, inst)
				{
					if inst.object_index != obj_cottonplatform or (state == states.cotton && sprite_index != spr_cotton_drill) or (character == "V" && !key_down)
					{
						collide = inst;
						break;
					}
				}
			}
		}
		ds_list_destroy(instlist);
	}
	
	var transwater = instance_place(x, y, obj_transwater);
	if transwater && !place_meeting(x, old_y, transwater) && scr_stylecheck(0, 2)
	{
		if state == states.mach3 or (state == states.machslide && sprite_index == spr_mach3boost)
			collide = transwater;
	}
	
	// Check if I'm on a grindrail
	if y > old_y && bbox_bottom % 16 == 0
	&& !place_meeting(x, old_y, obj_grindrail) && place_meeting(x, y, obj_grindrail)
	{
		if state == states.mach2 or state == states.grind
			collide = true;
	}

	// Check if I'm over a slope
	var slope = check_slope(obj_slope);
	if slope
		collide = slope;
	
	x = old_x
	y = old_y
	return (retcol ? collide : instance_exists(collide));
}

