function scr_player_bump()
{
	if sprite_index == spr_player_wallsplat
    {
		movespeed = 0
        hsp = 0
        vsp = 0
        if floor(image_index) == image_number - 1
            state = states.normal
        image_speed = 0.35
		exit;
	}
	
	movespeed = 0
	mach2 = 0
	landAnim = false
	
	start_running = true
	alarm[4] = 14
	
	if grounded && vsp >= 0
	{
		var railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then hsp = railmeet.spdh;
		
		if character == "SP"
			hsp = Approach(hsp, 0, 0.25);
		else
			hsp = 0;
	}
	
	var can_end = true;
	if sprite_index == spr_tumbleend
		can_end = !place_meeting(x, y, obj_pepgoblin_kickhitbox);
	if sprite_index == spr_tumbleend && (!grounded or !can_end) && !endtumble && global.gameplay != 0
		image_speed = 0;
	else
		image_speed = 0.35;
	
	if sprite_index == spr_rockethitwall && grounded
		image_index = image_number - 1;
	
	if floor(image_index) >= image_number - 1 && sprite_index != spr_player_catched && sprite_index != spr_boxxedpep_air
	{
		endtumble = false
		if !skateboarding
		{
			if sprite_index != spr_rockethitwall or grounded
				state = states.normal;
		}
		else
			state = states.mach2;
	}
	
	//Animations
	if sprite_index != spr_player_catched && sprite_index != spr_rockethitwall && sprite_index != spr_tumbleend && sprite_index != spr_hitwall
		sprite_index = ((!skateboarding) ? spr_bump : spr_clownbump);
}
