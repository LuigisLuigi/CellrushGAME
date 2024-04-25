if check_online()
{
	if global.__chat
		exit;
}

scr_getinput(true);
function draw_inputdisplay_key(xx, yy, keycode, width, height = width)
{
	var drawer = keycode;
	var pressed = false;
	switch keycode
	{
		default: pressed = keyboard_check(scr_keyfromname(keycode)); break;
		
		case "SHIFT": pressed = key_attack; break;
		case "Z": pressed = key_jump2; break;
		case "X": pressed = key_slap; break;
		case "C": pressed = key_taunt; break;
		case "A": case "V": pressed = key_shoot; break;
		case "UP": drawer = 0; pressed = key_up; break;
		case "DOWN": drawer = 180; pressed = key_down; break;
		case "LEFT": drawer = 90; pressed = -key_left; break;
		case "RIGHT": drawer = 270; pressed = key_right; break;
	}
	
	// square
	draw_set_alpha(image_alpha);
	draw_set_colour(pressed ? pressedcol : c_ltgray);
	draw_roundrect(xx, yy, xx + width - 1, yy + height - 1, false);
	
	draw_set_colour(c_black);
	draw_roundrect(xx, yy, xx + width - 1, yy + height - 1, true);
	
	// text
	if is_string(drawer)
	{
		draw_set_colour(c_white);
		draw_set_font(global.bigfont);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
	
		var siz = 1;
		var _stringwidth = string_width(drawer);
		
		siz = (width - 16) / _stringwidth;
		if siz > 1
			siz = max(floor(siz / 2), 1);
	
		if siz != 1
			draw_text_transformed(floor(xx + width / 2), floor(yy + height / 2), drawer, siz, siz, 0);
		else
			draw_text(floor(xx + width / 2), floor(yy + height / 2), drawer);
	
		draw_set_valign(fa_top);
	}
	else
	{
		siz = (width - 16) / 28;
		if siz > 1
			siz = max(floor(siz / 2), 1);
		draw_sprite_ext(spr_inputdisplay_arrow, 0, floor(xx + width / 2), floor(yy + height / 2), siz, siz, drawer, c_white, image_alpha);
	}
	
	draw_set_alpha(1);
}

if global.inputdisplay
{
	x = pos[0];
	y = pos[1];
	
	// draw it
	var xx = 0, yy = 0;
	for(var i = 0; i < array_length(inputkeys); i++)
	{
		var k = inputkeys[i];
		
		xx = k.x * keysize + k.x * keysep;
		yy = k.y * keysize + k.y * keysep;
		
		draw_inputdisplay_key(x + xx, y + yy, k.key, k.keyw * keysize + (k.keyw - 1) * keysep, k.keyh * keysize + (k.keyh - 1) * keysep);
	}
	
	// dont block the view
	var left = x, right = x + xx + keysize, top = y, bottom = y + yy + keysize;
	
	if instance_exists(obj_player)
	{
		var px = obj_player.x - _camx, py = obj_player.y - _camy;
		if px >= left - 25 && px <= right + 25
		&& py >= top - 50 && py <= bottom + 25
			image_alpha = 0.35;
		else
			image_alpha = 1;
	}
	
	// customize
	var mx = device_mouse_x_to_gui(0), my = device_mouse_y_to_gui(0);
	if mx >= left && mx <= right && my >= top && my <= bottom
	{
		if mouse_check_button_pressed(mb_left) && !drag
		{
			drag = true;
			dragoffset = [pos[0] - mx, pos[1] - my];
		}
		
		draw_set_colour(drag ? c_red : merge_colour(c_blue, c_aqua, 0.75));
		draw_rectangle(left, top, right, bottom, true);
	}
	if !mouse_check_button(mb_left)
		drag = false;
	
	if drag
	{
		pos[0] = mx + dragoffset[0];
		pos[1] = my + dragoffset[1];
		
		pos[0] = clamp(pos[0], 0, 960 - xx - keysize);
		pos[1] = clamp(pos[1], 0, 540 - yy - keysize);
		
		with obj_wc
			WC_dragobj = noone;
	}
}

