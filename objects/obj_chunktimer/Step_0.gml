if global.gameplay == 0
	exit;

if global.panic && global.fill > 0 && !instance_exists(obj_secretfound)
    global.fill -= fillrate
if global.fill <= 0 && global.panic && !instance_exists(obj_pizzaface)
    instance_create(obj_player.x, obj_player.y, obj_pizzaface)
global.fill = clamp(global.fill, 0, obj_tv.chunkmax)
