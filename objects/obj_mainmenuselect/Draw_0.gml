if loading
{
	draw_set_font(global.bigfont);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text((960 / 2) + random_range(-1, 1), 540 / 2, "LOADING");
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	if debug
	{
		if draw_editorbutton(64, 128, "SKIP")
		{
			instance_destroy(obj_gms);
			offline_travel();
		}
	}
}