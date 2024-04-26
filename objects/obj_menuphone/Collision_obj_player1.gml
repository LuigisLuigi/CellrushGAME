if other.key_up2 && other.state == states.normal && !instance_exists(obj_option)
{
	if room != Realtitlescreen && !instance_exists(obj_wc)
		room_goto(room_of_dog);
	else
	{
		scr_soundeffect(sfx_collecttoppin);
		instance_create(0, 0, obj_option);
	
		other.sprite_index = other.spr_idle;
		other.state = -1;
		other.hsp = 0;
		other.vsp = 0;
	}
}
