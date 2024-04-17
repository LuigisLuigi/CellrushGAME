/// @description restart music
with obj_player
{
	if state == states.victory && place_meeting(x, y, obj_startgate)
		exit;
}
if room == custom_lvl_room
	event_perform(ev_alarm, 0);
else
	event_perform(ev_other, ev_room_start);

