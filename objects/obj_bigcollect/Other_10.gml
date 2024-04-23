/// @description collect
audio_stop_sound(sfx_collectpizza);
scr_soundeffect(sfx_collectpizza);

global.heattime = 60
if global.gameplay != 0
	global.combotime = 60

var val = heat_calculate(100)
global.collect += val;

with instance_create(x + 16, y, obj_smallnumber)
	number = string(val);
create_collect(x, y, sprite_index);

instance_destroy();
scr_failmod(mods.no_toppings);

tv_do_expression(spr_tv_exprcollect)
