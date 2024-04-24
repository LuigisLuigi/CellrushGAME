if selected = false
&& !(instance_exists(obj_wc) && obj_wc.WC_consoleopen)
{
	
	//Manual
	if keyboard_check_pressed(vk_f5)
	{
	instance_create(0,0,obj_manual)
	selected = true
	}

//Select
if (obj_player1.key_right2  or keyboard_check_pressed(vk_right)) && optionselected < 2
{
optionselected +=1
scr_soundeffect(sfx_step)
}
else if (-obj_player1.key_left2 or keyboard_check_pressed(vk_left)) && optionselected > 0
{
optionselected -=1
scr_soundeffect(sfx_step)
}



if (obj_player1.key_jump or keyboard_check_pressed(vk_enter)) && optionselected = 0
{
	if !os_is_network_connected()
	{
		scr_soundeffect(sfx_enemyprojectile)
		with obj_roomname
		{
			message = "CONNECT TO NETWORK";
			showtext = true;
			alarm[0] = 200;
		}
	}
	else
	{
		scr_soundeffect(sfx_collecttoppin)
		obj_file1.sprite_index = spr_file1confirm
		selected = true
		alarm[0] = 50
	}
	
}
if (obj_player1.key_jump or keyboard_check_pressed(vk_enter)) && optionselected = 1
{
scr_soundeffect(sfx_collecttoppin)
	selected = true
	alarm[1] = 5
}
if (obj_player1.key_jump or keyboard_check_pressed(vk_enter)) && optionselected = 2
{
scr_soundeffect(sfx_collecttoppin)
	selected = true
	alarm[2] = 5
}


}

var lay_id = layer_get_id("Backgrounds_2");
var back_id = layer_background_get_id(lay_id);
layer_background_index(back_id, optionselected);

if alarm[3] <= 1 && alarm[3] != -1 && !instance_exists(obj_gms)
	instance_create_depth(0, 0, 0, obj_gms);