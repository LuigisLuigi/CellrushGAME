/// @description collect
var collect = heat_calculate(10);

global.collect += collect;
with instance_create(x + 16, y, obj_smallnumber)
	number = string(collect);

scr_soundeffect(sfx_collecttopping);
create_collect(x, y, sprite_index);
	
instance_destroy();
scr_failmod(mods.no_toppings);

if player && player.character == "V" 
	global.playerhealth = clamp(global.playerhealth + 1, 0, 100);
global.heattime = clamp(global.heattime + 10, 0, 60);

if global.gameplay != 0
{
	global.combotime += 10
	global.combotime = clamp(global.combotime, 0, 60)
}
