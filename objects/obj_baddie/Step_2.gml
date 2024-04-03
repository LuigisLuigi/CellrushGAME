/// @description
if global.gameplay == 0 && hp > 1
	hp = 1;

// attempt to resolve instance region issue
if room == custom_lvl_room
{
	if boundbox && !place_meeting(x, y, obj_baddiecollisionbox)
	{
		var tryfix = true;
		with obj_baddiecollisionbox
		{
			if baddieID == other.id
				tryfix = false;
		}
		
		if tryfix
			boundbox = false;
	}
}

// inside a block
var sold = instance_place(x, y, obj_solid);
if sold && !inst_relation(sold, obj_slope)
{
	if state != states.grabbed && state != states.hit
	&& !inst_isobj(sold, obj_enemyblock)
	&& (!inst_relation(sold, obj_destructibles) or !thrown
	or (inst_relation(sold, obj_onewaybigblock) && sign(image_xscale) == -sign(other.hsp)))
		instance_destroy();
}

// break blocks when thrown
if thrown && state != states.hit && abs(hsp) > 0
{
	with obj_destructibles
	{
		if place_meeting(x - other.hsp, y, other)
		&& !(inst_relation(id, obj_onewaybigblock) && sign(image_xscale) == sign(other.hsp))
		{
			if scr_stylecheck(2)
				momentum[0] = other.hsp;
			instance_destroy();
		}
	}
	if abs(hsp) < 24 && grav == 0
		grav = 0.35;
}

// collide or get grabbed
if state != states.grabbed
{
	clipin = 60;
	scr_collide();
}
else if object_index != obj_tankOLD
	scr_enemy_grabbed();

if invtime > 0 && state != states.hit
	invtime--;

xscale = Approach(xscale, 1, 0.03);
yscale = Approach(yscale, 1, 0.03);

// heat meter image speed and cloud effects
if global.gameplay != 0
{
	if state == states.walk
		image_speed = 0.35 + (global.baddiespeed * 0.05);
	
	if state != states.chase
	{
		if floor(image_index) >= image_number - 1 && image_number > 1 && sprite_index == walkspr && hsp != 0 && grounded
		{
			if !steppy
				instance_create(x - image_xscale * 20, bbox_bottom, obj_cloudeffect);
			steppy = true;
		}
		else
			steppy = false;
	}
}

// provoke
var targetplayer = instance_nearest(x, y, obj_player);
if targetplayer && targetplayer.x > x - 400 && targetplayer.x < x + 400 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
&& targetplayer.state == states.backbreaker && state != states.pizzagoblinthrow && targetplayer.taunttimer < targetplayer.taunt_to_parry_max
{
	stunned = 0;
	bombreset = 0;
	scaredbuffer = 0;
}

