// prepare
function draw_mask(xx = x, yy = y)
{
	var _mask = mask_index == -1 ? sprite_index : mask_index;
	
	// Get the unmodified mask data
	var _b1 = sprite_get_bbox_left(_mask) * image_xscale;
	var _b2 = sprite_get_bbox_top(_mask) * image_yscale;
	var _b3 = (sprite_get_bbox_right(_mask) + 1) * image_xscale;
	var _b4 = (sprite_get_bbox_bottom(_mask) + 1) * image_yscale;
	
	var _xoff = sprite_get_xoffset(_mask) * image_xscale;
	var _yoff = sprite_get_yoffset(_mask) * image_yscale;
	
	// Get the unmodified vector for each corner
	var _dis1 = point_distance(_xoff, _yoff, _b1, _b2);
	var _dir1 = point_direction(_xoff, _yoff, _b1, _b2);
	var _dis2 = point_distance(_xoff, _yoff, _b3, _b2);
	var _dir2 = point_direction(_xoff, _yoff, _b3, _b2);
	var _dis3 = point_distance(_xoff, _yoff, _b3, _b4);
	var _dir3 = point_direction(_xoff, _yoff, _b3, _b4);
	var _dis4 = point_distance(_xoff, _yoff, _b1, _b4);
	var _dir4 = point_direction(_xoff, _yoff, _b1, _b4);

	// Now modify the vectors using the current position and image angle
	var _x1 = lengthdir_x(_dis1, image_angle + _dir1);
	var _y1 = lengthdir_y(_dis1, image_angle + _dir1);
	var _x2 = lengthdir_x(_dis2, image_angle + _dir2);
	var _y2 = lengthdir_y(_dis2, image_angle + _dir2);
	var _x3 = lengthdir_x(_dis3, image_angle + _dir3);
	var _y3 = lengthdir_y(_dis3, image_angle + _dir3);
	var _x4 = lengthdir_x(_dis4, image_angle + _dir4);
	var _y4 = lengthdir_y(_dis4, image_angle + _dir4);
			
	draw_primitive_begin(pr_trianglefan);
	draw_vertex(xx + _x1, yy + _y1);
	draw_vertex(xx + _x2, yy + _y2);
	draw_vertex(xx + _x3, yy + _y3);
	draw_vertex(xx + _x4, yy + _y4);
	draw_primitive_end();
}

/// @description world control draw
draw_set_font(global.font_small); // pt exclusive
draw_set_halign(fa_center);
draw_set_color(c_white);

// function 7
if WC_showinvisible
{
	with all
	{
		if sprite_exists(sprite_index)
		{
			// pt exclusive
			if variable_instance_exists(self, "xscale")
			{
				if variable_instance_exists(self, "yscale")
					draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, 0.75);
				else
					draw_sprite_ext(sprite_index, image_index, x, y, xscale, image_yscale, image_angle, image_blend, 0.75);
			}
			else if variable_instance_exists(self, "yscale")
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, yscale, image_angle, image_blend, 0.75);
			else
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.75);
		}
		else
		{
			draw_set_alpha(1);
			draw_set_colour(c_white);
			draw_set_valign(fa_middle);
			draw_text(x, y, object_get_name(object_index));
			draw_set_valign(fa_top);
		}
	}
}

