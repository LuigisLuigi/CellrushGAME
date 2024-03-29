function scr_collide_destructibles()
{
	if (state == states.jump && sprite_index == spr_playerN_noisebombspinjump)
	or (state == states.pogo && pogochargeactive)
	or (state == states.knightpep && global.gameplay != 0)
	or state == states.slipbanan
	{
		with instance_place(x + hsp + xscale, y, obj_destructibles)
		{
			gp_vibration(0.8, 0.8, 0.5);
			momentum[0] = other.hsp;
			instance_destroy();
		}
			
		with instance_place(x, y + vsp + 1, obj_destructibles) 
		{
			gp_vibration(0.8, 0.8, 0.5);
			momentum[1] = other.vsp;
			instance_destroy();
		}
			
		with instance_place(x, y + vsp - 1, obj_destructibles)
		{
			gp_vibration(0.8, 0.8, 0.5);
			momentum[1] = other.vsp;
			instance_destroy();
		}
	}
		
	// Destroy Destructibles
	if (character != "V" or state == states.tumble)
	&& place_meeting(x + hsp, y, obj_destructibles)
	{
		if state == states.handstandjump or state == states.mach2 or state == states.mach3
		or state == states.faceplant or state == states.rideweenie or state == states.tacklecharge
		or state == states.machroll or state == states.knightpepslopes or state == states.tumble
		or state == states.hookshot or state == states.crouchslide or state == states.cheeseball
		or state == states.rocket
		or (state == states.barrel && sprite_index == spr_barrelroll)
		or (state == states.punch && sprite_index != spr_breakdanceuppercut)
		or (state == states.firemouth && global.gameplay != 0)
		or (state == states.grab && sprite_index == spr_swingding)
		or (state == states.cotton && (sprite_index == spr_cotton_attack or movespeed > 6))
		{
			with instance_place(x + hsp, y, obj_destructibles)
			{
				if scr_stylecheck(2)
					momentum[0] = other.hsp;
				if inst_relation(self, obj_bigdestructibles) && (other.state == states.handstandjump or (other.state == states.mach2 && hp > 1))
				{
					// grab on big blocks
					if hp > 1 or global.gameplay == 0
					{
						with other
						{
							suplexmove = false;
							if !shotgunAnim or global.gameplay != 0 or character == "SP"
								scr_pummel();
							else
							{
								state = states.shotgun;
								image_index = 0;
								sprite_index = spr_shotgunshoot;
								
								if character != "N"
								{
									instance_create(x + xscale * 20, y + 20, obj_shotgunbullet);
									with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
										spdh = 4;
									with instance_create(x + xscale * 20, y + 20, obj_shotgunbullet)
										spdh = -4;
								}
							}
						}
					}
						
					hp--;
					if hp <= 0
						instance_destroy();
					else
						event_user(0);
				}
				else
					instance_destroy();
				gp_vibration(0.8, 0.8, 0.5);
			}
				
			if state == states.mach2
				machpunchAnim = true;
		}
	}
		
	// Pummel with cane
	if character == "SP" && shotgunAnim && (state == states.handstandjump or state == states.freefall or state == states.freefallland)
	{
		var shotty = instance_place(x + hsp, y + vsp, obj_shotgunblock);
		if shotty
		{
			with shotty
			{
				if scr_stylecheck(2)
					momentum[0] = other.hsp;
				instance_destroy();
			}
			scr_pummel();
			gp_vibration(0.8, 0.8, 0.5);
		}
	}
		
	// Destroy thrown (coop)
	if state == states.hurt && thrown
	{
		with instance_place(x - hsp, y, obj_destructibles)
			instance_destroy();
	}

	// Destroy from over
	if (state == states.knightpep or state == states.superslam or state == states.hookshot or (state == states.cotton && sprite_index == spr_cotton_drill)) && vsp >= 0
	{
		with instance_place(x, y + 1, obj_destructibles)
		{
			gp_vibration(0.8, 0.8, 0.5);
			instance_destroy();
			momentum[1] = other.vsp;
		}
	}
		
	// Destroy from under
	if (vsp <= grav or state == states.Sjump) && (state == states.jump or state == states.pogo or state == states.climbwall or state == states.fireass or state == states.Sjump or state == states.mach1 or state == states.mach2 or state == states.mach3 or state == states.punch)
	{
		var checker = -1;
		if state == states.punch && sprite_index == spr_breakdanceuppercut
			checker = vsp;
			
		var block = instance_place(x, y + checker, obj_destructibles);
		if block
		{
			if state == states.Sjump
				vsp = -11;
				
			with block
			{
				gp_vibration(0.8, 0.8, 0.5);
				instance_destroy();
				momentum[1] = other.vsp;
			}
				
			if state != states.Sjump && state != states.climbwall
				vsp = 0;
		}
	}

	// Freefall destroy
	if vsp >= 0 && (state == states.freefall or state == states.freefallland)
	{
		var block = instance_place(x, y + vsp + 2, obj_destructibles);
		if block
		{
			with block
				if place_meeting(x, y, obj_platform) block = false;
		}
		if block
		{
			if inst_relation(block, obj_bigdestructibles)
			&& (freefallsmash <= 10 or global.gameplay == 0)
			{
				if !shotgunAnim
					sprite_index = spr_bodyslamland
				else
					sprite_index = spr_shotgunjump2
				state = states.freefallland
				image_index = 0
			}
				
			with block
			{
				gp_vibration(0.8, 0.8, 0.5);
				momentum[1] = other.vsp;
				instance_destroy();
			}
		}
	}
	
	// break rat from above
	if vsp >= 0 && sprite_index == spr_cotton_drill
	{
		with instance_place(x, y + vsp, obj_ratblock)
	        instance_destroy()
	}

	// Superslam destroy metal
	if state == states.freefallland
	{
		if place_meeting(x, y + 1, obj_metalblock) && freefallsmash >= 10
		{
			with instance_place(x, y + 1, obj_metalblock)
			{
				momentum[1] = other.vsp;
				instance_destroy();
			}
		}
	}
	
	// Superjump destroy metal
	if state == states.Sjump && (springsjump or check_sugary())
	{
		if place_meeting(x, y - 1, obj_metalblock)
		{
			with instance_place(x, y - 1, obj_metalblock)
			{
				momentum[1] = other.vsp;
				instance_destroy();
			}
		}
	}
	
	// Cheese platforms
	if floor(hsp) == 0
	{
		with obj_destructibleplatform
		{
			if place_meeting(x, y - 1, other)
			{
				if !falling
				{
					falling = true;
					sprite_index = spr_dissolve;
					image_index = 0;
				}
			}
		}
	}
	
	// Destroy tnt block
	var block = instance_place(x + hsp, y, obj_tntblock);
	if block && ((state == states.firemouth && global.gameplay != 0) or (state == states.handstandjump && global.gameplay == 0))
	{
		with block
		{
			if scr_stylecheck(2)
				momentum[0] = other.hsp;
			instance_destroy();
		}
	}
		
	// Roll blocks
	if (state == states.tumble or ((state == states.mach2 or state == states.mach3) && sprite_index == spr_snick_tumble))
	&& place_meeting(x + hsp, y, obj_rollblock)
	{
		with instance_place(x + hsp, y, obj_rollblock)
		{
			if scr_stylecheck(2)
				momentum[0] = other.hsp;
			instance_destroy();
		}
	}
}
