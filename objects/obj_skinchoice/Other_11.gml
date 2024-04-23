if playerid.state == states.normal
{
	var prevanton = scr_checkskin(checkskin.p_anton, playerid);
	var prev = playerid.character;
	
	with playerid
	{
		shot = false;
		shotgunAnim = false;
		global.gotshotgun = false;
		pogochargeactive = false;
			
		character = other.sel[1];
		scr_characterspr();
		sprite_index = spr_idle;
		scr_changetoppings();
		
		noisetype = other.noisetype;
		
		if character != prev
		or paletteselect != other.sel[0]
		{
			instance_create(x, y, obj_genericpoofeffect);
			if global.gameplay != 0 && character != prev
			{
				with obj_tv
				{
					if sprite_index != spr_tv_open
						tvsprite = idlespr;
				}
			}
		}
		paletteselect = other.sel[0];
	}
		
	if ((scr_checkskin(checkskin.p_anton, playerid) && !prevanton))
	or ((!scr_checkskin(checkskin.p_anton, playerid) && prevanton))
	{
		// reset song if anton
		if playerid.object_index == playerobj
		{
			with obj_hungrypillar
			{
				audio_stop_sound(song);
				song = -1;
			}
			with obj_music
			{
				fadeoff = 0;
				event_perform(ev_other, ev_room_start);
			}
		}
		
		if scr_checkskin(checkskin.p_antononly, playerid)
			scr_soundeffect(sfx_antonball);
		else
			scr_soundeffect(sfx_collecttoppin);
	}
	else
	{
		scr_soundeffect(sfx_collecttoppin);
		scr_characterentrance();
	}
	
	selected = true;
	if spr_select != spr_idle
		img = 0;
	
	t = 2;
	con = 0;
}

