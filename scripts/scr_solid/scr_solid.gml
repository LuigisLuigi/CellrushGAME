/// @description Check if object is currently clipping into a wall or slope
function scr_solid(argument0, argument1, slop = true, retcol = false)
{
	// Store old position
	var old_x = x
	var old_y = y
	var collide = noone;
	
	x = argument0
	y = argument1
	
	// Check if I'm over a tile
	var _solid = instance_place(x, y, obj_solid);
	var _ghostwall = instance_place(x, y, obj_ghostwall);
	
	if _ghostwall
		collide = _ghostwall;
	if _solid
		collide = _solid;

	// Check if I crossed a tile boundary and landed on a platform
	if place_meeting(x, y, obj_platform)
	{
		var instlist = ds_list_create();
		var numplat = instance_place_list(x, y, obj_platform, instlist, true);
	
		if y > old_y && bbox_bottom % 16 == 0
		{
			for(var i = numplat - 1; i >= 0; i--)
			{
				if !place_meeting(x, old_y, instlist[| i]) && place_meeting(x, y, instlist[| i])
				{
					collide = instlist[| i];
					break;
				}
			}
		}
		ds_list_destroy(instlist);
	}
	
	// Check if I'm over a slope
	var slope = check_slope(obj_slope);
	if slope
		collide = slope;
	
	x = old_x;
	y = old_y;
	return (retcol ? collide : instance_exists(collide));
}

function check_slope(inst)
{
	var slope = instance_place(x, y, inst)
    if slope
    {
        with slope
        {
            var object_side = 0
            var slope_start = 0
            var slope_end = 0
			
            if image_xscale > 0
            {
                object_side = other.bbox_right
                slope_start = bbox_bottom
                slope_end = bbox_top
            }
            else
            {
                object_side = other.bbox_left
                slope_start = bbox_top
                slope_end = bbox_bottom
            }
			
            var m = (sign(image_xscale) * (bbox_bottom - bbox_top)) / (bbox_right - bbox_left);
            var n = slope_start - round(m * (object_side - bbox_left));
			
            if other.bbox_bottom >= n
                return slope;
        }
    }
    return false;
}

function scr_solid_slope(xx, yy)
{
    old_x = x
    old_y = y
    x = xx
    y = yy
	
    if check_slope(obj_slope)
    {
        var inst = instance_place(x, y, obj_slope)
        if sign(inst.image_xscale) != xscale
        {
            x = old_x
            y = old_y
            return inst
        }
    }
	
    x = old_x
    y = old_y
    return false
}

function scr_solidwall(xx, yy, retcol = false)
{
	// Store old position
	var old_x = x
	var old_y = y
	var collide = noone
	
	x = xx
	y = yy
	
	// Check if I'm over a tile
	var _solid = instance_place(x, y, obj_solid);
	var _ghostwall = instance_place(x, y, obj_ghostwall);
	
	if _ghostwall
		collide = _ghostwall;
	if _solid
		collide = _solid;
	
	x = old_x;
	y = old_y;
	return (retcol ? collide : instance_exists(collide));
}

