if live_call() return live_result;

zoomfactor = max(1 + (1 - obj_camera.zoom), 1);
function layer_get_parallax(layer_id)
{
	var roomwidth = room_width, roomheight = room_height;
	var camx = _camx, camy = _camy, camw = _camw, camh = _camh;
	
	if instance_exists(obj_camera) && instance_exists(obj_player)
	&& obj_camera.bound_camera && instance_exists(obj_player.cam)
	{
		roomwidth = obj_player.cam_width;
		roomheight = obj_player.cam_width;
		camx -= obj_player.cam.x;
		camy -= obj_player.cam.y;
	}
	
	var n = layer_get_name(layer_id);
	switch n
	{
		case "Backgrounds_1": return [camx * 0.25, camy * 0.25]; break;
		case "Backgrounds_2": return [camx * 0.15, camy * 0.15]; break;
		case "Backgrounds_3": return [camx * 0.05, camy * 0.05]; break;
		
		case "Backgrounds_fore1": return [camx * -0.1, camy * -0.1]; break;
		case "Backgrounds_Ground1": return [camx * 0.3, roomheight - camh + ((roomheight - (camy + camh)) * -0.3)]; break;
		case "Backgrounds_Ground2": return [camx * 0.35, roomheight - camh + ((roomheight - (camy + camh)) * -0.35)]; break;
		case "Backgrounds_H1": return [camx * 0.25, camy]; break;
		
		case "Backgrounds_sky": return [camx * 0.85, camy * 0.85]; break;
		case "Backgrounds_sky2": return [camx * 0.9, camy * 0.9]; break;
		case "Backgrounds_sky3": return [camx * 0.95, camy * 0.95]; break;
		case "Backgrounds_sky4": return [camx, camy]; break;
		
		case "Backgrounds_scroll": return [camx * 0.25, camy * 0.25]; break;
		case "Backgrounds_FG": return [(layer_get_x(layer_id) - camx) * 0.15, (layer_get_y(layer_id) - camy) * 0.15]; break;
		
		case "Backgrounds_still1":
		case "Backgrounds_still2":
		case "Backgrounds_stillH1":
		case "Backgrounds_stillH2":
		case "Backgrounds_stillH3":
			var p = [0, 0], hor = true;
			switch n
			{
				case "Backgrounds_still1": p = [0.15, 0.15]; break;
				case "Backgrounds_still2": p = [0.25, 0.25]; break;
				case "Backgrounds_stillH1": p = [0.25, 0.15]; hor = false; break;
				case "Backgrounds_stillH2": p = [0.35, 0.15]; hor = false; break;
				case "Backgrounds_stillH3": p = [0.95, 0.15]; hor = false; break;
			}
			if hor
				var returnx = camx - clamp(camx * p[0] * (960 / roomwidth), 0, sprite_get_width(layer_background_get_sprite(layer_background_get_id(layer_id))) - 960);
			else
				returnx = camx * p[0];
			
			return [returnx, camy - clamp(camy * p[1] * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_id))) - 540)]; break;
		
		// pinpan moment
		case "Backgrounds_steamcc1": return [camx * 0.95, camy * 0.95]; break;
		case "Backgrounds_steamcc2": return [camx * 0.75, camy * 0.75]; break;
		case "Backgrounds_steamcc3": return [camx * 0.25, (room_height - 560) + ((room_height - (camy + camh)) * 0.25)]; break;
		case "Backgrounds_steamcc5": return [camx * 0.65, camy * 0.65]; break;
	}
	return [0, 0];
}

var siz = ds_list_size(global.roombgs); // faster this way
for(var i = 0; i < siz; i++)
{
	var l = global.roombgs[|i];
	l.x += l.hsp;
	l.y += l.vsp;
	
	var parallax = layer_get_parallax(l.lay);
	if parallax == undefined
		parallax = [0, 0];
	
	layer_x(l.lay, floor(l.x + parallax[0]));
	layer_y(l.lay, floor(l.y + parallax[1]));
	
	// scale the backgrounds up if the camera zooms out
	if layer_get_depth(l.lay) >= 0
	{
		layer_background_xscale(l.bg, zoomfactor);
		layer_background_yscale(l.bg, zoomfactor);
	}
}
