/// @description Check if object is standing on a slope
function scr_slope(xx = x, yy = y + 1) 
{
	var xold = x, yold = y;
	
	x = xx;
	y = yy;
	
	var slope = check_slope(obj_slope)
	if slope
	{
		x = xold;
		y = yold;
		return true;
	}

	x = xold;
	y = yold;
	return false;
}

