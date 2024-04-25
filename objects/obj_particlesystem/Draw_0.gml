// afterimages
with obj_mach3effect
{
	var alpha = image_alpha;
	if sugary
		alpha = min(alpha, 0.825);
	if sprite_exists(sprite_index) && visible && !(!other.aftvis && sugary)
	{
		if sugary
		{
			shader_set(shd_afterimage);
			shader_set_uniform_f(other.blendcolor1, color_get_red(image_blend) / 255, color_get_green(image_blend) / 255, color_get_blue(image_blend) / 255);
			shader_set_uniform_f(other.blendcolor2, color_get_red(color2) / 255, color_get_green(color2) / 255, color_get_blue(color2) / 255);
		}
		draw_sprite_ext(sprite_index, floor(image_index), x, y, image_xscale, image_yscale, image_angle, sugary ? c_white : image_blend, alpha)
		if sugary
			shader_reset();
	}
	if sugary
	{
		image_alpha -= abs(1 - alpha) / 8;
		if image_alpha <= 0
			instance_destroy();
	}
}

aftimer--;
if aftimer <= 0
{
	if aftvis
	{
		aftimer = 3;
		aftvis = false;
	}
	else
	{
		aftimer = 3;
		aftvis = true;
	}
}

