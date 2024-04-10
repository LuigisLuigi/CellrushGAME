// show text
if showtext && !(instance_exists(obj_tv) && sprite_exists(obj_tv.bubblespr))
	yi = min(yi + 5, 30);
else
{
	if showtext
	{
		yi -= 5;
		if alarm[0] > -1
			alarm[0]++;
	}
	yi = max(yi - 1, -50);
}

// hide text
alpha = 1;
if scr_stylecheck(2)
{
	with obj_player
	{
		if x >= _camx + other.xi - 384 / 2 && x <= _camx + other.xi + 384 / 2
		&& y >= _camy + other.yi - 72 / 2 && y <= _camy + other.yi + 72 / 2
			other.alpha = 0.5;
	}
}

