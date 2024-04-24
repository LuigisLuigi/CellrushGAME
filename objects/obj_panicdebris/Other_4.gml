// spawn random debris
debris = [];
if global.panic
{
	repeat min(round((room_width * room_height) / (960 * 540)) * 8, 64)
	{
		array_push(debris, {
			x : irandom(room_width),
			y : irandom(room_height),
			ang : irandom_range(1, 360),
			img : irandom_range(0, 5),
			vsp : 12,
			hsp : random_range(-4, 4),
		});
	}
}
event_user(0);

