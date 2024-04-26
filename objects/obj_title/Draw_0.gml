// non patron
if !patron && object_index == obj_title
{
	pal_swap_set(spr_peppalette, 1, false);
	
	// file 1
	selimg += 0.35;
	if sel == 0
	{
		draw_sprite_ext(selected ? spr_file1confirm : spr_file1, selimg, 192, 402, 1, 1, 0, c_white, 1);
		with obj_menuphone
			sprite_index = spr_phonepicked;
	}
	else with obj_menuphone
	{
		sprite_index = spr_phone;
		image_speed = 0.35;
	}
	
	// file 2
	draw_sprite_ext(sel == 1 ? spr_file2 : spr_file2empty, selimg, 457, 402, 1, 1, 0, c_white, 1);
	
	// file 3
	draw_sprite_ext(sel == 2 ? spr_file3 : spr_file3empty, selimg, 841, 402, 1, 1, 0, c_white, 1);
	
	pal_swap_reset();
}

// menu light
/*
if object_index == obj_title
{
	draw_set_colour(#F8D0D0);
	draw_triangle(obj_player.x - 100, room_height, obj_player.x + 100, room_height, room_width / 2, -270, false);
}
*/

// draw self
draw_sprite_ext(sprite_index, -1, round(x), round(y), image_xscale, image_yscale, image_angle, image_blend, image_alpha);

