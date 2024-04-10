draw_set_colour(c_white);
draw_set_align(fa_center, fa_middle);
draw_set_font(loadfont);

switch loadwhat
{
	default:
		draw_text(960 / 2, 540 / 2, lang_string("load.loading"));
		break;
	
	case 0:
		draw_text(960 / 2, 540 / 2, lang_string("load.txgrp"));
		if !ds_exists(tex_list, ds_type_list)
		    break;
		
		var p = tex_max - ds_list_size(tex_list);
		var t = (p / tex_max) * 100;
		draw_healthbar(0, 540 - 16, 960, 540, t, c_black, c_white, c_white, 0, 0, 0);
		break;
	
	case 1:
		// load audio groups
		for (var i = 1; audio_group_name(i) != undefined; i++)
		{
			if !audio_group_is_loaded(i)
			{
				if !audio_group_load(i)
					show_error("Audio group " + audio_group_name(i) + " is missing!", true);
			}
		}
		loadwhat = 2;
		break;
}
draw_set_align();
