if room == rm_editor
{
	visible = false;
	exit;
}

if room == custom_lvl_room
{
	if place_meeting(x, y, par_camera_editor)
	{
		cam = instance_place(x, y, par_camera_editor);
		cam_width = instance_place(x, y, par_camera_editor).width;
		cam_height = instance_place(x, y, par_camera_editor).height;
		
		with obj_camera
			bound_camera = true;
	}
	else
	{
		cam = noone;
		cam_width = 0;
		cam_height = 0;
		instance_activate_all();
		
		with obj_camera
			bound_camera = false;
	}
}

switch state
{
	default: state = states.normal;
	case -1: break;
	case states.normal: scr_player_normal (); break;
	case states.revolver: scr_player_revolver (); break;
	case states.dynamite: scr_player_dynamite (); break;
	case states.boots: scr_player_boots (); break;
	case states.grabbed: scr_player_grabbed (); break;
	case states.finishingblow: scr_player_finishingblow (); break;
	case states.tumble: scr_player_tumble (); break;
	case states.titlescreen: scr_player_titlescreen (); break;
	case states.ejected: scr_player_ejected (); break;
	case states.firemouth: scr_player_firemouth (); break;
	case states.fireass: scr_player_fireass (); break;
	case states.transitioncutscene: scr_player_transitioncutscene (); break;
	case states.hookshot: scr_playerN_hookshot (); break;
	case states.slap: scr_player_slap (); break;
	case states.tacklecharge: scr_player_tacklecharge (); break;
	case states.cheesepep: scr_player_cheesepep (); break;
	case states.cheeseball: scr_player_cheeseball (); break;
	case states.cheesepepstick: scr_player_cheesepepstick (); break;
	case states.boxxedpep: scr_player_boxxedpep (); break;
	case states.pistolaim: scr_player_pistolaim (); break;
	case states.climbwall: scr_player_climbwall (); break;
	case states.knightpepslopes: scr_player_knightpepslopes (); break;
	case states.portal: scr_player_portal(); break;
	case states.secondjump: scr_player_secondjump (); break;
	case states.chainsawbump: scr_player_chainsawbump (); break;
	case states.handstandjump: scr_player_handstandjump (); break;
	case states.gottreasure: scr_player_gottreasure (); break;
	case states.knightpep: scr_player_knightpep (); break;
	case states.knightpepattack: scr_player_knightpepattack (); break;
	case states.meteorpep: scr_player_meteorpep (); break;
	case states.bombpep: scr_player_bombpep (); break;
	case states.grabbing: scr_player_grabbing (); break;
	case states.chainsawpogo: scr_player_chainsawpogo (); break;
	case states.shotgunjump: scr_player_shotgunjump (); break;
	case states.stunned: scr_player_stunned (); break;
	case states.highjump: scr_player_highjump (); break;
	case states.chainsaw: scr_player_chainsaw (); break;
	case states.facestomp: scr_player_facestomp (); break;
	case states.timesup: scr_player_timesup (); break;
	case states.machroll: scr_player_machroll (); break;
	case states.pistol: scr_player_pistol (); break;
	case states.shotgun: scr_player_shotgun (); break;
	case states.machfreefall: scr_player_machfreefall (); break;
	case states._throw: scr_player_throw (); break;
	case states.superslam: scr_player_superslam (); break;
	case states.slam: scr_player_slam (); break;
	case states.skateboard: scr_player_skateboard (); break;
	case states.grind: scr_player_grind (); break;
	case states.grab: scr_player_grab (); break;
	case states.punch: scr_player_punch (); break;
	case states.backkick: scr_player_backkick (); break;
	case states.uppunch: scr_player_uppunch (); break;
	case states.shoulder: scr_player_shoulder (); break;
	case states.backbreaker: scr_player_backbreaker (); break;
	case states.bossdefeat: scr_player_bossdefeat (); break;
	case states.bossintro: scr_player_bossintro (); break;
	case states.smirk: scr_player_smirk (); break;
	case states.pizzathrow: scr_player_pizzathrow (); break;
	case states.gameover: scr_player_gameover (); break;
	case states.Sjumpland: scr_player_Sjumpland (); break;
	case states.freefallprep: scr_player_freefallprep (); break;
	case states.runonball: scr_player_runonball (); break;
	case states.boulder: scr_player_boulder (); break;
	case states.keyget: scr_player_keyget (); break;
	case states.tackle: scr_player_tackle (); break;
	case states.slipnslide: scr_player_slipnslide (); break;
	case states.ladder: scr_player_ladder (); break;
	case states.jump: scr_player_jump (); break;
	case states.victory: scr_player_victory (); break;
	case states.comingoutdoor: scr_player_comingoutdoor (); break;
	case states.Sjump: scr_player_Sjump (); break;
	case states.Sjumpprep: scr_player_Sjumpprep (); break;
	case states.crouch: scr_player_crouch (); break;
	case states.crouchjump: scr_player_crouchjump (); break;
	case states.crouchslide: scr_player_crouchslide (); break;
	case states.mach1: scr_player_mach1 (); break;
	case states.mach2: scr_player_mach2 (); break;
	case states.mach3: scr_player_mach3 (); break;
	case states.machslide: scr_player_machslide (); break;
	case states.bump: scr_player_bump (); break;
	case states.hurt: scr_player_hurt (); break;
	case states.freefall: scr_player_freefall (); break;
	case states.freefallland: scr_player_freefallland (); break;
	case states.hang: scr_player_hang (); break;
	case states.door: scr_player_door (); break;
	case states.barrel: scr_player_barrel (); break;
	case states.current: scr_player_current (); break;
	case states.taxi: scr_player_taxi (); break;
	case states.pogo: scr_player_pogo (); break;
	case states.rideweenie: scr_player_rideweenie (); break;
	case states.faceplant: scr_player_faceplant (); break;
	case states.ghost: scr_player_ghost (); break;
	case states.mort: scr_player_mort (); break;
	case states.hook: scr_player_hook (); break;
	case states.actor: scr_player_actor (); break;
	case states.parry: scr_player_parry (); break;
	case states.slipbanan: scr_player_slipbanan (); break;
	case states.hitlag: scr_player_hitlag (); break;
	case states.dance: scr_player_dance (); break;
	case states.rotate: scr_player_rotate (); break;
	case states.frozen: scr_player_frozen (); break;
	case states.spindash: scr_player_spindash (); break;
	case states.golf: scr_player_golf (); break;
	case states.rocket: scr_player_rocket (); break;
	case states.tube: scr_player_tube (); break;
	case states.cotton: if sugaryspire scr_player_cotton (); break;
	case states.fling: if sugaryspire scr_player_fling (); break;
	case states.geyser: if sugaryspire scr_player_geyser (); break;
}

