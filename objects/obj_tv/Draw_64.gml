// snick rematch vignette
if ((room == dungeon_10 or room == dungeon_9 or room == snick_challengeend) && global.snickchallenge && global.snickrematch)
{
	draw_sprite_ext(spr_vignette, 0, 0, 0, 1, 1, 0, c_white, random_range(0.8, 0.9));
	instance_destroy(obj_baddie, false);
	instance_destroy(obj_baddiespawner, false);
}

// snick rematch jumpscare
if jumpscare > -1
{
	jumpscare--;
	
	if irandom(2) == 0
		jumpscareimage = irandom(sprite_get_number(spr_scares) - 1);
	
	if jumpscare <= 5
		draw_sprite(spr_scares_txt, jumpscaretext, 0, 0);
	else
		draw_sprite(spr_scares, jumpscareimage, 0, 0);
}

if room == rm_darkreveal or !global.showhud
	exit;

// Draw Text
draw_set_font(check_sugary() ? global.sugarybigfont : global.bigfont)
draw_set_halign(fa_center);
draw_set_color(c_white)

// Text Event
draw_set_valign(fa_bottom);
draw_text_auto(xi, yi, string(message))
draw_set_valign(fa_top);

draw_set_font(global.bigfont)

#region old hud

if global.gameplay == 0
{
	//Draw TV
	var tvx = 832, tvy = 74;
	if !surface_exists(surf)
		surf = surface_create(960, 540);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	
	var sprit = tvsprite;
	if global.combotime > 0 && tvsprite == spr_tvcombo
	{
		// combo tv
		draw_sprite_ext(scr_sprite_charsuffix(spr_tvcomboclear, sugary ? "ss" : -1), tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
		
		sprit = scr_sprite_charsuffix(spr_tvcombo, sugary ? "ss" : -1);
		draw_sprite_part_ext(sprit, imageindexstore % 5, 0, 0, 16 + (global.combotime / 60) * 148, 177, tvx - sprite_get_xoffset(sprit), tvy - sprite_get_yoffset(sprit), 1, 1, c_white, 1);
		draw_text(tvx + 20, tvy + 1, string(global.combo));
	}
	else if room != Realtitlescreen
	{
		// default ss tv if the equivalent sprite doesn't exist
		sprit = scr_sprite_charsuffix(tvsprite, sugary ? "ss" : -1);
		if sugary && !string_endswith(sprite_get_name(sprit), "_ss")
			sprit = spr_tvdefault_ss;
		
		// tv
		draw_sprite_ext(sprit, tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
		
		// text
		if (tvsprite == spr_tvdefault or sprit == spr_tvdefault_ss) && !global.miniboss
			draw_text(tvx - 4, tvy - 14, string(global.collect));
		if global.miniboss
			draw_text(tvx, tvy - 14, string(global.boxhp));
		if tvsprite == spr_tvdefault
			chose = false;
	}
	draw_set_alpha(1);
	
	// tv frame
	if room != Realtitlescreen && sprit != spr_tvhurt_ss
		draw_sprite_ext(sugary ? spr_tvempty_ss : spr_tvempty, tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
	
	surface_reset_target();
	draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, alpha);
	
	// image speed
	tvimg += image_speed * sprite_get_speed(sprit);
	tvimg = tvimg % sprite_get_number(sprit);
}

#endregion
#region new hud

else
{
	if !(instance_exists(obj_player) && obj_player.state == states.rotate)
	{
		/*
		if global.use_temperature
		{
			var _width = sprite_get_width(spr_temperature_meterfill)
			var _height = sprite_get_height(spr_temperature_meterfill)
			global.temperature += global.temperature_spd
			global.temperature = clamp(global.temperature, 0, (global.temp_thresholdnumber * 100))
			var _tmp = (global.temperature / (global.temp_thresholdnumber * 100))
			var _top = 0
			var _height2 = (_height * _tmp)
			draw_sprite_part_ext(spr_temperature_meterfill, 0, 0, _top, _width, _height2, 864, (192 + _height), 1, -1, c_white, 1)
			draw_sprite(spr_temperature_meter, 0, 864, 192)
		}
		*/
		
		var current_sprite = sprite_get_name(sprite_index);
		var tvoff = string_startswith(current_sprite, "spr_tv_off") or string_startswith(current_sprite, "spr_tv_open");
		if tvoff
			sprite_prev = -1
		else if sprite_prev == -1
			sprite_prev = sprite_index
		
		var offset_x = irandom_range(-collect_shake, collect_shake);
		var offset_y = irandom_range(-collect_shake, collect_shake);
		if sugary
		{
			offset_x -= 1;
			offset_y -= 32 + sin(current_time / 500) * 2;
		}
		else
		{
			offset_x += 12;
			offset_y -= 27;
		}
		var tv_x = 833 + offset_x, tv_y = 107 + offset_y;
		
		// combo timer
		if !sugary
		{
			var _cx = (tv_x + combo_posX)
			var _cy = (((tv_y + 117) + hud_posY) + combo_posY)
			var _perc = (global.combotime / 60)
			var _minX = (_cx - 56)
			var _maxX = (_cx + 59)
			
			combofill_x = lerp(combofill_x, (_minX + ((_maxX - _minX) * _perc)), 0.5)
			combofill_y = _cy
			
			draw_sprite(spr_tv_combobubblefill, combofill_index, combofill_x, combofill_y)
			draw_sprite(spr_tv_combobubble, -1, _cx, _cy)
			draw_set_font(global.combofont2)
			draw_set_halign(fa_left)
			draw_set_valign(fa_top)
			
			var _tx = (_cx - 64)
			var _ty = (_cy - 12)
			var _str = string(global.combo)
			var num = string_length(_str)
			for (var i = num; i > 0; i--)
			{
			    var char = string_char_at(_str, i)
			    draw_text(_tx, _ty, char)
			    _tx -= 22
			    _ty -= 8
			}
		}
		
		if room != strongcold_endscreen && room != Realtitlescreen
		{
			// tv
			if sprite_exists(sprite_index)
			{
				var tvspr = sprite_index;
				if sprite_prev != -1 && idlespr != sprite_prev
				{
					noisebuffer = sugary ? 16 : noisemax;
					sprite_prev = idlespr;
				}
				if noisebuffer > 0
				{
					tvspr = sugary ? spr_tv_whitenoiseSP : spr_tv_whitenoise;
					if instance_exists(obj_player) && obj_player.character == "PP"
						tvspr = spr_tv_whitenoisePP;
					
					tvimg += 0.35;
					noisebuffer--;
				}
				else
					tvimg = image_index;
				
				// apply player palette
				if !tvoff && !string_startswith(current_sprite, "spr_tv_placeholder")
				{
					with obj_player
						pal_swap_set(spr_palette, paletteselect, false);
				}
				
				if !sugary
					draw_sprite_ext(spr_tv_cheapbg, 0, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				draw_sprite_ext(tvspr, tvimg, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				pal_swap_reset();
				
				if !sugary && !tvoff && !(instance_exists(obj_player) && obj_player.character == "PP")
					draw_sprite_ext(spr_tv_frame, 0, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				
				if sugary && !tvoff
				{
					var propeller = spr_tvpropeller;
					if tvspr == spr_tv_whitenoiseSP
						propeller = spr_tvpropellerstatic;
					
					sugary_propeller += image_speed;
					sugary_propeller = sugary_propeller % sprite_get_number(propeller);
					draw_sprite_ext(propeller, sugary_propeller, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				}
			}
			combo_shake = Approach(combo_shake, 0, 0.25);
			
			// draw combo
			combo_fade = 1;
			if sugary
			{
				combo_fade = min(global.combotime / 5, 1);
				if global.combo != 0 && global.combotime > 0 && !tvoff
				{
					// sugary spire combo
					if combo_prev < global.combo
					{
						combo_shake = 5;
						combo_prev = global.combo;
					}
					tvcombo = spr_tv_comboSP;
					
					draw_sprite_ext(tvcombo, -1, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha * combo_fade)
					
					var str = string(combo_prev);
					if global.combo < 10 && global.combo > -1
						str = "0" + str;
					
					draw_set_halign(fa_left);
					draw_set_valign(fa_top);
					draw_set_font(global.combofont);
					
					var num = string_length(str);
					var w = round(string_width(str) / num);
					
					for (var i = 0; i < num; i++)
					{
						var char = string_char_at(str, i + 1);
						var xx = i * w, yy = i * 5;
						draw_text_auto(5 - 789 + xx + offset_x + random_range(-combo_shake, combo_shake), 4 - 91 - yy + offset_y + hud_posY + random_range(-combo_shake, combo_shake), char,,,combo_fade);
					}
					
					// sugary combo timer
					if !surface_exists(popsurf)
						popsurf = surface_create(112, 32);
					else
					{
						var b = global.combotime / 55;
						
						surface_set_target(popsurf);
						draw_clear_alpha(c_black, 0);
						draw_sprite_tiled(spr_barpop2_ss, 0, (-current_time / 100) + global.combotime, 0);
						draw_set_colour(#480028);
						draw_rectangle(112 * b, 0, 112, 32, false);
						draw_sprite(spr_barpop3_ss, 0, 112 * b, 0);
						draw_set_blend_mode(bm_subtract);
						draw_sprite(spr_barpop_ss, 1, 0, 0);
						draw_set_blend_mode(bm_normal);
						surface_reset_target();
					
						draw_set_alpha(combo_fade);
						draw_surface(popsurf, 833 + offset_x - 73, 107 + offset_y + hud_posY + 34);
						draw_sprite(spr_barpop_ss, 0, 833 + offset_x - 73, 107 + offset_y + hud_posY + 34);
						draw_set_alpha(1);
					}
				}
				else
					combo_prev = 0;
			}
		}
	
		if bubblespr != noone
			draw_sprite_ext(bubblespr, bubbleindex, 512 - (sugary * 65), 53 + hud_posY, 1, 1, 1, c_white, alpha);
	
		if !surface_exists(promptsurface)
			promptsurface = surface_create(290, 102);
		
		surface_set_target(promptsurface)
		draw_clear_alpha(c_black, 0) 
		draw_set_font(font1)
		draw_set_halign(fa_left)
		draw_set_valign(fa_middle)
		
		// draw bubble
		if bubblespr == spr_tv_bubble
		{
			promptx -= promptspd;
			if bubblespr != spr_tv_bubbleclose && promptx < 350 - string_width(prompt)
			{
				bubblespr = spr_tv_bubbleclose;
				bubbleindex = 0;
				promptx = promptxstart;
			}
			draw_text_color(promptx - 350, 50, prompt, c_black, c_black, c_black, c_black, 1);
		}
		
		draw_set_halign(fa_left);
		surface_reset_target();
		draw_surface(promptsurface, 350 - (sugary * 65), hud_posY);
	}
	
	draw_set_font(global.bigfont)
}

#endregion

// pizzacoin in the hub
draw_set_valign(fa_top);
if check_online() && room == hub_room1 && !(instance_exists(obj_player) && obj_player.state == states.victory)
{
	draw_set_halign(fa_right);
	pizzacoinframe = (pizzacoinframe + 0.35) % sprite_get_number(spr_pizzacoin);
	
	if scr_getcoin() < 0
		draw_set_colour(c_red);
	
	draw_text(960 - 64 - 32, 148 + (global.gameplay != 0 ? (64 + (sugary ? 16 : 0)) : 0), string(scr_getcoin()));
	draw_sprite_ext(spr_pizzacoin, pizzacoinframe, 960 - 64 - 24, 148 + (global.gameplay != 0 ? (64 + (sugary ? 16 : 0)) : 0), 1, 1, 0, c_white, alpha);
	
	draw_set_halign(fa_center);
}
draw_set_colour(c_white);

// golf hits
if instance_exists(obj_pizzaballOLD)
or instance_exists(obj_pizzaball)
{
	draw_set_halign(fa_right);
	draw_text(960 - 25, 200, string(string(global.golfhit) + " " + (global.golfhit == 1 ? "GOLF HIT" : "GOLF HITS")))
	draw_set_halign(fa_center);
}

// timer
if global.panic
{
    var _fill = global.fill
    var _currentbarpos = chunkmax - _fill
    var _perc = _currentbarpos / chunkmax
    var _max_x = 299
    var _barpos = _max_x * _perc
	
    if !surface_exists(bar_surface)
        bar_surface = surface_create(298, 30)
	
    var _barfillpos = floor(_barpos) + 13
    if _barfillpos > 0
    {
        surface_resize(bar_surface, _barfillpos, 30)
        surface_set_target(bar_surface)
        draw_clear_alpha(c_black, 0)
        var clip_x = timer_x + 3
        var clip_y = timer_y + 5
        for (i = 0; i < 3; i++)
            draw_sprite(spr_timer_barfill, 0, barfill_x + (i * 173), 0)
        surface_reset_target()
        draw_surface(bar_surface, clip_x, clip_y)
    }
    draw_sprite(spr_timer_bar, -1, timer_x, timer_y)
    draw_sprite(johnface_sprite, johnface_index, timer_x + 13 + _barpos, timer_y + 20)
    draw_sprite(pizzaface_sprite, pizzaface_index, timer_x + 320, timer_y + 10)
}
