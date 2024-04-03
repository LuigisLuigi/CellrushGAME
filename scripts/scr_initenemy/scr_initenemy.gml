function scr_initenemy()
{
	state = states.walk
	basegrav = 0.5
	grav = 0.5
	hsp = 0
	vsp = 0
	xscale = 1
	yscale = 1
	stunned = 0
	alarm[0] = 150
	roaming = true
	flying = false
	straightthrow = false
	stomped = false
	thrown = false
	thrown_vertically = false
	reset = false
	bombreset = 0
	hp = 1
	grounded = true
	
	flash = false
	birdcreated = false
	boundbox = false
	important = false
	heavy = false
	
	arenalayer = layer
	depth = 0
	
	grabbedby = 0
	paletteselect = 1
	stuntouchbuffer = 0
	scaredbuffer = 0
	movespeed = 1
	
	ragespr = spr_cheeseslime_rage
	ragebuffer = 0
	ragehitbox = false
	ragecooldown = 0
	
	img_angle = image_angle
	offsetted = false
	steppy = 20

	invincible = false
	bumpable = true
	stompable = true
	killbyenemy = true
	groundpound = true
	instantkillable = true
	stunnable = true
	parryable = true
	destroyable = true
	killreward = true
	
	pepperman_grab = false
	stagger_buffer = -1
	stagger_max = 45
	stagger_jumpspeed = 4
	stagger_movespeed = 1
	stagger_dir = 1
	hitLag = 25
	hitX = x
	hitY = y
	hitvsp = 0
	hithsp = 0
	dodgebuffer = 0
	arcprojectiletimer = 0
	
	if !variable_instance_exists(id, "escape")
		escape = false;
	if !variable_instance_exists(id, "elite")
		elite = false;
	oggrav = 0.5
	arena = false
	wave = 0
	rage = false
	instakilled = false
	killprotection = false
	
	haspalette = false
	rematchscare = false
	clipin = 60
	
	haspalette = false;
	spr_palette = palette_cheeseslime;
	paletteselect = 0;
	
	invtime = 0; // april build hitstun cooldown
	
	custom_death_fnc = -1;
	ghost = false;
	
	railmovespeed = 0;
	blur_effect = 0;
	dashcloudid = noone;
}

