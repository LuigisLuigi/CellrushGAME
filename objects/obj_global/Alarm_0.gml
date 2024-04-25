/// @description increase pizzacoin
if instance_exists(obj_pause) && obj_pause.pause
{
	// postpone
	alarm[0] = 1;
	exit;
}

var increase = floor(global.collect / 2000)
if increase > 0
{
	scr_soundeffect(sfx_pizzacoin)
	global.pizzacoin += increase
}

