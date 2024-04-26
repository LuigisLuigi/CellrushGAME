/// @description 
cx = camera_get_view_x(view_camera[0]);
cy = camera_get_view_y(view_camera[0]);

var mx = display_mouse_get_x();
var my = display_mouse_get_y();

if mouse_check_button(mb_middle) {
	cx += (mouse_xprevious - mx) *.5;
	cy += (mouse_yprevious - my) *.5;
}

mouse_xprevious = mx;
mouse_yprevious = my;

if keyboard_check(ord("W")) {
	cy -= spd;
}
if keyboard_check(ord("S")) {
	cy += spd;
}
if keyboard_check(ord("A")) {
	cx -= spd;
}
if keyboard_check(ord("D")) {
	cx += spd;
}

if keyboard_check_pressed(ord("E")) or (keyboard_check(vk_control) && mouse_wheel_down()) {
	if zoom < 8 {
		zoom += 0.5;
	}
}
if keyboard_check_pressed(ord("Q")) or (keyboard_check(vk_control) && mouse_wheel_up()) {
	if zoom < 8 {
		zoom -= 0.5;
	}
}

camera_set_view_pos(view_camera[0], cx, cy);
camera_set_view_size(view_camera[0], view_w * zoom, view_h * zoom);

with obj_editor_button {
	zoom = other.zoom;
	x = camera_get_view_x(view_camera[0]) + xstart * zoom;
	y = camera_get_view_y(view_camera[0]) + ystart * zoom;
	
	image_xscale = 1 *zoom;
	image_yscale = 1 *zoom;
}
with obj_editorsettings_menu {
	zoom = other.zoom;
	x = camera_get_view_x(view_camera[0]) + xstart * zoom;
	y = camera_get_view_y(view_camera[0]) + ystart * zoom;
	
	image_xscale = 1 *zoom;
	image_yscale = 1 *zoom;
}

if global.optimize == 1 {
	instance_deactivate_object(obj_baddiecollisionbox);
	instance_deactivate_object(obj_baddie);
	instance_deactivate_object(obj_tiles);

	instance_activate_region(cx, cy, view_w, view_h, true);
}
else if global.optimize == 2 {
	instance_activate_all();
	global.optimize = 0;
}