// debug selected
if instance_exists(WC_debugselected) && WC_debugselected != global && WC_debuginfo
{
	// draw mask
	if WC_fakedragobj != WC_debugselected
	{
		draw_set_alpha(0.5);
		draw_set_colour(c_red);
		with WC_debugselected
			draw_mask();
		draw_set_alpha(1);
	}
	
	if sprite_exists(WC_debugselected.sprite_index)
	{
		// redraw sprite
		if !WC_debugselected.visible or WC_debugselected.image_alpha <= 0
		{
			// pt exclusive
			if variable_instance_exists(WC_debugselected, "xscale")
			{
				if variable_instance_exists(WC_debugselected, "yscale")
					draw_sprite_ext(WC_debugselected.sprite_index, WC_debugselected.image_index, WC_debugselected.x, WC_debugselected.y, WC_debugselected.xscale, WC_debugselected.yscale, WC_debugselected.image_angle, WC_debugselected.image_blend, 0.75);
				else
					draw_sprite_ext(WC_debugselected.sprite_index, WC_debugselected.image_index, WC_debugselected.x, WC_debugselected.y, WC_debugselected.xscale, WC_debugselected.image_yscale, WC_debugselected.image_angle, WC_debugselected.image_blend, 0.75);
			}
			else if variable_instance_exists(WC_debugselected, "yscale")
				draw_sprite_ext(WC_debugselected.sprite_index, WC_debugselected.image_index, WC_debugselected.x, WC_debugselected.y, WC_debugselected.image_xscale, WC_debugselected.yscale, WC_debugselected.image_angle, WC_debugselected.image_blend, 0.75);
			else
				draw_sprite_ext(WC_debugselected.sprite_index, WC_debugselected.image_index, WC_debugselected.x, WC_debugselected.y, WC_debugselected.image_xscale, WC_debugselected.image_yscale, WC_debugselected.image_angle, WC_debugselected.image_blend, 0.75);
		}
		
		// center of sprite
		draw_set_alpha(1);
		draw_set_colour(c_red);
		draw_rectangle(WC_debugselected.x - 1, WC_debugselected.y - 1, WC_debugselected.x + 1, WC_debugselected.y + 1, false);
		
		draw_set_alpha(1);
	}
}
draw_set_color(c_white)

// creating object
if WC_creatingobj
{
	if !sprite_exists(object_get_sprite(WC_tempobj))
	{
		draw_set_valign(fa_middle);
		draw_text(floor(mouse_x / WC_draggrid) * WC_draggrid, floor(mouse_y / WC_draggrid) * WC_draggrid, "Spawn Here");
		draw_set_valign(fa_top);
	}
	else
		draw_sprite_ext(object_get_sprite(WC_tempobj), 0, floor(mouse_x / WC_draggrid) * WC_draggrid, floor(mouse_y / WC_draggrid) * WC_draggrid, 1, 1, 0, c_white, 0.5);
}

// dragging
if instance_exists(WC_dragobj)
{
	if sprite_exists(WC_dragobj.sprite_index)
	{
		// pt exclusive
		if variable_instance_exists(WC_dragobj, "xscale")
		{
			if variable_instance_exists(WC_dragobj, "yscale")
				draw_sprite_ext(WC_dragobj.sprite_index, WC_dragobj.image_index, WC_dragobj.x, WC_dragobj.y, WC_dragobj.xscale, WC_dragobj.yscale, WC_dragobj.image_angle, WC_dragobj.image_blend, 0.75);
			else
				draw_sprite_ext(WC_dragobj.sprite_index, WC_dragobj.image_index, WC_dragobj.x, WC_dragobj.y, WC_dragobj.xscale, WC_dragobj.image_yscale, WC_dragobj.image_angle, WC_dragobj.image_blend, 0.75);
		}
		else if variable_instance_exists(WC_dragobj, "yscale")
			draw_sprite_ext(WC_dragobj.sprite_index, WC_dragobj.image_index, WC_dragobj.x, WC_dragobj.y, WC_dragobj.image_xscale, WC_dragobj.yscale, WC_dragobj.image_angle, WC_dragobj.image_blend, 0.75);
		else
			draw_sprite_ext(WC_dragobj.sprite_index, WC_dragobj.image_index, WC_dragobj.x, WC_dragobj.y, WC_dragobj.image_xscale, WC_dragobj.image_yscale, WC_dragobj.image_angle, WC_dragobj.image_blend, 0.75);
	}
	
	// mask
	if WC_debugselected != WC_dragobj
	{
		draw_set_colour(c_red);
		draw_set_alpha(0.25);
		with WC_dragobj
			draw_mask();
		draw_set_alpha(1);
	}
}

