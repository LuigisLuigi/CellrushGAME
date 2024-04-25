/// @description show fps & mod hud
// fps count
if global.showfps
{
	draw_set_font(global.font_small);
	draw_set_colour(c_white);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	
	draw_text_transformed(960 - 10, 540 - 10, string(fps), 1, 1, 0);
}

// topping counter
if global.modifier == mods.no_toppings && !instance_exists(obj_choicebase) && !(instance_exists(obj_pause) && (obj_pause.pause or obj_pause.pausefad == 2 or obj_pause.pausefad == 4))
{
	draw_set_font(global.bigfont);
	draw_set_colour(global.failedmod ? c_red : c_white);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	// text position
	var yy = min(obj_tv.yi - 70 - (check_sugary() * 10), 540 - 60);
	var xx = 960 / 2;
	if global.panic && global.gameplay != 0
		xx += 75;
	
	// topping count
	var str = " X" + string(global.toppings);
	draw_text(xx, yy, str);
	
	// topping sprite
	if sprite_exists(toppingsprite)
	{
		topimg = (topimg + 0.35) % sprite_get_number(toppingsprite);
		draw_sprite_ext(toppingsprite, topimg, xx - floor(string_width(str) / 2) - 4, yy, 1, 1, 0, c_white, 1);
	}
	else
		event_user(0);
}

// reset font alignment
draw_set_halign(fa_left);
draw_set_valign(fa_top);

