if instance_number(object_index) >= 2
{
	trace("Extra obj_parallax in " + room_get_name(room));
	instance_destroy();
}
depth = 99;
uTime = -1;
global.roombgs = ds_list_create();
