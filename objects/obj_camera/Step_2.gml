player = playerobj

// shaking when collect get
if collect_shake > 0
	collect_shake = min(collect_shake * 0.5, 20);

// shake health count
if healthshaketime > 0
{
	healthshaketime--
	healthshake = random_range(-2, 2)
}
else
	healthshake = 0

if healthold != global.playerhealth
{
	if healthold <= global.playerhealth
		playerhealthup = true
	else
		playerhealthup = false
	healthshaketime = 30
	healthold = global.playerhealth	
}
p2pdistancex = 0

// check if it should draw the hud or not
if room == strongcold_endscreen or room == rank_room or room == timesuproom or room == Oldtitlescreen or room == characterselect or room == editor_entrance
or (instance_exists(obj_gms) && global.__chat)
	drawhud = false
else 
	drawhud = true
visible = true;

if room == timesuproom
	timestop = true;

// combo
if global.combo > 0
{
    alarm[4] = 2
    global.savedcombo = global.combo
	
    var ct = global.combotime
    if ct <= 40
    {
        if alarm[5] == -1
        {
            if ct >= 20
                alarm[5] = 12
            else
                alarm[5] = 5
        }
    }
    else
        combobubblevisible = true
}

// spawn pizzaface
if global.seconds <= 0 && global.minutes <= 0 && !ded
{
	if global.miniboss or global.snickchallenge or global.gameplay == 0
	{
		alarm[1] = -1;
		alarm[2] = 1;
	}
	
	if global.snickchallenge && !audio_is_playing(global.jukebox)
		audio_stop_sound(global.music);
	
	ded = true
}

// timer logic
if global.seconds < 0 
{
	global.seconds = 59
	global.minutes -= 1
}
if global.seconds > 59
{
	global.minutes += 1
	global.seconds -= 59
}

// timed gate timer
if global.timedgatetime > 0
	global.timedgatetime--;
else
	global.timedgatetime = 0;

// pizza time shaking
if global.panicshake && global.panic && !instance_exists(obj_secretfound)
{
	if global.gameplay != 0
		shake_mag_panic = 2;
	else if global.minutes < 1
		shake_mag_panic = 1.5;
	else
		shake_mag_panic = 1;
}
else
	shake_mag_panic = 0;

// hitlag shake
if instance_exists(player) && player.state == states.hitlag
{
	shake_mag = 3;
	shake_mag_acc = 0.5;
}

// decelerate shaking
if shake_mag > 0
	shake_mag = max(shake_mag - shake_mag_acc, 0);

// target override
if targetoverride != noone
{
	var target = targetoverride;
	var coopdistance = 0;
}
else
{
	var target = player;
	var coopdistance = 0;
}

// camera zoom
camera_set_view_size(view_camera[0], 960 / zoom, 540 / zoom);

// calculate shaking
if shake_mag != 0
or shake_mag_panic != 0
{
	var shkh = 0, shkv = 0;
	
	if scr_stylecheck(0)
	{
		shkh = 0;
		shkv = irandom_range(-shake_mag, shake_mag);
	}
	else
	{
		shkh = irandom_range(-shake_mag, shake_mag);
		shkv = irandom_range(-shake_mag, shake_mag) + irandom_range(-shake_mag, shake_mag);
		// that's how it is in april build
	}
		
	if shake_mag_panic != 0
		shkv += irandom_range(-shake_mag_panic, shake_mag_panic);
}
else
{
	shkh = 0;
	shkv = 0;
}

