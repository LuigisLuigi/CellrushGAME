// culling
if scr_culling()
	exit;

// Draw
haspalette = (object_index == obj_cheeseslime or object_index == obj_forknight or object_index == obj_pepgoblin or object_index == obj_pizzard or object_index == obj_thug_blue or object_index == obj_thug_green or object_index == obj_sausageman or object_index == obj_minijohn or object_index == obj_swedishmonkey or object_index == obj_googlyjuice);
if haspalette && !flash
	pal_swap_set(spr_palette, paletteselect, false)

var aggr = false;
if sugaryenemy
{
	with obj_player
	{
		if sprite_index == spr_taunt && distance_to_object(other) <= 960 / 2
			aggr = true;
	}
}

var drawx = x + (aggr * random_range(-2, 2)), drawy = y + (1 - yscale) * (50 - 4) + (aggr * random_range(-2, 2));
draw_set_flash(flash);
draw_sprite_ext(sprite_index, image_index, drawx, drawy, image_xscale * xscale, image_yscale * yscale, img_angle, image_blend, image_alpha);
draw_set_flash(false);

if haspalette
	pal_swap_reset()

if aggr
{
	aggrimg += 0.35;
	draw_sprite_ext(spr_angrycloud, aggrimg, drawx, drawy, 1, 1, img_angle, c_white, image_alpha); 
}

// attacked with cotton transfo
if cottoncoated
{
	draw_set_flash(true, #FF8BDC);
	draw_sprite_ext(sprite_index, image_index, drawx, drawy, image_xscale * xscale, image_yscale * yscale, img_angle, c_white, 0.5);
	draw_set_flash(false);
}
