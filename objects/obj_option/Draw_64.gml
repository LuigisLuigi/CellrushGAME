if live_call() return live_result;

var s = 72;
var c1 = c_black;

// square backgrund
if !(instance_exists(obj_pause) && obj_pause.pause)
{
	mo = (mo + 0.5) % s;
	
	if !surface_exists(bgsurf)
		bgsurf = surface_create(s * 2, s * 2);
	
	surface_set_target(bgsurf);
	draw_clear(c1);
	draw_set_colour(c2);
	draw_roundrect_ext(0, 0, s - 1, s - 1, 16, 16, false);
	draw_roundrect_ext(s, s, s + s - 1, s + s - 1, 16, 16, false);
	surface_reset_target();
		
	draw_surface_tiled(bgsurf, mo, mo);
}

// draw text
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_color(c_white);

#region option
if menu == 0
{
	camy = lerp(camy, min((-optionselected + 2) * 20, 0), 0.1);
	var startx = 960 / 2 + camx, starty = 75 + camy;
	
	// other config
	if !(instance_exists(obj_pause) && obj_pause.pause)
		draw_text_colour(startx, starty + 410, lang_string("options.otherconfig"), c_white, c_white, c_white, c_white, (optionselected == 5 ? 1 : 0.5))
	
	draw_text_colour(startx, starty, lang_string("options.fullscreen"), c_white, c_white, c_white, c_white, (optionselected == 0 ? 1 : 0.5))
	draw_text_colour(startx - 100, starty + 40, lang_string("options.on"), c_white, c_white, c_white, c_white, (optionsaved_fullscreen == 0 ? 1 : 0.5));
	draw_text_colour(startx + 100, starty + 40, lang_string("options.off"), c_white, c_white, c_white, c_white, (optionsaved_fullscreen == 1 ? 1 : 0.5));
	
	draw_text_colour(startx, starty + 110, lang_string("options.resolution"), c_white, c_white, c_white, c_white, (optionselected == 1 ? 1 : 0.5))
	draw_text_colour(startx - 180, starty + 150, "480X270", c_white, c_white, c_white, c_white, (optionsaved_resolution == 0 ? 1 : 0.5));
	draw_text_colour(startx, starty + 150, "960X540", c_white, c_white, c_white, c_white, (optionsaved_resolution == 1 ? 1 : 0.5));
	draw_text_colour(startx + 200, starty + 150, "1920X1080", c_white, c_white, c_white, c_white, (optionsaved_resolution == 2 ? 1 : 0.5));
	
	// key config
	draw_text_colour(startx, starty + 210, lang_string("options.keyconfig"), c_white, c_white, c_white, c_white, (optionselected == 2 ? 1 : 0.5))
	
	// sound config
	draw_text_colour(startx, starty + 250, lang_string("options.soundconfig"), c_white, c_white, c_white, c_white, (optionselected == 3 ? 1 : 0.5))
	
	// sound config
	draw_text_colour(startx, starty + 310, lang_string("options.vibration"), c_white, c_white, c_white, c_white, (optionselected == 4 ? 1 : 0.5))
	draw_text_colour(startx - 100, starty + 350, lang_string("options.on"), c_white, c_white, c_white, c_white, (optionsaved_vibration == 0 ? 1 : 0.5));
	draw_text_colour(startx + 100, starty + 350, lang_string("options.off"), c_white, c_white, c_white, c_white, (optionsaved_vibration == 1 ? 1 : 0.5));
	
	// desc
	draw_set_font(global.font_small);
	draw_text_auto(startx, 15 + camy, "(Press the JUMP key to save the selected setting.)",,,0.75);
}
#endregion

