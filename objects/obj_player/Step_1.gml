/// @description other??
// todo: figure out this shit later
if !patron
	global.gameplay = 0;

if !sugaryspire
{
	if (character == "SP" or character == "SN"
	or spr_idle == spr_playerSP_idle or spr_idle == spr_playerSN_idle)
		room_goto(room_of_dog);
}

// nuh uh! you are NOT touching the pufferfish
if (character == "PUFFER" or drawspr == spr_pufferfish_move or drawspr == spr_pufferfish_idle)
&& !debug
{
	room_goto(room_of_dog);
	exit;
}

// konami shit
if character == "PP" && !global.timeattack && state != states.backbreaker && object_index == obj_player1
{
	switch keyboard_lastkey
	{
		case vk_up:
			konami += "U";
			break;
		case vk_down:
			konami += "D";
			break;
		case vk_left:
			konami += "L";
			break;
		case vk_right:
			konami += "R";
			break;
		case global.key_jump:
			konami += "A";
			break;
		case global.key_slap:
			konami += "B";
			break;
	}
	if konami != "" && string_copy(konamiend, 1, string_length(konami)) != konami
		konami = "";
		
	if konami == konamiend
	{
		scr_soundeffect(sfx_vineboom);
		alarm[8] = 10;
		state = states.backbreaker;
		scr_baddie_screenclear();
		sprite_index = spr_playerPP_marior;
		
		keyboard_clear(keyboard_lastkey);
		konami = "";
	}
	keyboard_lastkey = -1;
}