// hardoween noise gravity
if scr_checkskin(checkskin.n_hardoween)
	basegrav = 0.4;
else
	basegrav = 0.5;

if verticalbuffer > 0
    verticalbuffer--
if superchargecombo_buffer > 0
    superchargecombo_buffer--
else if superchargecombo_buffer == 0
{
    superchargecombo_buffer = -1
    global.combotime = 4
}

if !place_meeting(x, y + 1, obj_railparent)
{
    if state == states.mach3 or state == states.mach2 or state == states.tumble
        railmovespeed = Approach(railmovespeed, 0, 0.1)
    else
        railmovespeed = Approach(railmovespeed, 0, 0.5)
}

if state != states.handstandjump && state != states.tumble
    crouchslipbuffer = 0

// blur afterimages
if global.gameplay != 0
{
	if blur_effect > 0
	    blur_effect--
	else if breakdance_speed >= 0.6 or boxxeddash or state == states.ghost or state == states.tumble or state == states.ratmountbounce or state == states.ratmountattack or state == states.handstandjump or state == states.barrelslide or (state == states.grab && sprite_index == spr_swingding && swingdingdash <= 0) or (state == states.punch && (sprite_index == spr_player_breakdanceuppercut or sprite_index == spr_player_breakdanceuppercutend)) or state == states.freefall or (state == states.cotton && (sprite_index == spr_cotton_attack or movespeed > 6))
	{
	    if visible && !place_meeting(x, y, obj_secretportal) && !place_meeting(x, y, obj_secretportalstart)
	    {
	        blur_effect = 2
	        with instance_create(x, y, obj_blurafterimage)
			{
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_xscale = other.xscale
	            playerid = other.id
			}
	    }
	}
}

