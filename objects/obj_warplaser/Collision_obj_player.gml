if place_meeting(x, y, obj_parryhitbox)
	exit;

player = other.object_index;
if global.gameplay == 0 && instance_exists(object)
{
	if player.state != states.backbreaker && player.state != states.gameover
	{
		player.visible = false
		storedstate = player.state
		storedmovespeed = player.movespeed
		storedgrav = player.grav
		storedimageindex = player.image_index
		storedspriteindex = player.sprite_index
		
		repeat 8 with instance_create(x + random_range(50, -50), y + random_range(50, -50), obj_cloudeffect)
		{
			sprite_index = spr_teleporteffect
			if check_online()
				gms_instance_sync(id, is_onetime | isc_local);
		}
		
		alarm[0] = 25
		vsp = 0
		hsp = 0
		player.grav = 0
		player.vsp = 0
		player.hsp = 0
		player.alarm[8] = 100
		player.alarm[5] = 2
		player.alarm[7] = 50
		player.hurted = true
		visible = false
		player.state = states.backbreaker
	}
}
else
	scr_hurtplayer(player);

