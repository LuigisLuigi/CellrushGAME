if room == rm_editor exit;

sprite_index = scr_collectsprite();
mask_index = global.gameplay == 0 ? spr_sausagecollect : spr_sausagecollect_NEW;
image_speed = 0.35;

depth = 2;
if scr_depthcheck()
	depth += 100;
ID = -1;

gotowardsplayer = false
movespeed = 5
player = noone