// invhurt
if global.gameplay != 0
{
	if invhurt_buffer > 0
		invhurt_buffer--;
	if state == states.hurt
	{
		if hurt_buffer > 0
			hurt_buffer--;
		else
		{
			invhurt_buffer = invhurt_max;
			hurt_buffer = -1;
		}
	}
	else
	{
		if hurt_buffer > 0
			invhurt_buffer = invhurt_max;
		hurt_buffer = -1;
	}
}

// heat meter
if global.heattime > 0
	global.heattime -= 0.25;
if global.heattime <= 0 && global.style > -1 && !global.stylelock
	global.style -= 0.05;
if state == states.victory && place_meeting(x, y, obj_startgate) && global.style > -1
	global.style -= 5;

if cutscene or global.miniboss
	global.heattime = 60;

//Titlescreen
if room == Oldtitlescreen
	state = states.titlescreen

if wallclingcooldown < 10
	wallclingcooldown++
if noisebombcooldown > 0
	noisebombcooldown--

//Pepper Pizza
if pizzapepper > 0
{
	angry = true
	anger = 1
	
	pizzapepper--
	if pizzapepper <= 0
	{
		angry = false;
		anger = 0;
	}
}
if global.gameplay == 1
{
	angry = false;
	anger = 0;
}
 
//Supercharge
if global.combo != global.previouscombo
{
    global.previouscombo = global.combo
    if (global.combo % 5) == 0 && global.combo != 0
    {
        with instance_create(x, y - 80, obj_combotitle)
        {
            title = floor(global.combo / 5)
            title = clamp(title, 0, floor(sprite_get_number(spr_comboend_title1) / 5))
        }
    }
}
if ((global.combo >= 3 && global.gameplay == 0) or (supercharge > 9 && global.gameplay != 0))
&& state != states.backbreaker && character != "S"
{
	if character != "V"
		supercharged = true
	else
		anger = 100
}
if !(state == states.door or state == states.tube or state == states.taxi or state == states.gottreasure or state == states.victory or state == states.actor or state == states.comingoutdoor or (state == states.knightpep && (sprite_index == spr_knightpepstart or sprite_index == spr_knightpepthunder)) or instance_exists(obj_fadeout) or place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart))
{
	if global.combotime > 0 && !cutscene && !(character == "SP" && state == states.tacklecharge)
		global.combotime -= global.gameplay == 0 ? 0.5 : 0.15;
}
if global.combotime <= 0 && state != states.backbreaker
{
	global.savedcombo = global.combo;
	global.combotime = 0;
	global.combo = 0;
	supercharge = 0;
	supercharged = false;
}

//Supercharged effect
if !instance_exists(superchargedeffectid) && supercharged
{
	with instance_create(x, y, obj_superchargeeffect)
	{
		playerid = other.object_index	
		other.superchargedeffectid = id
	}
}
if instance_exists(superchargedeffectid) && !supercharged
	instance_destroy(superchargedeffectid);
 
//Pizzashield
if !instance_exists(pizzashieldid) && pizzashield
{
	with instance_create(x,y,obj_pizzashield)
	{
		playerid = other.object_index	
		other.pizzashieldid = id
	}
}
 
//POGO
if state != states.pogo && state != states.backbreaker
{
	pogospeed = 6
	pogospeedprev = false
}

//Player sounds
scr_playersounds()

//Reset doublejump for Noise
if grounded && vsp >= 0
	doublejump = false

