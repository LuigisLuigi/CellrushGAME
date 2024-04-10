/// @description travel
var r = rm_disclaimer;
if global.crashed[0] == true
{
	array_push(global.crashed, r);
	room_goto(rm_crashed);
}
else
	room_goto(r);
