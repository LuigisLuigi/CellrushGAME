/// @description
if vsp < 20
	vsp += grav;
y += vsp;

if y >= ystart
{
	y = ystart;
	if !grounded
	{
		if !(instance_exists(obj_manual) && obj_manual.open) && !instance_exists(obj_option) && !instance_exists(obj_erasegame)
		{
			scr_soundeffect(sfx_breakblock2)
			with obj_camera
			{
				shake_mag = 5;
				shake_mag_acc = 5 / room_speed;
			}
		}
		
		grounded = true;
		vsp = -6;
		repeat 8
			instance_create(irandom_range(bbox_left, bbox_right), bbox_bottom, obj_debris);
		
		if object_index == obj_title
		{
			with obj_player
			{
				state = states.backbreaker;
				sprite_index = spr_bossintro;
				image_index = 0;
				image_speed = 0.35;
				vsp = -4;
			}
		}
	}
	else
	{
		grav = 0;
		vsp = 0;
	}
}

// not patron
if !patron
{
	with obj_player
	{
		state = -1;
		x = -1000;
	}
	
	if !selected && !instance_exists(obj_option)
	{
		// change selection
		scr_getinput(true);
		var move = key_left2 + key_right2;
		
		if move != 0
		{
			sel += move;
			
			var clamped = clamp(sel, 0, 2);
			if sel == clamped
				scr_soundeffect(sfx_step);
			else
				sel = clamped;
		}
	
		with obj_tv
		{
			message = lang_string("msg.titlesel." + string(other.sel));
			showtext = true;
			alarm[0] = 2;
		}
		
		// select
		if key_jump
		{
			switch sel
			{
				case 0:
					if !os_is_network_connected()
					{
						scr_soundeffect(sfx_enemyprojectile);
						with obj_roomname
						{
							message = "CONNECT TO NETWORK";
							showtext = true;
							alarm[0] = 200;
						}
					}
					else
					{
						scr_soundeffect(sfx_collecttoppin);
						selected = true;
						alarm[1] = 50;
					}
					break;
				case 1:
					scr_soundeffect(sfx_collecttoppin);
					instance_create(0, 0, obj_option);
					break;
				case 2:
					game_end();
					break;
			}
		}
	}
}

// background
if object_index == obj_title
{
	var lay_id = layer_get_id("Backgrounds_1");
	var back_id = layer_background_get_id(lay_id);
	
	if patron
	{
		with obj_player1
		{
			if x <= 242
				layer_background_index(back_id, 0);
		
			if x >= 352 && x <= 562
				layer_background_index(back_id, 1);
		
			if x >= 704
				layer_background_index(back_id, 2);
		}
	}
	else
		layer_background_index(back_id, sel);
}