//Jetpack flash
if pogochargeactive
{
	if !flashflicker
	{
		if pogochargeactive && sprite_index == spr_playerN_pogofall
			sprite_index = spr_playerN_pogofallmach

		if pogochargeactive && sprite_index == spr_playerN_pogobounce
			sprite_index = spr_playerN_pogobouncemach
	}
	
	flashflicker = true
	pogocharge--
}
else
	flashflicker = false

if state != states._throw
	kickbomb = false

if pogocharge <= 0
{
	pogochargeactive = false
	pogocharge = 100
}

//Flash flicker
if flashflicker
{
	flashflickertime++
	if flashflickertime >= 20
	{
		flash = true
		flashflickertime = 0
	}
}

//Fightball off
if !global.coop
	fightball = false
if state != states.mach3 && state != states.grabbed
	fightball = false

//Thrown at enemy
if state != states.grabbed && state != states.hurt
	thrown = false

//Reset suplex
if grounded && state != states.handstandjump && (state != states.cotton or grounded)
	suplexmove = false;

if state != states.freefall && state != states.hitlag
	freefallsmash = 0

//Die
if global.playerhealth <= 0 && state != states.gameover
{
	image_index = 0
	sprite_index = spr_dead
	state = states.gameover
}

// game over
if state == states.gameover && y > room_height * 2
{
	scr_playerreset();
	if instance_exists(obj_onlinemenu)
	{
		targetDoor = "B";
		state = states.titlescreen;
		room_goto(editor_entrance);
	}
	else
	{
		if scr_stylecheck(2)
		{
			targetDoor = "NONE";
			if backtohubstartx == 0 && backtohubstarty == 0
				targetDoor = "A";
			else
			{
				x = backtohubstartx;
				y = backtohubstarty;
			}
			room_goto(backtohubroom);
		
			backtohubstartx = 0;
			backtohubstarty = 0;
			backtohubroom = hub_room1;
		}
		else
		{
			with obj_player
				targetDoor = "A";
			room_goto(hub_room1);
		}
	}
}

//Out of grab
if (baddiegrabbedID == obj_null or !instance_exists(baddiegrabbedID) or baddiegrabbedID == 0 or baddiegrabbedID == -1) && (state == states.grab or state == states.superslam or state == states.tacklecharge)
	state = states.normal

if !(state == states.grab or state == states.superslam or state == states.mach2 or state == states.finishingblow or state == states.tacklecharge or state == states.backbreaker or state == states.hitlag)
{
	baddiegrabbedID = obj_null
	heavy = false
}

//Grind
if grinding
	state = states.grind

//Angry
if anger > 0
{
	angry = true;
	anger -= 1;
}
else
	angry = false;

// Stop winding up
if sprite_index == spr_winding && state != states.normal 
	windingAnim = 0

if state != states.grab && state != states.grabbed
	swingdingbuffer = 0

// vomit anim
if sprite_index == spr_player_idlevomit && image_index > 28 && image_index < 43
	instance_create(x + random_range(-5, 5), y + 46, obj_vomit)

if sprite_index == spr_player_idlevomitblood && image_index > 28 && image_index < 43
{
	with instance_create(x + random_range(-5, 5), y + 46, obj_vomit)
		sprite_index = spr_vomit2
}

// Sweat
if global.playerhealth <= 30 && state == states.normal
{
	var createsweat = true;
	with obj_sweat
	{
		if playerid == other.id
			createsweat = false;
	}
	if createsweat
	{
		with instance_create(x, y, obj_sweat)
			playerid = other.id;
	}
}
else with obj_sweat
{
	if playerid == other.id
		instance_destroy();
}

//Angry cloud
if (angry or global.stylethreshold >= 2) && !instance_exists(angryeffectid)
&& state == states.normal && character != "V"
{
	with instance_create(x, y, obj_angrycloud)
	{
		playerid = other.object_index
		other.angryeffectid = id	 
	}
}

//Input buffer jumping
if input_buffer_jump < 8
	input_buffer_jump++

//Input buffer second jumping
if input_buffer_secondjump < 8
	input_buffer_secondjump++

//Input buffer high jumping
if input_buffer_highjump < 8
	input_buffer_highjump++

if input_buffer_faceplant < 8
	input_buffer_faceplant++

