// get all background layers in the room
ds_list_clear(global.roombgs);
var l = layer_get_all();
for (var i = 0; i < array_length(l); i++;)
{
	var lbg = layer_background_get_id(l[i]);
	if lbg != -1
	{
		if string_startswith(room_get_name(room), "grinch_")
			layer_set_visible(l[i], false);
		
		ds_list_add(global.roombgs, {
			lay : l[i],
			bg : lbg,
			x : layer_get_x(l[i]),
			y : layer_get_y(l[i]),
			hsp : layer_get_hspeed(l[i]),
			vsp : layer_get_vspeed(l[i]),
		});
	}
}

// coded in backgrounds
var roomname = room_get_name(room);
if !string_contains(roomname, "secret")
{
	// change color of entryway effect layer
	if string_startswith(roomname, "entryway_")
	{
		var layerfx = layer_get_fx("Effect_1");
		if layerfx != -1
		{
			if global.panic or room == entryway_11 // nighttime color
				fx_set_parameter(layerfx, "g_TintCol", [216 / 255, 183 / 255, 228 / 255, 1]);
			else // normal sunset color
				fx_set_parameter(layerfx, "g_TintCol", [255 / 255, 221 / 255, 204 / 255, 1]);
		}
	}

	// cottontown generate foreground
	if (string_startswith(roomname, "cotton_") && string_digits(roomname) != "" && real(string_digits(roomname)) < 4)
	or room == cotton_lap
	{
		var l = layer_create(-100, "Backgrounds_FG");
		var l2 = layer_background_create(l, bg_cotton5);
		layer_background_htiled(l2, true);
	
		ds_list_add(global.roombgs, {
			lay : l,
			bg : l2,
			x : 0,
			y : room_height - 540,
			hsp : -0.75,
			vsp : 0,
		});
	}

	// molasses swamp generate foreground
	if (string_startswith(roomname, "molasses_") && string_digits(roomname) != "" && real(string_digits(roomname)) < 7 && roomname != "molasses_6c")
	or room == molasses_lap
	{
		var l = layer_create(-100, "Backgrounds_FG");
		var l2 = layer_background_create(l, bg_molassesfg);
		
		layer_background_htiled(l2, true);
		layer_background_vtiled(l2, true);
		
		ds_list_add(global.roombgs, {
			lay : l,
			bg : l2,
			x : 0,
			y : 200,
			hsp : 0.35,
			vsp : 0,
		});
	}
}
