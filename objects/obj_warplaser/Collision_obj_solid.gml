if visible
{
	repeat 4 with instance_create(x + random_range(40, -40), y + random_range(40, -40), obj_cloudeffect)
		sprite_index = spr_teleporteffect
	instance_destroy()
}