// fake dragging
if WC_fakedragobj != noone
{
	if sprite_exists(WC_fakedragobj.sprite_index)
	{
		// pt exclusive
		if variable_instance_exists(WC_fakedragobj, "xscale")
		{
			if variable_instance_exists(WC_fakedragobj, "yscale")
				draw_sprite_ext(WC_fakedragobj.sprite_index, WC_fakedragobj.image_index, (floor((mouse_x - WC_moffsetx) / WC_draggrid) * WC_draggrid), (floor((mouse_y - WC_moffsety) / WC_draggrid) * WC_draggrid), WC_fakedragobj.xscale, WC_fakedragobj.yscale, WC_fakedragobj.image_angle, WC_fakedragobj.image_blend, 0.75);
			else
				draw_sprite_ext(WC_fakedragobj.sprite_index, WC_fakedragobj.image_index, (floor((mouse_x - WC_moffsetx) / WC_draggrid) * WC_draggrid), (floor((mouse_y - WC_moffsety) / WC_draggrid) * WC_draggrid), WC_fakedragobj.xscale, WC_fakedragobj.image_yscale, WC_fakedragobj.image_angle, WC_fakedragobj.image_blend, 0.75);
		}
		else if variable_instance_exists(WC_fakedragobj, "yscale")
			draw_sprite_ext(WC_fakedragobj.sprite_index, WC_fakedragobj.image_index, (floor((mouse_x - WC_moffsetx) / WC_draggrid) * WC_draggrid), (floor((mouse_y - WC_moffsety) / WC_draggrid) * WC_draggrid), WC_fakedragobj.image_xscale, WC_fakedragobj.yscale, WC_fakedragobj.image_angle, WC_fakedragobj.image_blend, 0.75);
		else
			draw_sprite_ext(WC_fakedragobj.sprite_index, WC_fakedragobj.image_index, (floor((mouse_x - WC_moffsetx) / WC_draggrid) * WC_draggrid), (floor((mouse_y - WC_moffsety) / WC_draggrid) * WC_draggrid), WC_fakedragobj.image_xscale, WC_fakedragobj.image_yscale, WC_fakedragobj.image_angle, WC_fakedragobj.image_blend, 0.75);
	}
	
	// mask
	draw_set_colour(c_aqua);
	draw_set_alpha(0.25);
	var xoffset = -WC_fakedragobj.x + (floor((mouse_x - WC_moffsetx) / WC_draggrid) * WC_draggrid);
	var yoffset = -WC_fakedragobj.y + (floor((mouse_y - WC_moffsety) / WC_draggrid) * WC_draggrid);
	
	with WC_fakedragobj
		draw_mask(x + xoffset, y + yoffset);
	draw_set_alpha(1);
}

// selecting
if WC_selectobj != 0
{
	draw_set_valign(fa_middle);
	switch WC_selectobj
	{
		case 1: // set
			draw_set_colour(c_white);
			break;
		case 2: // freeze
			draw_set_colour(merge_colour(c_white, c_aqua, 0.25));
			break;
		case 3: // script
			draw_set_colour(c_ltgray);
			break;
		case 4: // debug
			draw_set_colour(merge_colour(c_white, c_orange, 0.25));
			break;
		case 6: // monitor
			draw_set_colour(merge_colour(c_white, c_lime, 0.25));
			break;
		
		default:
			draw_set_colour(c_gray);
			break;
	}
	
	if !instance_exists(WC_tempobj)
		draw_text(mouse_x, mouse_y, "Select Object");
	else
		draw_text(mouse_x + choose(1, -1), mouse_y, object_get_name(WC_tempobj.object_index));
	
	draw_set_valign(fa_top);
}