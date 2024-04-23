if live_call() return live_result;

optionselected = 0
optionsaved_fullscreen = global.option_fullscreen
optionsaved_resolution = global.option_resolution
optionsaved_vibration = global.gamepadvibration
depth = -99

menu = 0;
menuto = -1;

mo = random(32);
c2 = make_colour_hsv((257 / 360) * 255, (39 / 100) * 255, (23 / 100) * 255);
curf = 0;
img = 0;
img2 = 0;

if !check_shaders()
	global.panicbg = false;

surf = -1;
bgsurf = -1;
trans = 0;

state = 0;
movespeed = 0;

dbg_live = false;
camy = 0;
camx = 0;
holdkey = -1;
holdkeyt = 0;
music = -1;
smoothcamx = 0;

roomname = noone;
if !instance_exists(obj_roomname)
	roomname = instance_create(0, 0, obj_roomname);

