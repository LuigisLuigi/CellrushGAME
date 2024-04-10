if disconnected
{
	draw_set_alpha(0.5);
	if sprite_exists(pausebg)
		draw_sprite_ext(pausebg, 0, 0, 0, 0.5, 0.5, 0, c_white, 1);
	else
		draw_set_alpha(1);
	
	draw_set_colour(c_black);
	draw_rectangle(0, 0, 960, 540, false);
	draw_set_alpha(1);
	
	draw_set_font(global.bigfont);
	draw_set_halign(fa_center);
	draw_set_colour(c_white);
	draw_text_auto(960 / 2 + random_range(-1, 1), 240, "Controller Disconnected!");
	
	var desc = "Press any button to continue.";
	if room == rm_mariohell
		desc = "Looking for secrets?";
	if room == rm_msdosjokesequence
		desc = "You were so mesmerized by Denchicksploit v0.6 that you\njumped and unplugged your controller on accident.";
	
	draw_set_font(global.font_small);
	draw_text(960 / 2, 280, desc);
}
else if sprite_exists(pausebg)
	sprite_delete(pausebg);

