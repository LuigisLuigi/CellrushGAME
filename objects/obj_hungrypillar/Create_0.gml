event_inherited()
image_speed = 0.35
depth = 2

if room == rm_editor
	if place_meeting(x, y + 32, obj_solid)
		while !place_meeting(x, y + 1, obj_solid)
			y += 1;
song = -1;

spr_idle = spr_hungrypillar;
spr_angry = spr_hungrypillar_angry;
spr_happy = spr_hungrypillar_happy;
spr_dead = spr_hungrypillar_dead;

if global.gameplay != 0
{
	if check_sugary()
	{
		spr_idle = spr_hungrypillar_ss;
		spr_angry = spr_hungrypillar_ss;
		spr_happy = spr_hungrypillar_ss;
		spr_dead = spr_hungrypillardead_ss;
	}
	else
	{
		spr_idle = spr_hungrypillar_NEW;
		spr_angry = scr_stylecheck(2) ? spr_hungrypillar_angry_NEW : spr_hungrypillar_NEW;
		spr_happy = spr_hungrypillar_NEW;
		spr_dead = spr_hungrypillar_dead_NEW;
	}
}
else if check_sugary()
{
	spr_idle = spr_hungrypillarOLD_ss;
	spr_angry = spr_hungrypillarOLD_ss;
	spr_happy = spr_hungrypillarOLD_ss;
	spr_dead = spr_hungrypillardeadOLD_ss;
}

if global.snickrematch
{
	spr_idle = spr_hungrypillar_re;
	spr_angry = spr_hungrypillar_re;
	spr_happy = spr_hungrypillar_re;
	spr_dead = spr_hungrypillar_dead_re;
}
sprite_index = spr_idle;
