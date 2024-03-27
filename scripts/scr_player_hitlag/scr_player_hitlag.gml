function scr_player_hitlag()
{
	hsp = 0;
	vsp = 0;
	x = hitX + random_range(-4, 4);
	y = hitY + random_range(-4, 4);
	hitLag--;
	if key_jump
		input_buffer_jump = 0;
	
	image_speed = 0;
	if hitLag <= 0
	{
		x = hitX;
		y = hitY;
		movespeed = tauntstoredmovespeed;
		sprite_index = tauntstoredsprite;
		state = tauntstoredstate;
		vsp = tauntstoredvsp;
		
		if sprite_index == spr_player_ungroundedattack or sprite_index == spr_piledriverland
		{
			jumpAnim = true;
			state = states.jump;
			sprite_index = character == "SP" ? spr_machfreefall : spr_suplexland;
			vsp = -11;
			jumpstop = true;
			image_index = 0;
		}
		else if tauntstoredstate == states.handstandjump or tauntstoredstate == states.finishingblow
			state = states.normal;
	}
}

