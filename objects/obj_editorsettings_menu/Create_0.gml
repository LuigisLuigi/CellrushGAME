/// @description 
depth = -10000;
for(var i = 0; i < 3; i++) {
	with instance_create_layer(x + 32, y + 64 + (48*i), "Buttons", obj_editor_button) {
		depth = -10001;
		func = 3;
		index = i;
		sprite_index = spr_settings_button;
	}
}

with instance_create_layer(x + (32*9), y, "Buttons", obj_editor_button) {
	depth = -10001;
	func = 4;
	index = 0;
	sprite_index = spr_exit_button;
}