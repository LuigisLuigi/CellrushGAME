/// @description states.normal if hurt
if state == states.hurt or state == states.backbreaker
{
	state = states.normal;
	movespeed = 0;
}
