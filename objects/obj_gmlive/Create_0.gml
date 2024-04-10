/// @description gmlive by yellowafterlife
#macro live_enabled debug
if !live_enabled
{
	instance_destroy();
	exit;
}

// this is a simple safeguard against making multiple obj_gmlive instances
if instance_number(object_index) > 1
{
	var find = instance_find(object_index, 0);
	if id != find.id
	{
		instance_destroy();
		exit;
	}
}

// change the IP/port here if gmlive-server isn't running on the same device as the game
// (e.g. when running on mobile platforms):
live_init(1, "http://localhost:5100", "");
alarm[0] = 1;

// please
/*
for (var i = 100001; script_exists(i); i++) {
	var s = script_get_name(i);
	if (gml_func_sig.h_exists(s)) continue;
	gml_func_add(":::" + s + "(...):", i);
}

