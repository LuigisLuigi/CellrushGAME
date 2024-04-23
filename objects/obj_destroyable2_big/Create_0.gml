event_inherited()

if obj_player1.character == "N"
	sprite_index = spr_halloweenbigblock
else if obj_player1.character == "SP"
{
	sprite_index = spr_destroyable2big_ss
	if global.gameplay != 0
		sprite_index = spr_destroyable2big_NEW_ss
}
else if obj_player1.character == "PP"
	sprite_index = spr_bigbreakable_PP
else if global.gameplay == 0
	sprite_index = spr_bigbreakable

if string_startswith(room_get_name(room), "strongcold")
	sprite_index = spr_xmasbigblock

depth = 1
content = noone
image_speed = 0.35;
image_index = random(image_number);

momentum = [0, 0];