// actual camera
if instance_exists(player) && player.state != states.timesup && player.state != states.rotate && player.state != states.gameover && room != editor_entrance
{
	// vars
	var WC_oobcam = (safe_get(obj_shell, "WC_oobcam") == true);
	
	var cam_view = view_camera[0];
	var cam_width = camera_get_view_width(cam_view);
	var cam_height = camera_get_view_height(cam_view);
	var cam_xprev = camera_get_view_x(cam_view);
	var cam_yprev = camera_get_view_y(cam_view);
	
	// detached golf camera
	if detach && player.state == states.golf
	{
		var xx = camera_get_view_x(cam_view), yy = camera_get_view_y(cam_view);
		var chspd = 5;
		
		var moveh = player.key_left + player.key_right, movev = -player.key_up + player.key_down;
		
		xx += moveh * chspd;
		yy += movev * chspd;
		
		targetgoingback = true;
		camera_set_view_pos(cam_view, lerp(xx, cam_xprev, (0.9 * global.camerasmoothing) * !frameone), lerp(yy, cam_yprev, (0.9 * global.camerasmoothing) * !frameone));
	}
	else
	{
		detach = false;
		
		// camera pan
		if instance_exists(target) && target.id == player.id
		{
			if chargecamera == 0 && abs(chargeprev) > 2
				chargesmooth = chargeprev;
			chargesmooth = median(chargesmooth - 16, 0, chargesmooth + 16);
			
			// mach
			if ((player.state == states.mach2 && global.gameplay != 0) or player.state == states.mach3 or (player.state == states.tumble && global.gameplay == 0) or (player.state == states.rideweenie && global.gameplay == 0) or player.state == states.machroll or player.state == states.rocket)
			{
				var ch = sign(player.xscale) * 100, chspd = 2;
				if global.gameplay != 0
				{
					chspd = 0.3;
					if (abs(player.hsp) >= 16 or (player.state == states.chainsaw && player.tauntstoredmovespeed >= 16)) && player.state != states.climbwall && player.state != states.Sjump
						chspd = 2;
					
					ch = sign(player.xscale) * (abs(player.movespeed / 4) * 50);
					if (ch > 0 && chargecamera < 0) or (ch < 0 && chargecamera > 0)
						chspd = 8;
				}
				
				chargecamera = Approach(chargecamera, ch, chspd);
			}
			else if chargecamera != 0
			{
				var chspd = 2;
				if global.gameplay != 0
				{
					chspd = 6;
					if player.state == states.machslide
						chspd = 10;
				}
				chargecamera = Approach(chargecamera, 0, chspd);
			}
			
			// crouch
			if scr_stylecheck(2) && ((player.state == states.crouch or (player.character == "S" && player.state == states.normal)) && player.hsp == 0)
			&& !crouchcameragoingback && player.key_down
			{
				if crouchcamera < 1
					crouchcamera += 0.02;
				else
					crouchcamera = min(crouchcamera + 2, 100);
			}
			else
			{
				crouchcameragoingback = true;
				crouchcamera = max(crouchcamera - 4, 0);
			
				if crouchcamera <= 0
					crouchcameragoingback = false;
			}
		}
		else
		{
			chargecamera = 0;
			crouchcamera = 0;
		}
		chargeprev = chargecamera;
	
		// manual camera pan
		if pancur[0] != panto[0]
			pancur[0] = median(pancur[0] - 2, panto[0], pancur[0] + 2);
		if pancur[1] != panto[1]
			pancur[1] = median(pancur[1] - 2, panto[1], pancur[1] + 2);
		
		// set camera position
		var cameraheight = global.gameplay == 0 ? 0 : 50;
		if is_real(target) && instance_exists(target)
		{
			lastx = -1;
			lasty = -1;
			
			if targetgoingback
			{
				var maxspeed = 25;
				if target == player
				{
					if player.state == states.hurt
						maxspeed = 50;
				}
			
				// calculate target pos
				var tx = target.x - (cam_width / 2) + chargecamera + chargesmooth + pancur[0];
				var ty = target.y - (cam_height / 2) + floor(crouchcamera) + pancur[1] - cameraheight;
			
				// go to position
				var xx = Approach(camera_get_view_x(cam_view), tx, maxspeed);
				var yy = Approach(camera_get_view_y(cam_view), ty, maxspeed);
			
				// stop when done
				if xx == tx && yy == ty
					targetgoingback = false;
			}
			else
			{
				// normal camera
				var xx = target.x - (cam_width / 2) + chargecamera + chargesmooth + pancur[0];
				var yy = target.y - (cam_height / 2) + floor(crouchcamera) + pancur[1] - cameraheight;
			}
			camera_set_view_pos(cam_view, lerp(xx, cam_xprev, (0.9 * global.camerasmoothing) * !frameone), lerp(yy, cam_yprev, (0.9 * global.camerasmoothing) * !frameone));
		}
		else
		{
			// no target
			if lastx == -1 && lasty == -1
			{
				lastx = camera_get_view_x(cam_view);
				lasty = camera_get_view_y(cam_view);
			}
			camera_set_view_pos(cam_view, lastx + pancur[0], lasty + pancur[1]);
		}
	}
	
	if room != custom_lvl_room
	{
		// limit camera
		if !WC_oobcam
		{
			// camera region lock
			var leftlock = round(limitcam[0]), rightlock = round(limitcam[2]), uplock = round(limitcam[1]), downlock = round(limitcam[3]);
			camera_set_view_pos(cam_view,
				clamp(camera_get_view_x(cam_view), leftlock, rightlock - cam_width) + shkh,
				clamp(camera_get_view_y(cam_view), uplock, downlock - cam_height) + shkv
			);
		}
	}
	else
	{
		#region EDITOR CAMERA
		
		if bound_camera
		{
			if !WC_oobcam
			{
				camera_set_view_pos(cam_view,
					clamp(camera_get_view_x(cam_view), player.cam.x, player.cam.x + player.cam_width - cam_width) + shkh,
					clamp(camera_get_view_y(cam_view), player.cam.y, player.cam.y + player.cam_height - cam_height) + shkv
				);
			}
			
			if player.cam != noone // render
			{
				with obj_baddiecollisionbox
				{
					if !instance_exists(baddieID) or (!baddieID.thrown && baddieID.state != states.grabbed)
						instance_deactivate_object(id);
				}
				with obj_baddie
				{
					if !thrown && state != states.grabbed
						instance_deactivate_object(id);
				}
				instance_deactivate_object(obj_forkhitbox);
				instance_deactivate_object(obj_cheesedragon);
				instance_deactivate_object(obj_baddiespawner);
				
				var offset = 64;
				instance_activate_region(player.cam.x - offset, player.cam.y - offset, player.cam_width + offset, player.cam_height + offset, true);
			}
			else
			{
				instance_activate_object(obj_baddiecollisionbox);
				instance_activate_object(obj_forkhitbox);
				instance_activate_object(obj_baddie);
				instance_activate_object(obj_cheesedragon);
				instance_activate_object(obj_baddiespawner);
			}
		}
		else
			camera_set_view_pos(cam_view, camera_get_view_x(cam_view) + shkh, camera_get_view_y(cam_view) + shkv);
		
		#endregion
	}
	
	// player outside camera
	if target != player && !WC_oobcam
	{
		var _l = camera_get_view_x(cam_view);
		var _t = camera_get_view_y(cam_view);
		var _r = camera_get_view_x(cam_view) + cam_width;
		var __b = camera_get_view_y(cam_view) + cam_height;
		var _edge_x = cam_width / 2 - 64;  //change constant "32" to change arrow dist from edge of view (in room pixels)
		var _edge_y = cam_height / 2 - 64;  //change constant "32" to change arrow dist from edge of view (in room pixels)
		var _view_center_x = (_l + _r) / 2;
		var _view_center_y = (_t + __b) / 2;
		var _x1, _y1, _x2, _y2;
		
		with player
		{
			if !collision_rectangle(_l, _t, _r, __b, id, false, false)
			{
				_x1 = x - _view_center_x;
				_y1 = y - _view_center_y;
				if abs(_x1 / _edge_x) > abs(_y1 / _edge_y) { _x2 = sign(_x1) * _edge_x; _y2 = _x2 / _x1 * _y1; } 
				else { _y2 = sign(_y1) * _edge_y; _x2 = _y2 / _y1 * _x1; }
						
				ds_queue_enqueue(other.edge_indicator, _view_center_x + _x2);
				ds_queue_enqueue(other.edge_indicator, _view_center_y + _y2);
				ds_queue_enqueue(other.edge_indicator, point_direction(0, 0, _x1, _y1));
			}
		}
	}
}
else if !(instance_exists(player) && player.state == states.rotate) && !instance_exists(obj_onlinemenu)
{
	// don't move camera with any object but support shaking
	if lastx == -1 && lasty == -1
	{
		lastx = _camx;
		lasty = _camy;
	}
	camera_set_view_pos(view_camera[0], lastx + shkh, lasty + shkv);
}

// update wave
var panicangle = 0;
if global.panic or global.snickchallenge
{
	if global.gameplay == 0
	{
		var camsmooth = max(alarm[1] / 60, 0);
		if alarm[1] == -1 or (global.minutes == 0 && global.seconds == 0)
			camsmooth = 0;
	
		global.wave = max(global.maxwave - (global.minutes * 60 + global.seconds + camsmooth) * 60, 0);
	}
	else
		global.wave = global.maxwave - global.fill;
	
	// tilting
	if check_sugary()
	{
		var mult = global.wave / global.maxwave;
		panicangle = sin(current_time / 8000) * mult * 4;
	}
}

frameone = false;
camera_set_view_angle(view_camera[0], Approach(camera_get_view_angle(view_camera[0]), round(angle) + panicangle, 1));