if shoot_buffer > 0
	shoot_buffer--;

//Key effect
if key_particles
	instance_create(random_range(x + 25, x - 25), random_range(y + 35, y - 25), obj_keyeffect)

if inv_frames = false && hurted = false && state != states.ghost
image_alpha = 1

//Attack
if (state == states.crouchslide) or (state == states.punch) or (state = states.mach2) or (state == states.jump && sprite_index = spr_playerN_noisebombspinjump) or (state == states.tacklecharge) or (state == states.skateboard) or (state == states.knightpep) or (state == states.boxxedpep) or (state == states.cheesepep) or  (state = states.knightpepslopes) or  (state = states.knightpepattack) or   (state = states.bombpep) or  (state = states.facestomp) or (state == states.machfreefall) or (state == states.facestomp) or (state == states.machroll)  or (state == states.mach3) or (state == states.freefall) or (state == states.Sjump) 
	attacking = true
else
	attacking = false

//Grab Moves
if (state == states._throw) or (state == states.punch) or (state == states.backkick) or (state == states.shoulder) or (state == states.uppunch)
	grabbing = true
else
	grabbing = false

//Instant-Kill Attack
if state == states.barrel or (state == states.crouchslide) or (state == states.faceplant) or (state == states.rideweenie) or (state == states.mach3) or (state == states.jump && sprite_index == spr_playerN_noisebombspinjump) or (state == states.slipnslide) or (state == states.hurt && thrown) or (state == states.mach2) or (state == states.climbwall) or (state == states.freefall)
or state == states.tumble or (state == states.fireass) or (state == states.firemouth) or (state == states.hookshot) or (state == states.skateboard) or  (state = states.mach4) or (state == states.Sjump) or (state == states.machroll) or (state == states.machfreefall) or (state == states.tacklecharge)  or (state == states.superslam && sprite_index = spr_piledriver) or (state == states.knightpep) or (state == states.knightpepattack) or (state == states.knightpepslopes)  or (state == states.boxxedpep) or (state == states.cheesepep) or (state == states.cheeseball) or (state == states.slipbanan) or (state == states.spindash) or (state == states.handstandjump && (sprite_index == spr_attackdash or sprite_index == spr_airattackstart or sprite_index == spr_airattack)) or state == states.chainsawbump or state == states.rocket
or state == states.punch or (state == states.ratmountbounce && vsp >= 0) or sprite_index == spr_player_Sjumpcancel or (sprite_index == spr_swingding && global.gameplay != 0) or state == states.boxxedpepspin or state == states.trashroll or state == states.trashjump or sprite_index == spr_player_Sjumpcancelslide
	instakillmove = true
else
	instakillmove = false

//Flash																	  
if flash && alarm[0] <= 0
	alarm[0] = 0.15 * room_speed;

//Reset Variables
if state != states.Sjump
	sjumpvsp = -12;

if state != states.freefall && state != states.cotton
	freefallvsp = 15;

if state != states.mach3 && state != states.machslide
	autodash = false

if (state != states.jump && state != states.crouchjump && state != states.slap) or vsp < 0
	fallinganimation = 0

if state != states.freefallland && state != states.normal && state != states.machslide
	facehurt = false

if state != states.normal && state != states.machslide
	machslideAnim = false

if state != states.normal
{
	idle = 0
	dashdust = false
}

// reset momentum
if state != states.hitlag && state != states.mach1 && state != states.jump && state != states.hookshot && state != states.handstandjump && state != states.normal && state != states.mach2 && state != states.mach3 && state != states.freefallprep && state != states.knightpep && state != states.shotgun && state != states.knightpepslopes && state != states.faceplant && state != states.cotton
	momentum = false

// reset super side jump speed?
if state != states.Sjump && state != states.Sjumpprep
	a = 0

// reset face stomp anim
if state != states.facestomp
	facestompAnim = false

// reset super slam time
if state != states.freefall && state != states.facestomp && state != states.superslam && state != states.freefallland
	superslam = 0

// reset mach punch anim
if state != states.mach2
	machpunchAnim = false

