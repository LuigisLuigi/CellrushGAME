if live_call()
	return live_result;

if (pause or pausefad == 2 or pausefad == 4)
{
	if pausefad != 4
		application_surface_draw_enable(true);
	
	// manage fading
	if pausefad == 1 && pausealpha < 1
	{
		pausealpha += 0.2;
		if pausealpha >= 1
		{
			pausefad = 3;
			pausealpha = 0;
		}
		
		draw_sprite_stretched(pausebg, 0, 0, 0, 960, 540);
		
		draw_set_colour(c_black);
		draw_set_alpha(pausealpha);
		draw_rectangle(0, 0, 960, 540, false);
		draw_set_alpha(1);
	}
	else if sprite_exists(pausebg)
		sprite_delete(pausebg);
	
	if pausefad == 4
	{
		if pausealpha > 0
			pausealpha -= 0.15;
		else
		{
			pausefad = 0;
			if sprite_exists(pausebg)
				sprite_delete(pausebg);
			exit;
		}
		
		draw_set_colour(c_black);
		draw_set_alpha(pausealpha);
		draw_rectangle(0, 0, 960, 540, false);
		draw_set_alpha(1);
	}
	if pausefad == 3
	{
		if pausealpha < 1
			pausealpha += 0.1;
	}
	
	// draw the background
	depth = -9998;
	if pausefad == 3 or pausefad == 2
	{
		var s = 72;
		x = (x + 0.5) % s;
		
		// yeah thats right bitch double surface what are you gonna do about that huh
		if !surface_exists(pausesurf)
			pausesurf = surface_create(960, 540);
		if !surface_exists(surf)
			surf = surface_create(s * 2, s * 2);
		
		surface_set_target(surf);
		draw_clear(c_black);
		draw_set_colour(make_colour_hsv((257 / 360) * 255, (39 / 100) * 255, (23 / 100) * 255));
		draw_roundrect_ext(0, 0, s - 1, s - 1, 16, 16, false);
		draw_roundrect_ext(s, s, s + s - 1, s + s - 1, 16, 16, false);
		surface_reset_target();
		
		surface_set_target(pausesurf);
		draw_surface_tiled(surf, x, x);
		surface_reset_target();
		
		draw_surface(pausesurf, 0, 0);
		
		if !instance_exists(obj_option)
		{
			draw_set_alpha(1);
			draw_set_colour(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			draw_set_font(global.font_small);
			draw_text(16, 16, "Time Taken:");
			draw_set_font(character == "SP" ? global.sugarybigfont : global.bigfont);
			draw_text(16, 36, string(global.taminutes) + ":" + (global.taseconds < 10 ? "0" : "") + string(global.taseconds));
			
			draw_set_font(global.bigfont);
			
			// options
			draw_text_auto(960 / 2 , 100, lang_string("pause.continue"),,, selected == 0 ? 1 : 0.5);
			draw_text_auto(960 / 2, 150, lang_string("pause.retry"),,, selected == 1 ? 1 : 0.5);
			draw_text_auto(960 / 2, 200, gototitle ? lang_string("pause.title") : lang_string("pause.exit"),,, selected == 2 ? 1 : 0.5);
			draw_text_auto(960 / 2, 250, lang_string("pause.options"),,, selected == 3 ? 1 : 0.5);
			draw_sprite(spr_cursor, i, 960 / 2 - 42, 116 + 50 * selected);
			
			// player
			var _pspr = spr_player_idle;
			var _ppanic = global.panic or global.snickchallenge;
			
			switch character
			{
				case "P":
				default:
					var _spr_resume = _ppanic ? spr_player_panic : spr_player_idle;
					var _spr_options = spr_file1;
					var _spr_retry = _ppanic ? spr_player_hurtidle : spr_player_mach;
					var _spr_exit = spr_player_winding;
					var _spr_palette = spr_peppalette;
					break;
				
				case "N":
					_spr_resume = _ppanic ? spr_playerN_panicidle : spr_playerN_idle;
					_spr_options = spr_playerN_rageidle;
					_spr_retry = _ppanic ? spr_playerN_hurtidle : spr_playerN_mach;
					_spr_exit = spr_playerN_winding;
					_spr_palette = spr_noisepalette;
					break;
				
				case "SP":
					_spr_resume = _ppanic ? spr_playerSP_panic : spr_playerSP_idle;
					_spr_options = spr_playerSP_deez;
					_spr_retry = _ppanic ? spr_playerSP_3hpidle_NEW : spr_playerSP_mach4;
					_spr_exit = spr_playerSP_winding;
					_spr_palette = spr_pizzpalette;
					break;
				
				case "SN":
					_spr_resume = spr_playerSN_idle;
					_spr_options = spr_playerSN_taunt;
					_spr_retry = spr_playerSN_idle;
					_spr_exit = spr_playerSN_idle;
					_spr_palette = spr_pizzpalette;
					break;
				
				case "PP":
					_spr_resume = _ppanic ? spr_playerPP_panic : spr_playerPP_idle;
					_spr_options = spr_playerPP_gottreasure;
					_spr_retry = _ppanic ? spr_playerPP_3hpidle : spr_playerPP_mach;
					_spr_exit = spr_playerPP_winding;
					_spr_palette = spr_pisspalette;
					break;
					
				case "V":
					_spr_resume = _ppanic ? spr_playerV_panic : spr_playerV_idle;
					_spr_options = spr_playerV_crouch;
					_spr_retry = _ppanic ? spr_playerV_angryidle : spr_playerV_crazyrun;
					_spr_exit = spr_playerV_winding;
					_spr_palette = spr_vigipalette;
					break;
				
				case "S":
					var _spr_resume = spr_snick_idle;
					var _spr_options = [spr_snick_idleanim, 4];
					var _spr_retry = _ppanic ? spr_snick_superpeelout : spr_snick_mach3;
					var _spr_exit = spr_snick_bump;
					var _spr_palette = spr_snickpalette;
					break;
				
				case "PUFFER":
					var _spr_resume = spr_pufferfish_idle;
					var _spr_options = spr_pufferfish_idle;
					var _spr_retry = spr_pufferfish_idle;
					var _spr_exit = spr_pufferfish_move;
					var _spr_palette = spr_pufferpalette;
					break;
			}
			
			switch selected
			{
				case 0: _pspr = _spr_resume; break;
				case 1: _pspr = _spr_retry; break;
				case 2: _pspr = _spr_exit; break;
				case 3: _pspr = _spr_options; break;
			}
			if is_array(_pspr)
				i = _pspr[1];
			else
				i += 0.35 * sprite_get_speed(_pspr);
			
			pal_swap_set(_spr_palette, paletteselect, false);
			draw_sprite_ext(is_array(_pspr) ? _pspr[0] : _pspr, i, 200, 200, 2, 2, 0, c_white, 1);
			pal_swap_reset();
			
			var hud_xx = 750, hud_yy = 450;
			if global.gameplay == 0
			{
				// tv
				var tvsprite = spr_tvdefault;
				if character == "SP" or character == "SN"
					tvsprite = spr_tvdefault_ss;
				if character == "PP"
					tvsprite = spr_tvdefault_PP;
				
				draw_sprite_ext(tvsprite, 0, hud_xx + 50, hud_yy, 1, 1, 0, c_white, 1);
				draw_set_halign(fa_center);
				draw_text(hud_xx + 50 - 4, hud_yy - 14, string(global.collect));
			}
			else
			{
				// pizza
				var sugary = (character == "SP" or character == "SN");
				
				var _pizzascore = spr_pizzascore;
				if sugary
					_pizzascore = spr_candyscore;
				if character == "PP"
					_pizzascore = spr_pizzascorePP;
				
				draw_sprite_ext(_pizzascore, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
				
				// collect
				var _crankpizza = character == "PP" ? spr_pizzascore_pepperPP : spr_pizzascore_pepper;
				var _brankpizza = character == "PP" ? spr_pizzascore_pepperoniPP : spr_pizzascore_pepperoni;
				var _arankpizza = character == "PP" ? spr_pizzascore_olivePP : spr_pizzascore_olive;
				var _srankpizza = character == "PP" ? spr_pizzascore_shroomPP : spr_pizzascore_shroom;
		
				if _pizzascore == spr_pizzascoreN
				{
					_crankpizza = -1;
					_brankpizza = -1;
					_arankpizza = -1;
					_srankpizza = -1;
				}
				if sugary
				{
					_crankpizza = spr_candyscore_crank;
					_brankpizza = spr_candyscore_brank;
					_arankpizza = spr_candyscore_arank;
					_srankpizza = spr_candyscore_srank;
				}
				
				var _score = global.collect;
				if global.srank > 0
				{
					if _score >= global.crank && sprite_exists(_crankpizza)
						draw_sprite_ext(_crankpizza, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
					if _score >= global.brank && sprite_exists(_brankpizza)
						draw_sprite_ext(_brankpizza, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
					if _score >= global.arank && sprite_exists(_arankpizza)
						draw_sprite_ext(_arankpizza, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
					if _score >= global.srank && sprite_exists(_srankpizza)
						draw_sprite_ext(_srankpizza, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
				}
				
				draw_set_valign(fa_top);
				draw_set_halign(fa_left);
				
				if sugary
					draw_set_font(global.candyfont)
				else if character == "PP"
					draw_set_font(global.collectfontPP)
				else
					draw_set_font(global.collectfont)
			
				var str = string(_score);
				var num = string_length(str);
				var xx = hud_xx - string_width(str) / 2;
			
				draw_set_alpha(1);
				for (var ii = 0; ii < num; ii++)
				{
					var yy = (ii + 1) % 2 == 0 ? -5 : 0;
					draw_text(xx, hud_yy - 56 + yy, string_char_at(str, ii + 1));
					xx += string_width(str) / num;
				}
			
				draw_set_alpha(1);
				pal_swap_reset();
			}
			
			// toppins
			var shroomspr = spr_toppinshroom, cheesespr = spr_toppincheese, tomatospr = spr_toppintomato, sausagespr = spr_toppinsausage, pineapplespr = spr_toppinpineapple;
			if global.gameplay != 0
			{
				shroomspr = spr_toppinshroom_NEW;
				cheesespr = spr_toppincheese_NEW;
				tomatospr = spr_toppintomato_NEW;
				sausagespr = spr_toppinsausage_NEW;
				pineapplespr = spr_toppinpineapple_NEW;
				
				if check_sugary()
				{
					shroomspr = spr_toppinmallow_NEW;
					cheesespr = spr_toppinchoco_NEW;
					tomatospr = spr_toppincrack_NEW;
					sausagespr = spr_toppinworm_NEW;
					pineapplespr = spr_toppincandy_NEW;
				}
				else if string_startswith(room_get_name(room), "strongcold")
				{
					shroomspr = spr_xmastoppinshroom_NEW;
					cheesespr = spr_xmastoppincheese_NEW;
					tomatospr = spr_xmastoppintomato_NEW;
					sausagespr = spr_xmastoppinsausage_NEW;
					pineapplespr = spr_xmastoppinpineapple_NEW;
				}
			}
			else
			{
				if check_sugary()
				{
					shroomspr = spr_toppinmallow;
					cheesespr = spr_toppinchoco;
					tomatospr = spr_toppincrack;
					sausagespr = spr_toppinworm;
					pineapplespr = spr_toppincandy;
				}
				else if string_startswith(room_get_name(room), "strongcold")
				{
					shroomspr = spr_xmasshroomtoppin_idle;
					cheesespr = spr_xmascheesetoppin_idle;
					tomatospr = spr_xmastomatotoppin_idle;
					sausagespr = spr_xmassausagetoppin_idle;
					pineapplespr = spr_xmaspineappletoppin_idle;
				}
			}
			
			draw_sprite_ext(shroomspr, i, 92, 420, 1, 1, 0, c_white, global.shroomfollow ? 1 : 0.25);
			draw_sprite_ext(cheesespr, i, 92 + (50 * 1), 420, 1, 1, 0, c_white, global.cheesefollow ? 1 : 0.25);
			draw_sprite_ext(tomatospr, i, 92 + (50 * 2), 420, 1, 1, 0, c_white, global.tomatofollow ? 1 : 0.25);
			draw_sprite_ext(sausagespr, i, 92 + (50 * 3), 420, 1, 1, 0, c_white, global.sausagefollow ? 1 : 0.25);
			draw_sprite_ext(pineapplespr, i, 92 + (50 * 4), 420, 1, 1, 0, c_white, global.pineapplefollow ? 1 : 0.25);
			
			// fade
			draw_set_colour(c_black);
			draw_set_alpha(1 - clamp(pausealpha, 0, 1));
			draw_rectangle(0, 0, 960, 540, false);
		}
		else
			depth = -90;
	}
	else
		x = 0;
	
	if pausefad == 2
	{
		pausealpha -= 0.2;
		if pausealpha <= 0
		{
			pausealpha = 1;
			pausefad = 4;
		}
	}
	draw_set_alpha(1);
}
else
{
	if surface_exists(pausesurf)
		surface_free(pausesurf);
}
