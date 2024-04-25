// grinch bg
if string_startswith(room_get_name(room), "grinch_") && room != grinch_10
{
	depth = layer_get_depth("Backgrounds_1") - 1;
	
	if uTime == -1
		uTime = shader_get_uniform(shd_wind, "Time");
	
	shader_set(shd_wind);
	shader_set_uniform_f(uTime, current_time / 1000);
	draw_sprite_tiled(bg_grinch_santa, 0, _camx * 0.25, _camy * 0.25);
	shader_reset();
	
	if global.panicbg
	{
		draw_set_colour(c_red);
		draw_set_alpha((global.wave / global.maxwave) / 3);
		draw_rectangle(_camx - 32, _camy - 32, _camx + _camw + 32, _camy + _camh + 32, false);
		draw_set_alpha(1);
	}
}