// ladder buffer
if state != states.jump && state != states.ladder
	ladderbuffer = 0
else if ladderbuffer > 0
	ladderbuffer--

// reset stomp
if state != states.jump
	stompAnim = false

// reset gravity
if state != states.grabbing && state != states.barrel && state != states.tumble && state != states.ghost && sprite_index != spr_pmortjump && state != states.cotton && state != states.fling
	grav = basegrav;
else if state == states.barrel or (state == states.tumble && global.gameplay != 0)
	grav = 0.6;

// reset shot variable
if state != states.pistol && state != states.normal
	shot = false

// reset mort
if mort
{
	if state != states.normal && state != states.jump && state != states.handstandjump && state != states.pistol
		mort = false;
}

// reset black fade
if state != states.comingoutdoor && c < 255
{
	c = 255;
	image_blend = c_white;
}

// pizzelle one time super jump
if grounded && state != states.Sjump
	sjump = true;

// colorful afterimages
if state == states.mach3 or pizzapepper > 0 or sprite_index == spr_barrelroll
or (state == states.parry && global.gameplay != 1) or state == states.rideweenie 
or state == states.climbwall or (state == states.jump && sprite_index == spr_playerN_noisebombspinjump)
or pogochargeactive or state == states.hookshot or state == states.mach2
or state == states.tacklecharge or state == states.machslide
or (state == states.machroll)
or (state == states.handstandjump && global.gameplay == 0)
or (state == states.Sjump && global.gameplay == 0)
or (state == states.chainsaw && mach2 >= 100)
or (state == states.cotton && (sprite_index == spr_cotton_attack or movespeed > 6) && global.gameplay == 0)
or (state == states.pogo && character == "SP" && pogospeed >= 12)
{
	if !macheffect
	{
		macheffect = true;
		toomuchalarm1 = 6;
	}
	
	toomuchalarm1 -= 1;
	if toomuchalarm1 <= 0
	{
		with instance_create(x, y, obj_mach3effect)
		{
			playerid = other.id
			image_index = other.image_index
			image_xscale = other.xscale
			sprite_index = other.drawspr
			image_angle = other.img_angle
		}
		toomuchalarm1 = 6
	}
}
else
{
	macheffect = false;
	with obj_mach3effect
	{
		if !keep && playerid == other.id
		{
			if playerid.character != "SP" or global.gameplay == 0
				instance_destroy();
			else
				image_alpha -= 0.1;
		}
	}
}

// Bottomless pits
if (y > room_height + 200 or place_meeting(x, y, obj_backtostart)) && !cutscene
&& room != custom_lvl_room && room != rank_room && canfall
&& state != states.gameover && state != states.comingoutdoor && visible
{	
	grav = basegrav;
	vsp = 10;
	hsp = 0;
	
	x = roomstartx;
	y = roomstarty;
	if instance_exists(obj_falloffrespawn)
	{
		var falloffrespawn = instance_nearest(x, y, obj_falloffrespawn);
		x = falloffrespawn.x;
		y = falloffrespawn.y;
	}
	
	scr_transfobump(false);
	
	if !skateboarding
	{
		state = states.freefall;
		if place_meeting(x, y + 8, obj_boxofpizza)
		{
			state = states.crouchjump;
			jumpstop = true;
			vsp = -4;
		}
	}
}

//Mask
if character == "S"
{
	if state == states.crouchjump or state == states.crouch
		state = states.normal;
	
	if state == states.bombpep or state == states.firemouth or state == states.hurt or state == states.cheeseball
		mask_index = spr_player_mask
	else
		mask_index = spr_crouchmask
}
else
{
	if !scr_solid_player(x, y)
	{
		if state != states.bump && state != states.ghost && sprite_index != spr_player_barrelslipnslide && sprite_index != spr_barrelroll  && sprite_index != spr_bombpepintro && sprite_index != spr_knightpepthunder && state != states.tumble && state != states.stunned   && state != states.crouch && state != states.boxxedpep && (state != states.pistol or sprite_index != spr_player_crouchshoot) && state != states.Sjumpprep && state != states.crouchslide && state != states.chainsaw && state != states.machroll && state != states.hurt && state != states.crouchjump && sprite_index != spr_player_breakdancesuper && sprite_index != spr_cotton_roll && sprite_index != spr_cotton_rollmax
		{
			mask_index = spr_player_mask;
			if scr_solid_player(x, y)
				mask_index = spr_crouchmask;
		}
		else
			mask_index = spr_crouchmask
	}
	else
	{
		// push out of block
		if state == states.jump or state == states.ladder
			y++;
		else
			mask_index = spr_crouchmask;
	}
}

