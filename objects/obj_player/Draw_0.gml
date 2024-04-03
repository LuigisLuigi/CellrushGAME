//Draw
drawspr = sprite_index;
var _img = image_index;

// pln room color
var col = image_blend;
if room == hub_roomPLN
{
	var startgate = instance_place(x, y, obj_startgate);
	if !(startgate && startgate.image_index == 1)
		col = merge_colour(col, c_black, 0.4);
}

if state != states.cheeseball && state != states.cotton
{
	if scr_checkskin(checkskin.p_peter)
		drawspr = spr_player_petah;
	if scr_checkskin(checkskin.n_big)
		drawspr = spr_playerN_chungus;
	if scr_checkskin(checkskin.s_sbombic)
		drawspr = spr_sbombic;
	if character == "PUFFER"
	{
		if x != xprevious
			drawspr = spr_pufferfish_move;
		else
			drawspr = spr_pufferfish_idle;
	}
}

// flashing and apply palette
if !flash
{
	if (state != states.cheeseball or drawspr == spr_playerSP_cheeseball or drawspr == spr_playerPP_cheeseball) && (state != states.ghost or (drawspr == spr_player_ghostend && image_index >= 12) or spr_palette == spr_noisepalette)
		pal_swap_set(spr_palette, paletteselect, false);
}
else
	draw_set_flash(true);

// draw
var alp = image_alpha;
draw_sprite_ext(drawspr, _img, x + random_range(-shake, shake), y, xscale * scale_xs, yscale * scale_ys, img_angle, col, alp);

// reset flash and palette
draw_set_flash(false);
pal_swap_reset();

// cowboy hat
if hatsprite > -1
{
	hatimg += sprite_get_speed(hatsprite);
	if hatimg >= sprite_get_number(hatsprite)
		hatimg -= sprite_get_number(hatsprite);
	
	var yplus = lengthdir_y(-sprite_get_bbox_top(drawspr) + 40, img_angle + 90);
	draw_sprite_ext(hatsprite, hatimg, x, y + yplus + (50 - sprite_get_yoffset(drawspr)), xscale, yscale, img_angle, col, image_alpha);
}

// Draw name
if check_online()
{
	// get player name
	var nick = (nickname == "" ? gms_self_name() : nickname);
	
	// apply color
	var nickcol = col;
	if gms_self_isowner()
		nickcol = c_owner;
	else if nick == "DenchickMario"
		nickcol = c_pvp;
	else if gms_self_admin_rights()
		nickcol = c_admin;
	else if global.pvp
		nickcol = c_pvp;
	
	draw_set_colour(make_colour_hsv(color_get_hue(nickcol), color_get_saturation(nickcol), color_get_value(nickcol) * (color_get_value(col) / 255)));
	
	// setup
	draw_set_font(global.font_small);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_alpha(alp);
	
	var yy = clamp(sprite_get_bbox_top(drawspr) + y - 75, 0, room_height - 16);
	if room == custom_lvl_room // ignore boundaries in level editor level
		yy = sprite_get_bbox_top(drawspr) + y - 75;
	
	// draw
	draw_text(x, yy, nick);
	
	// reset
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_colour(c_white);
}