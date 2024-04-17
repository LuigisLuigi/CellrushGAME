with (obj_teleporter)
if trigger = other.trigger && start = 0
repeat (8) with instance_create(x+random_range(50,-50),y+random_range(50,-50),obj_cloudeffect)
sprite_index=  spr_teleporteffect

if player.storedstate == states.jump
{
	player.visible = true
	player.state = states.jump
	player.movespeed = 0
	player.grav = 0.5
	player.image_index = 0
	player.sprite_index = spr_player_fall
	player.jumpAnim = false
	player.freefallsmash = 0
	player.xscale = -image_xscale
	
	player.storedstate = states.normal
	
	with obj_music
		wait = false;
}
else
{
	player.visible = true
	player.state = storedstate
	player.movespeed = storedmovespeed
	player.grav = storedgrav
	player.image_index = storedimageindex
	player.sprite_index = storedspriteindex
	player.freefallsmash = storedfreefallsmash
}