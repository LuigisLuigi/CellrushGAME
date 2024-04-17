/// @description drm
if debug or room == characterselect
	exit;

if !global.pastdisclaimer
	room_goto(room_of_dog);

if check_online()
{
	var ver = real(gms_ini_game_read("game", "version"));
	if ver > obj_gms.gameversion
	&& obj_gms.alarm[5] <= -1
		obj_gms.alarm[5] = 1;
	
	if !variable_global_exists("logged") or !global.logged
		room_goto(room_of_dog);
}
else
{
	if variable_global_exists("logged") && global.logged
		room_goto(room_of_dog);
}

/*
if room > characterselect && (!instance_exists(obj_gms)
or !variable_global_exists("optimize") or !variable_global_exists("logged")
or room_next(rm_load) != Realtitlescreen) && !debug
	room_goto(room_of_dog);