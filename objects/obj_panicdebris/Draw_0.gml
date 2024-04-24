for(var i = 0; i < array_length(debris); i++)
{
	var d = debris[i];
	if is_struct(d)
	{
		if d.y >= room_height + 64
			array_delete(debris, i, 1);
		else
		{
			draw_sprite_ext(spr_debris, d.img, d.x, d.y, image_xscale, image_yscale, d.ang, image_blend, image_alpha);
			d.x += d.hsp;
			d.y += d.vsp;
			if d.vsp < 12
				d.vsp += 0.4;
		}
	}
}

