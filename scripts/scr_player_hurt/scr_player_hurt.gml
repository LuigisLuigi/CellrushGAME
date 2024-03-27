function scr_player_hurt()
{
	if sprite_index = spr_hurtjump
		hsp = xscale * movespeed
	if sprite_index = spr_hurt
		hsp = -xscale * movespeed
	
	if movespeed > 0 && global.gameplay == 0
		movespeed -= 0.1
	
	freefallsmash = 0
	combo = 0
	mach2 = 0
	bounce = false
	jumpAnim = true
	dashAnim = true
	
	landAnim = !grounded
	
	jumpstop = false
	moveAnim = true
	stopAnim = true
	crouchslideAnim = true
	crouchAnim = false
	machhitAnim = false

	hurted = true
	turning = false
	skateboarding = false
	
	alarm[5] = 2
	alarm[7] = global.gameplay == 0 ? 60 : 20 
	
	if grounded && vsp > 0
	{
		if global.gameplay == 0
			vsp = -4
		else
		{
			movespeed = 0
			state = states.normal
		}
	}

	if scr_solid(x + hsp, y)
	{
		if global.gameplay == 0
			xscale *= -1
		else
			movespeed = 0
	}
	image_speed = 0.35
}