depth = 1

if global.gameplay == 0
	sprite_index = spr_destroyable;
if check_sugary()
	sprite_index = spr_destroyable_ss;

momentum = [0, 0];
