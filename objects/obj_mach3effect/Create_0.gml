if obj_pause.pause
{
	instance_destroy();
	exit;
}
sync = check_bysync();

alarm[0] = 15
alarm[1] = 3
if !sync && check_online()
	alarm[10] = 2;

playerid = obj_player1
image_speed = 0
keep = false

sugary = false;
color2 = c_black;

randomize()
if !sync && scr_checkskin(checkskin.p_sage) or playerid.character == "S" or playerid.character == "PP"
	image_blend = choose(make_color_rgb(255, 0, 0), make_color_rgb(0, 255, 0));
else if playerid.character == "SP" && global.gameplay != 0
{
	sugary = true;
	
	var chooser = choose(0, 1);
	if chooser == 0
	{
		image_blend = make_colour_rgb(232, 80, 152);
		color2 = make_colour_rgb(95, 9, 32);
	}
	else
	{
		image_blend = make_colour_rgb(48, 168, 248);
		color2 = make_colour_rgb(15, 57, 121);
	}
	alarm[0] = -1;
	alarm[1] = -1;
}
else
	image_blend = choose(make_colour_rgb(96, 208, 72), make_colour_rgb(248, 0, 0));

if instance_exists(playerid)
{
	sprite_index = playerid.sprite_index;
	spr_palette = playerid.spr_palette;
	paletteselect = playerid.paletteselect;
}
else
{
	spr_palette = spr_peppalette;
	paletteselect = 0;
}

drawx = camera_get_view_x(view_camera[view_current]);
drawy = camera_get_view_y(view_camera[view_current]);

