/// @description rebound projectile
if scr_stylecheck(2)
{
	var placer = instance_place(x, y, obj_enemybullet);
	if !placer
		placer = instance_place(x, y, obj_warplaser);
	
	if placer && placer.rebound
		event_perform(ev_collision, obj_shotgunbullet);
}
placer = instance_place(x, y, obj_junkenemy);
if placer && placer.rebound
{
	increase_combo();
	instance_destroy();
}

