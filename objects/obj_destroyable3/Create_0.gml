event_inherited()
depth = 1

if check_sugary()
	sprite_index = spr_bigdestroyable_ss;
else if global.gameplay == 0
	sprite_index = spr_bigdestroyable;

momentum = [0, 0];
