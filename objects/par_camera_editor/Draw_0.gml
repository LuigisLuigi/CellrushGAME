/// @description 
draw_self();
if image_alpha == 0
{
	draw_set_color(c_red);
	for (var i = 0; i < 5; i++)
		draw_rectangle(x + i * 0.25, y + i * 0.25, x + sprite_width - i * 0.25, y + sprite_height - i * 0.25, 1)
	draw_set_color(c_white);
}