// cutscene
cutscene = (
	state == states.gottreasure or sprite_index == spr_knightpepstart or sprite_index == spr_knightpepthunder
	or state == states.keyget or state == states.door or state == states.ejected
	or state == states.victory or state == states.comingoutdoor or state == states.gameover
	or place_meeting(x, y, obj_secretportal) or place_meeting(x, y, obj_secretportalstart)
)

//Up arrow
if ((place_meeting(x, y, obj_door) && !place_meeting(x, y, obj_doorblocked)) or place_meeting(x, y, obj_dresser) or place_meeting(x, y, obj_menuphone) or place_meeting(x, y, obj_filedoor) or place_meeting(x, y, obj_devdoor) or place_meeting(x, y, obj_arcademachine) or place_meeting(x, y, obj_arcadehub) or place_meeting(x, y, obj_snick) or place_meeting(x, y, obj_keydoor) or place_meeting(x, y, obj_door_editor) or place_meeting(x, y, obj_keydoor_editor) or place_meeting(x, y, obj_baddiemenu) or place_meeting(x, y, obj_npcparent) or place_meeting(x, y, obj_eatery_cashreg) or place_meeting(x, y, obj_taxi) or (place_meeting(x, y, obj_hubelevator) && instance_place(x, y, obj_hubelevator).state == 0) or (place_meeting(x, y, obj_geromedoor) && global.gerome) or (place_meeting(x, y, obj_exitgate) && (global.panic or global.snickchallenge) && character != "S" && !global.failedmod) or (place_meeting(x, y, obj_startgate) && state == states.normal && scr_stylecheck(2)))
&& grounded && vsp >= 0 && state == states.normal
{
	var arrowexists = false;
	with obj_uparrow
		if playerid == other.id arrowexists = true;
	
	if !arrowexists
	{
		with instance_create(x + hsp, y - 50 + vsp, obj_uparrow)
			 playerid = other.id
	}
}
else with obj_uparrow
{
	if playerid == other.id
		instance_destroy();
}
 
// speed lines
if (global.gameplay == 0 && state == states.mach2) or (global.gameplay != 0 && state == states.mach3 && movespeed >= 16)
{
	if !instance_exists(speedlineseffectid)
	{
		with instance_create(x, y, obj_speedlines)
		{
			playerid = other.object_index
			other.speedlineseffectid = id
		}
	}
}
else if instance_exists(speedlineseffectid)
	instance_destroy(speedlineseffectid);

// collision
scr_collide_destructibles();

if state == states.tube or state == states.gotoplayer
{
    x += hsp
    y += vsp
}
else if state != states.titlescreen && state != states.grabbed && state != states.door && state != states.ejected && state != states.comingoutdoor && state != states.keyget && state != states.victory && state != states.portal && state != states.timesup && state != states.gottreasure && state != states.rotate && state != states.gameover && (((state != states.backbreaker or taunttimer <= 0)) or global.gameplay == 0)
	scr_collide_player();

prevstate = state
prevsprite = sprite_index

// correct depth
depth = (state == states.grabbed ? -5 : -7);
if state == states.rotate
	depth = obj_camera.depth - 1;

if shake > 0
	shake = max(shake - 0.5, 0);

if petfollow > -1
{
	if !instance_exists(obj_petfollow)
		instance_create(x, y, obj_petfollow);
}
else if instance_exists(obj_petfollow)
	instance_destroy(obj_petfollow);
