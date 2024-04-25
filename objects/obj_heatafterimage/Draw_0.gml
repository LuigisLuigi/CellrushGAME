exit;

var t = obj_player1;
if !instance_exists(t)
	exit;

if !surface_exists(surf)
	surf = surface_create(960, 540);
else
{
	var camx = camera_get_view_x(view_camera[0]);
	var camy = camera_get_view_y(view_camera[0]);
	
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	pal_swap_set(t.spr_palette, t.paletteselect, false);
	draw_sprite_ext(t.drawspr, t.image_index, x - camx, y - camy, t.xscale, t.yscale, t.img_angle, t.image_blend, 1);
	pal_swap_reset();
	surface_reset_target();
	
	draw_surface_ext(surf, camx, camy, 1, 1, 0, c_white, alpha);
}
