with object
	repeat 8 with instance_create(x + random_range(50, -50), y + random_range(50, -50), obj_cloudeffect)
		sprite_index = spr_teleporteffect

with player
{
	visible = true
	state = other.storedstate
	movespeed = other.storedmovespeed
	grav = other.storedgrav
	image_index = other.storedimageindex
	sprite_index = other.storedspriteindex
}

instance_destroy()