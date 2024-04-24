/// @description fadeout
if instance_exists(obj_gms)
{
	if !gms_info_isconnected()
	{
		if !global.__socket_connecting
		{
			scr_soundeffect(sfx_enemyprojectile)
			with obj_roomname
			{
				message = "CANNOT CONNECT TO NETWORK";
				showtext = true;
				alarm[0] = 200;
			}
			
			loading = false;
			obj_file1.sprite_index = spr_file1
			selected = false
		}
		else
			alarm[3] = 1;
	}
	else
	{
		loading = false;
		with instance_create(x,y,obj_fadeout)
			obj_player.targetRoom = characterselect
	}
}
else
{
	loading = true;
	instance_create_depth(0, 0, 0, obj_gms);
	alarm[3] = 1;
}