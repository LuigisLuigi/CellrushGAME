if object_index == obj_title
{
	with obj_tv
	{
		alarm[0] = -1;
		event_perform(ev_alarm, 0);
	}

	with obj_player1
		xscale = 1;
}