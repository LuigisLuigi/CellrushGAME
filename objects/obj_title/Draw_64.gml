if object_index == obj_title
{
	if instance_exists//(obj_filedoor) && obj_filedoor.loading
	{
		depth = -98;
		obj_title2.visible = true;
		
		//draw_set_font(global.bigfont);
		draw_set_colour(c_white);
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		//draw_text(obj_title2.bbox_left + random_range(-1, 1), obj_title2.bbox_top, "loading...");
		
		/*
		if debug
		{
			if draw_editorbutton(64, 128, "SKIP")
			{
				instance_destroy(obj_gms);
				offline_travel();
			}
		}
		*/
	}
}


if object_index == obj_title2
{
	if instance_exists
	{
		depth = -98;
		obj_title2.visible = true;
	}
}
