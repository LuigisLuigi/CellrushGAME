y = -255;
collide = 0;
vsp = 0;
grav = 0;
grounded = false;

depth = 190;

image_speed = 0;
image_index = 0;
if global.fun == 0
	image_index = 1;

alarm[0] = room_speed;
if object_index == obj_title
{
	with obj_player
	{
		sprite_index = spr_file2;
		image_speed = 0.35;
	}
	with instance_create(xstart, ystart, obj_title2)
	{
		alarm[0] = room_speed * 2;
		depth = other.depth - 1;
	}
}

sel = 0;
selimg = 0;
selected = false;