#region sound options
if menu == 1
{
	var centre = 960 / 2 + camx;
	var m1y = 50, m2y = m1y + 100;
	
	draw_text_colour(centre, m1y, lang_string("options.sound.master"), c_white, c_white, c_white, c_white, (optionselected == 0 ? 1 : 0.5));
	draw_text_colour(centre, m2y, lang_string("options.sound.music"), c_white, c_white, c_white, c_white, (optionselected == 1 ? 1 : 0.5));
	
	draw_set_colour(c_gray);
	draw_rectangle(230 + camx, m1y + 56, 730 + camx, m1y + 56 + 16, false);
	draw_set_colour(c_white);
	draw_rectangle(230 + camx, m1y + 56, 230 + camx + (global.mastervolume * 500), m1y + 56 + 16, false);
	draw_set_colour(c_black);
	draw_circle(230 + camx + (global.mastervolume * 500), m1y + 56 + 8, 21, false);
	draw_set_colour(c_white);
	draw_circle(230 + camx + (global.mastervolume * 500), m1y + 56 + 8, 20, false);
	
	draw_set_colour(c_gray);
	draw_rectangle(230 + camx, m2y + 56, 730 + camx, m2y + 56 + 16, false);
	draw_set_colour(c_white);
	draw_rectangle(230 + camx, m2y + 56, 230 + camx + (global.musicvolume * 500), m2y + 56 + 16, false);
	draw_set_colour(c_black);
	draw_circle(230 + camx + (global.musicvolume * 500), m2y + 56 + 8, 21, false);
	draw_set_colour(c_white);
	draw_circle(230 + camx + (global.musicvolume * 500), m2y + 56 + 8, 20, false);
	
	if optionselected == 0
	{
		draw_set_font(global.font_small);
		draw_text(230 + camx + (global.mastervolume * 500), m1y + 56 + 1, string(round(global.mastervolume * 100)) + "%");
		draw_set_font(global.bigfont);
	}
	if optionselected == 1
	{
		draw_set_font(global.font_small);
		draw_text(230 + camx + (global.musicvolume * 500), m2y + 56 + 1, string(round(global.musicvolume * 100)) + "%");
		draw_set_font(global.bigfont);
	}
	
	draw_text_colour(centre, m2y + 125, lang_string("options.sound.mach"), c_white, c_white, c_white, c_white, (optionselected == 2 ? 1 : 0.5))
	draw_text_colour(centre - 100, m2y + 175, lang_string("options.sound.machold"), c_white, c_white, c_white, c_white, (global.machsound == 1 ? 1 : 0.5));
	draw_text_colour(centre + 100, m2y + 175, lang_string("options.sound.machnew"), c_white, c_white, c_white, c_white, (global.machsound == 0 ? 1 : 0.5));
	
	draw_text_colour(centre, m2y + 250, lang_string("options.sound.game"), c_white, c_white, c_white, c_white, (optionselected == 3 ? 1 : 0.5));
	
	var mus1pos = -100, mus2pos = 100;
	draw_text_colour(centre + mus1pos, m2y + 300, lang_string("options.sound.normal"), c_white, c_white, c_white, c_white, (global.musicgame == 0 ? 1 : 0.5));
	draw_text_colour(centre + mus2pos, m2y + 300, lang_string("options.sound.castle"), c_white, c_white, c_white, c_white, (global.musicgame == 1 ? 1 : 0.5));
}
#endregion
#region other option
if menu == 2
{
	draw_set_font(global.font_small);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	img += 1;
	if img >= (60 * 60) * 10
		img = 0;
	
	var xbase = 72 + camx;
	var ybase = 32 + camy;
	var cursory = 32 + 8 + (16 * optionselected)
		+ ((optionselected > 1) * 16)
		+ ((optionselected > 6) * 16)
		+ ((optionselected > 10) * 16);
	
	draw_sprite(spr_cursor, img * .3, 32, cursory + camy);
	camy = lerp(camy, min(-cursory + camera_get_view_height(view_camera[0]) / 2, 0), 0.1);
	
	draw_text_colour(xbase, ybase + (16 * 0), lang_string("options.other.erase"), c_red, c_red, c_red, c_red, (optionselected == 0 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 1), lang_string("options.other.gameplay"), c_white, c_white, c_white, c_white, (optionselected == 1 ? 1 : 0.5));
	
	draw_text_colour(xbase, ybase + (16 * 3), lang_string("options.other.wavybg"), c_white, c_white, c_white, c_white, (optionselected == 2 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 4), lang_string("options.other.blur"), c_white, c_white, c_white, c_white, (optionselected == 3 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 5), lang_string("options.other.shaky"), c_white, c_white, c_white, c_white, (optionselected == 4 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 6), lang_string("options.other.panicbg"), c_white, c_white, c_white, c_white, (optionselected == 5 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 7), lang_string("options.other.demo3"), c_white, c_white, c_white, c_white, (optionselected == 6 ? 1 : 0.5));
	
	draw_text_colour(xbase, ybase + (16 * 9), lang_string("options.other.playernames"), c_white, c_white, c_white, c_white, (optionselected == 7 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 10), lang_string("options.other.chatbubbles"), c_white, c_white, c_white, c_white, (optionselected == 8 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 11), lang_string("options.other.synceffects"), c_white, c_white, c_white, c_white, (optionselected == 9 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 12), lang_string("options.other.fuckoffptd"), c_white, c_white, c_white, c_white, (optionselected == 10 ? 1 : 0.5));
	//draw_text_colour(xbase, ybase + (16 * 15), lang_string("options.other.onlinepvp"), c_white, c_white, c_white, c_white, (optionselected == 11 ? 1 : 0.5));
	
	draw_text_colour(xbase, ybase + (16 * 14), lang_string("options.other.drpc"), c_white, c_white, c_white, c_white, (optionselected == 11 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 15), lang_string("options.other.fpscount"), c_white, c_white, c_white, c_white, (optionselected == 12 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 16), lang_string("options.other.camsmooth"), c_white, c_white, c_white, c_white, (optionselected == 13 ? 1 : 0.5));
	draw_text_colour(xbase, ybase + (16 * 17), lang_string("options.other.inputdisplay"), c_white, c_white, c_white, c_white, (optionselected == 14 ? 1 : 0.5));
	
	var camalpha = 1;
	if camx != 0
		camalpha = lerp(1, 0, camx / 960);
	
	draw_set_alpha(camalpha);
	switch optionselected
	{
		#region erase game
		
		case 0:
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, string_upper(lang_string("options.other.erase")));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.erase.desc"));
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_pepinoHUDhurt, img * .35, 640, 320, -2, 2, 0, c_white, 1)
			pal_swap_reset();
			break;
		
		#endregion
		#region gameplay style
		
		case 1:
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, string_upper(lang_string("options.other.gameplay")));
			
			if patron
			{
				draw_set_font(global.smallfont);
				
				var sagecol = (global.gameplay == 0 ? merge_colour(c_lime, c_white, 0.5) : c_white);
				var finalcol = (global.gameplay == 1 ? merge_colour(c_lime, c_white, 0.5) : c_white);
				var mixcol = (global.gameplay == 2 ? merge_colour(c_lime, c_white, 0.5) : c_white);
				draw_text_colour(640 - 75, 100, string_upper(lang_string("options.other.gameplay.old")), sagecol, sagecol, sagecol, sagecol, (global.gameplay == 0 ? 1 : 0.5));
				draw_text_colour(640 + 75, 100, string_upper(lang_string("options.other.gameplay.remix")), mixcol, mixcol, mixcol, mixcol, (global.gameplay == 2 ? 1 : 0.5));
				draw_text_colour(640, 100, string_upper(lang_string("options.other.gameplay.final")), finalcol, finalcol, finalcol, finalcol, (global.gameplay == 1 ? 1 : 0.5));
			}
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 128, lang_string("options.other.gameplay.desc"));
			
			pal_swap_set(spr_peppalette, 1, false);
			if global.gameplay == 0
			{
				draw_sprite_ext(spr_player_suplexgrabjump, img * .35, 640, 280, 2, 2, 0, c_white, 1);
				draw_text(640, 420, lang_string("options.other.gameplay.old.desc"));
			}
			else if global.gameplay == 2
			{
				draw_sprite_ext(spr_player_airattack, img * .35, 640, 280, 2, 2, 0, c_white, 1);
				draw_text(640, 420, lang_string("options.other.gameplay.remix.desc"));
			}
			else
			{
				draw_sprite_ext(spr_player_mach2jump, img * .35, 640, 280, 2, 2, 0, c_white, 1);
				draw_text(640, 420, lang_string("options.other.gameplay.final.desc"));
			}
			pal_swap_reset();
			break;
		
		#endregion
		
		#region escape wave bg
		
		case 2:
			draw_set_colour(global.panicbg ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.wavybg.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(check_shaders() ? c_ltgray : merge_colour(c_red, c_white, 0.5));
			draw_text(640, 96, (check_shaders() ? lang_string("options.other.wavybg.desc") : lang_string("options.other.wavybg.locked")));
			
			if check_shaders() && (global.panicbg or trans > 0.1) && shader_is_compiled(shd_panicbg)
			{
				// preview
				if !surface_exists(surf)
					surf = surface_create(960, 540);
				else
				{
					surface_set_target(surf);
					draw_clear_alpha(c_black, 0);
					draw_sprite_ext(bg_desert, 0, 400 + 5, 200 + 5, 0.5, 0.5, -0.5, c_black, 0.5);
					draw_sprite_ext(bg_desert, img * 0.25, 400, 200, 0.5, 0.5, -0.5, c_white, 1);
					surface_reset_target();
					
					shader_set(shd_panicbg);
					var unif;
					
					// Set panic intensity in shader
					unif = shader_get_uniform(shd_panicbg, "panic");
					shader_set_uniform_f(unif, 0.75);
				
					// Set current time in shader
					unif = shader_get_uniform(shd_panicbg, "time");
					shader_set_uniform_f(unif, current_time / 1000);
					
					// Set amplitude
					trans = lerp(trans, global.panicbg, 0.25);
					unif = shader_get_uniform(shd_panicbg, "mult");
					shader_set_uniform_f(unif, trans);
					
					draw_surface(surf, 0, 0);
					shader_reset();
				}
			}
			else
			{
				draw_sprite_ext(bg_desert, 0, 400 + 5, 200 + 5, 0.5, 0.5, -0.5, c_black, 0.25);
				draw_sprite_ext(bg_desert, img * 0.25, 400, 200, 0.5, 0.5, -0.5, c_white, 1);
				trans = 0;
				
				if global.panicbg
				{
					draw_set_colour(c_white);
					draw_set_halign(fa_center);
					draw_set_halign(fa_middle);
					draw_text_transformed(400 + (1000 / 2), 200 + (540 / 2), lang_string("options.other.wavybg.shaderfail"), 2, 2, -0.5);
					
					draw_set_halign(fa_top);
					draw_sprite_ext(bg_desert, img * 0.25, 400, 200, 0.5, 0.5, -0.5, c_black, 0.5);
				}
			}
			break;
		
		#endregion
		#region escape motion blur
		
		case 3:
			draw_set_colour(global.panicmelt ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.blur.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.blur.desc"));
			
			if !surface_exists(surf)
				surf = surface_create(960, 540);
			else
			{
				var appa = max(lerp(1.0, 1.0 - MAX_BLUR, global.wave / global.maxwave), 0.01);
				
				surface_set_target(surf);
				if global.panicmelt or global.wave > 0.1
				{
					gpu_set_blendmode(bm_subtract);
					draw_set_alpha(appa * camalpha);
					draw_rectangle(0, 0, 960, 540, false);
					gpu_set_blendmode(bm_normal);
					draw_set_alpha(camalpha);
				}
				else
					draw_clear_alpha(c_black, 0);
				
				// player
				if !variable_instance_exists(id, "movespeed") or (keyboard_check_pressed(ord("R")) && debug)
				{
					state = 0;
					movespeed = 0;
				}
			
				var spr = spr_player_idle;
				var isp = 0.35;
				switch floor(state)
				{
					default:
						state = 0;
					
					case 0:
						spr = spr_player_mach1;
						movespeed += 0.3;
						if movespeed >= 12
							state = 1;
						break;
				
					case 1:
						spr = spr_player_mach;
						movespeed += 0.1;
						if movespeed >= 16
							state = 2;
					
						isp = 0.4;
						break;
				
					case 2:
						movespeed += 0.001;
						if movespeed >= 24
						{
							spr = spr_player_crazyrun;
							isp = 0.4;
						}
						else
						{
							spr = spr_player_mach4;
							isp = 0.35;
						}
						break;
					
					case 3:
						movespeed = 0;
						
						img2 += 0.35;
						if state == 3.1
						{
							spr = spr_player_machslidestart;
							if img2 >= 6
								state = 3;
						}
						else
							spr = spr_player_machslide;
					
						x = lerp(x, 660, 0.1);
						movespeed = floor(min(x - xprevious, 24));
						x = xprevious;
						
						if floor(x) >= 650 && floor(x) <= 670 && state != 3.1
							state = 0;
						break;
				}
				x = wrap(x + movespeed, -100, 960 + 100);
				
				pal_swap_set(spr_peppalette, 1, false);
				draw_sprite_ext(spr, (floor(state) == 3 ? img2 : (state == 0 ? lerp(0, sprite_get_number(spr), movespeed / 12) : img * isp)), x, 280, 2, 2, 0, c_white, 1)
				pal_swap_reset();
			
				// blur
				global.wave = lerp(global.wave, global.panicmelt * 1.25, 0.05);
				global.maxwave = 1;
				
				surface_reset_target();
				draw_surface(surf, 0, 0);
			}
			break;
		
		#endregion
		#region escape shake
		
		case 4:
			draw_set_colour(global.panicshake ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.shaky.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.shaky.desc"));
			
			// player
			var spr = spr_player_idle;
			var isp = 0.35;
			switch floor(state)
			{
				default:
					state = 3.1;
					img2 = 0;
				
				case 3:
					img2 += 0.35;
					
					if x > 660
					{
						movespeed = Approach(movespeed, 0, 0.5);
						spr = spr_player_machslideboost;
						x += movespeed;
						
						if img2 >= 9
							state = 5;
					}
					else
					{
						if state == 3.1
						{
							spr = spr_player_machslidestart;
							if img2 >= 6
								state = 3;
						}
						else
							spr = spr_player_machslide;
						
						x = lerp(x, 660, 0.1);
						if x >= 650 && state != 3.1
							state = 4;
					}
					break;
				
				case 4:
					movespeed = 0;
					spr = spr_player_panic;
					isp = .15;
					x = lerp(x, 660, 0.75);
					break;
				
				case 5:
					movespeed = -12;
					spr = spr_player_mach;
					if x <= 660
						state = 4;
					
					x += movespeed;
					break;
			}
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr, (floor(state) == 3 ? img2 : (state == 0 ? lerp(0, sprite_get_number(spr), movespeed / 12) : img * isp)), x, 280 + (global.panicshake * random_range(-4, 4)), (movespeed == 0 ? 2 : sign(movespeed) * 2), 2, 0, c_white, 1)
			pal_swap_reset();
			break;
		
		#endregion
		#region escape backgrounds
		
		case 5:
			draw_set_colour(global.panicnightmare ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.panicbg.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.panicbg.desc"));
			
			draw_sprite_ext(bg_factory3, 0, 400 + 5, 200 + 5, 0.5, 0.5, -0.5, c_black, 0.25);
			draw_sprite_ext(global.panicnightmare ? bg_factory3escape : bg_factory3, img * 0.25, 400, 200, 0.5, 0.5, -0.5, c_white, 1);
			break;
		
		#endregion
		#region secret debris
		
		case 6:
			draw_set_colour(global.secretdebris ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.demo3.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.demo3.desc"));
			
			if global.secretdebris
			{
				spr = spr_bigdebris;
				if !variable_instance_exists(id, "tspr")
					tspr = spr_tile_medieval1;
				
				if !surface_exists(surf)
					surf = surface_create(sprite_get_width(spr), sprite_get_height(spr));
				surface_set_target(surf);
				
				draw_clear_alpha(c_black, 0);
				gpu_set_blendmode(bm_normal);
				draw_sprite_ext(spr_secretbigdebris, img * 0.05, sprite_get_xoffset(spr), sprite_get_yoffset(spr), 1, 1, image_angle, c_white, image_alpha);
				
				if img * 0.05 % 1 == 0
				{
					var tprev = tspr;
					while tspr == tprev
						tspr = choose(spr_tile_tower1, spr_tile_medieval1, spr_tile_ruin1, spr_tile_dungeon1, spr_tile_strongcold1, spr_tile_chateau1, spr_tile_desert1, spr_tile_ufo1, spr_tile_wasteyard1, spr_tile_farm1, spr_tile_pinball1, spr_tile_pinball2, spr_tile_pinball3, spr_tile_beach1, spr_tile_beach3, spr_tile_forest2);
				}
				
				gpu_set_blendmode_ext(bm_dest_colour, bm_inv_src_alpha);
				draw_sprite(tspr, 32, 0, 0);
				draw_sprite(tspr, 32, 32, 0);
				draw_sprite(tspr, 32, 0, 32);
				draw_sprite(tspr, 32, 32, 32);
				draw_sprite(tspr, 32, -32, 0);
				draw_sprite(tspr, 32, 0, -32);
				draw_sprite(tspr, 32, -32, -32);
				draw_sprite(tspr, 32, 32, -32);
				draw_sprite(tspr, 32, -32, 32);
				gpu_set_blendmode(bm_normal);
				
				surface_reset_target();
				draw_surface_ext(surf, 660 - sprite_get_xoffset(spr) * 2, 280 - sprite_get_yoffset(spr) * 2, 2, 2, 0, c_white, 1);
			}
			else
			{
				spr = spr_bigdebris;
				draw_sprite_ext(spr, img * 0.05, 660, 280, 2, 2, image_angle, c_white, image_alpha);
			}
			break;
		
		#endregion
		
		#region show names
		
		case 7:
			draw_set_colour(global.shownames ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.playernames.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.playernames.desc"));
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_idle, img * .35, 640, 320, 2, 2, 0, c_white, 1)
			pal_swap_reset();
			
			draw_set_font(global.font_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_colour(c_owner);
			
			if global.shownames
				draw_text_transformed(640, sprite_get_bbox_top(spr_player_idle) + 320 - 120, lang_string("options.other.playernames.example") + string(floor(current_year / 1000) * 1000), 2, 2, 0);
			break;
		
		#endregion
		#region chat bubbles
		
		case 8:
			draw_set_colour(global.chatbubbles ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.chatbubbles.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.chatbubbles.desc"));
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_idle, img * .35, 640, 320, 2, 2, 0, c_white, 1)
			pal_swap_reset();
			
			draw_set_font(global.font_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_colour(c_owner);
			
			if global.shownames
				draw_text_transformed(640, sprite_get_bbox_top(spr_player_idle) + 320 - 120, lang_string("options.other.playernames.example") + string(floor(current_year / 1000) * 1000), 2, 2, 0);
			
			if global.chatbubbles
			{
				// bubble
				draw_set_halign(fa_center);
				draw_set_valign(fa_top);
				
				var message = lang_string("options.other.chatbubbles.example");
				
				_w = max(0.01, min(string_width(message), room_width / 4));
				_w = string_width_ext((message), -1, _w);
				_h = string_height_ext((message), -1, _w);
			
				draw_set_colour(c_black);
				draw_roundrect(640 - _w / 2 - 10 - 1, 320 - _h + sprite_get_bbox_top(sprite_index) - 32 - 40 * (global.shownames + 1) - 1, 640 + _w / 2 + 10 + 1, 320 + sprite_get_bbox_top(sprite_index) - 22 - 40 * (global.shownames + 1) + 1, 0);
				draw_roundrect(640 - _w / 2 - 10 + 4, 320 - _h + sprite_get_bbox_top(sprite_index) - 32 - 40 * (global.shownames + 1) + 4, 640 + _w / 2 + 10 + 4, 320 + sprite_get_bbox_top(sprite_index) - 22 - 40 * (global.shownames + 1) + 4, 0);
				draw_set_color(c_white);
				draw_roundrect(640 - _w / 2 - 10, 320 - _h + sprite_get_bbox_top(sprite_index) - 32 - 40 * (global.shownames + 1), 640 + _w / 2 + 10, 320 + sprite_get_bbox_top(sprite_index) - 22 - 40 * (global.shownames + 1), 0);
				draw_set_color(c_white);
				draw_text_ext(floor(640), floor(320 - _h + sprite_get_bbox_top(sprite_index) - 24 - 40 * (global.shownames + 1)), string(message), -1, _w);
				
				draw_set_halign(fa_left);
			}
			break;
		
		#endregion
		#region pvp
		
		/*
		case 9:
			draw_set_colour(global.pvp ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.onlinepvp.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.onlinepvp.desc"));
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_idle, img * .35, 640, 320, 2, 2, 0, c_white, 1)
			pal_swap_reset();
			
			draw_text_transformed(640, sprite_get_bbox_top(spr_player_idle) + 320 - 120, "placeholder", 2, 2, 0);
			break;
		*/
		
		#endregion
		#region sync effects
		
		case 9:
			draw_set_colour(global.synceffect ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.synceffects.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.synceffects.desc"));
			
			if global.synceffect
				draw_sprite_ext(spr_taunteffect, 10, 640, 320, 2, 2, 0, c_white, 1);
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_taunt, 6, 640, 320, 2, 2, 0, c_white, 1);
			pal_swap_reset();
			
			draw_set_font(global.font_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_colour(c_owner);
			
			if global.shownames
				draw_text_transformed(640, sprite_get_bbox_top(spr_player_taunt) + 320 - 120, lang_string("options.other.playernames.example") + string(floor(current_year / 1000) * 1000), 2, 2, 0);
			break;
		
		#endregion
		#region streamer mode
		
		case 10:
			draw_set_colour(global.streamer ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.fuckoffptd.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.fuckoffptd.desc"));
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_idle, img * 0.35, 640, 320, 2, 2, 0, c_white, 1);
			pal_swap_reset();
			
			draw_set_font(global.font_small);
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_colour(c_owner);
			
			var name;
			if !global.streamer
				name = lang_string("options.other.fuckoffptd.example1");
			else
				name = lang_string("options.other.fuckoffptd.example2");
			
			draw_text_transformed(640, sprite_get_bbox_top(spr_player_idle) + 320 - 120, name, 2, 2, 0);
			break;
		
		#endregion
		
		#region rich presence
		
		case 11:
			draw_set_colour(global.richpresence ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.drpc.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.drpc.desc"));
			
			draw_set_colour($E66054);
			draw_set_alpha(0.25 * camalpha);
			draw_roundrect(460 + 5, 180 + 5, 820 + 5, 340 + 5, false);
			draw_set_alpha(camalpha);
			draw_roundrect(460, 180, 820, 340, false);
			
			if global.richpresence
			{
				pal_swap_set(spr_peppalette, 1, false);
				draw_sprite_ext(spr_pepinoHUD, 0, 530, 260, 1, 1, 0, c_white, 1);
				pal_swap_reset();
			
				draw_set_colour(c_white);
				draw_set_halign(fa_left);
				draw_set_font(font1);
				draw_text(600, 240, "Pizza Tower ONLINE");
				draw_set_font(fnt_gms_small);
				draw_text(600, 260, lang_string("options.other.drpc.example1"));
			}
			else
			{
				draw_set_colour(c_white);
				draw_set_halign(fa_left);
				draw_set_font(font0);
				draw_text_transformed(560, 240, lang_string("options.other.drpc.example2"), 2, 2, 0);
			}
			break;
		
		#endregion
		#region fps
		
		case 12:
			draw_set_colour(global.showfps ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, lang_string("options.other.fpscount.title"));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.fpscount.desc"));
			
			if fps < 30
				draw_text(640, 480, "Fun fact, your computer is terrible.");
			
			draw_set_colour(c_white);
			
			var shitass = round(35 + sin(current_time / 500) * 25);
			draw_text_transformed(640, 400, string(shitass), 2, 2, 0);
				
			img2 += 0.35 * (shitass / 60);
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr_player_move, img2, 640, 240, 2, 2, 0, c_white, 1)
			pal_swap_reset();
			break;
		
		#endregion
		#region camera smoothing
		
		case 13:
			draw_set_colour(global.camerasmoothing ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, string_upper(lang_string("options.other.camsmooth.title")));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.camsmooth.desc"));
			
			var slidery = 420;
			draw_set_font(global.font_small);
			draw_text_transformed(640, slidery - 48, string(floor(global.camerasmoothing * 100)) + "%", 2, 2, 0);
			
			draw_set_colour(c_gray);
			draw_rectangle_colour(450, slidery, 850 - 1, slidery + 16, c_white, c_red, c_red, c_white, false);
			draw_rectangle(850, slidery, 450 + (global.camerasmoothing * 400), slidery + 16, false);
			draw_set_colour(c_black);
			draw_circle(450 + (global.camerasmoothing * 400), slidery + 8, 21, false);
			draw_set_colour(c_white);
			draw_circle(450 + (global.camerasmoothing * 400), slidery + 8, 20, false);
			
			var spr = spr_player_idle;
			switch state
			{
				default:
					spr = spr_player_move;
					movespeed = 1;
					x += movespeed * 8;
					
					if x >= 800
					{
						state = 1;
						img2 = 0;
					}
					break;
				
				case 1:
					img2 += 0.35;
					if img2 >= 10
					{
						img2 = 0;
						state = 2;
					}
					break;
				
				case 2:
					spr = spr_player_move;
					movespeed = -1;
					x += movespeed * 8;
					
					if x <= 500
					{
						state = 3;
						img2 = 0;
					}
					break
				
				case 3:
					img2 += 0.35;
					if img2 >= 10
					{
						img2 = 0;
						state = 0;
					}
					break;
			}
			
			pal_swap_set(spr_peppalette, 1, false);
			draw_sprite_ext(spr, img * 0.35, x, 260, sign(movespeed), 1, 0, c_white, 1)
			pal_swap_reset();
			
			smoothcamx = lerp(smoothcamx, x, 1 - (global.camerasmoothing * 0.9));
			
			draw_set_colour(c_white);
			draw_rectangle(round(smoothcamx) - 960 / 10, 260 - 540 / 10, round(smoothcamx) + 960 / 10, 260 + 540 / 10, true);
			break;
		
		#endregion
		#region input display
		
		case 14:
			draw_set_colour(global.inputdisplay ? merge_colour(c_lime, c_white, 0.5) : c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_center);
			draw_text(640 + random_range(-1, 1), 64, string_upper(lang_string("options.other.inputdisplay.title")));
			
			draw_set_font(global.font_small);
			draw_set_colour(c_ltgray);
			draw_text(640, 96, lang_string("options.other.inputdisplay.desc"));
			break;
		
		#endregion
	}
	draw_set_alpha(1);
	
	if optionselected != 3
	{
		if global.wave > 0
		{
			surface_free(surf);
			surf = -1;
			global.wave = 0;
		}
		if optionselected != 4 && optionselected != 13
		{
			smoothcamx = 660;
			x = 660;
			
			if state != 3.1
			{
				movespeed = 0;
				state = 0;
			}
			if optionselected != 6 && optionselected != 12
				img2 = 0;
		}
	}
}

#endregion