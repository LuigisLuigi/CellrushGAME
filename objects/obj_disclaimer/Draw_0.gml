if con == -1
{
	if showwait
	{
		draw_set_colour(c_white);
		draw_set_font(global.font_small);
		draw_set_align(fa_center, fa_middle);
		draw_text(room_width / 2, room_height / 2, lang_string("load.unusual"));
		if debug
			draw_text(room_width / 2, room_height / 2 + 100, "You're in debug mode though, so just\npress Z to skip this if you want.");
	}
}
else
	showwait = false;

// roundrect
draw_set_colour($222222);

var xx = 50 * size;
var yy = 50 * size;
var xsiz = (960 / 2) * (1 - size);
var ysiz = (540 / 2) * (1 - size);
var rectsize = 5;

draw_roundrect_ext(xx + xsiz, yy + ysiz, 960 - xx - xsiz, 540 - yy - ysiz, 12, 12, false);
draw_set_colour(c_black);
draw_roundrect_ext(xx + xsiz + rectsize, yy + ysiz + rectsize, 960 - xx - xsiz - rectsize, 540 - yy - ysiz - rectsize, 12, 12, false);

if con == 1
{
	// disclaimer
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);

	draw_set_colour(merge_colour(c_red, c_white, 0.25));
	draw_set_font(global.bigfont);
	draw_text_auto((960 / 2) + random_range(-1, 1), 100, lang_string("disclaimer.title"));
	
	// actual text
	draw_set_colour(c_white);
	draw_set_font(font1);
	//draw_text(960 / 2, 160, "This mod has Patreon exclusive content. If you are not a Patron of PizzaTowerGuy\nand do not want to be associated with leaks, it is recommended to stop playing,\notherwise they will come to your house and personally beat you to death.\n\nThis mod's creator has also had past history in being absolutely despised,\nso it is also recommended to not talk about it in the Pizza Tower community.\nThis mod is made by loypoll.");
	//draw_text(960 / 2, 160, "This mod makes use of a leaked build of the game. This goes against\nthe Pizza Tower's Discord rules.\n\nIf you don't want JhonnyKiller45 to kick your ass\nthen do not play this mod.");
	draw_text(960 / 2, 160, str);
	
	if cancon or !drm
	{
		draw_set_font(global.font_small);
		draw_text(960 / 2, 420, lang_string("disclaimer.continue"));
	}
}
