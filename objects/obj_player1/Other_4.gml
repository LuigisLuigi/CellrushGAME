event_inherited();

// correct online position
if check_online()
{
	gms_self_set("x", x);
	gms_self_set("y", y);
}

// baddie tombs
if !ds_list_empty(global.baddietomb)
{
	for(var i = 0; i < ds_list_size(global.baddietomb); i++)
	{
		var arr = ds_list_find_value(global.baddietomb, i);
		var tombRoom = arr[0];
		var X = arr[1];
		var Y = arr[2];
		var spr = arr[3];
		
		if !is_undefined(tombRoom) && !is_undefined(X) && !is_undefined(Y)
		{
			if room == tombRoom
			{
				with instance_create(X, Y, obj_baddiegibsstick)
				{
					storedx = X;
					storedy = Y;
					grounded = true;
					hsp = 0;
					vsp = 0;
					saveable = false;
					
					image_index = image_number - 1;
					if !is_undefined(spr)
						sprite_index = spr;
				}
			}
		}
	}
}