if !global.pastdisclaimer && !debug
{
	room_goto(room_of_dog);
	exit;
}
scr_getinput();

basegrav = 0.5;
grav = basegrav;

gravmult = 1;
hsp = 0;
vsp = 0;
xscale = 1;
yscale = 1;
facehurt = false
steppy = false
depth = -7
movespeed = 0
jumpstop = false

visible = true
state = states.normal
if room == Realtitlescreen
	state = states.titlescreen

jumpAnim = true
landAnim = false
machslideAnim = false
moveAnim = true
stopAnim = true
crouchslideAnim = true
crouchAnim = true
machhitAnim = false
stompAnim = false

inv_frames = false

hurted = false
autodash = false
mach2 = 0

parry = false
parry_inst = noone
taunt_to_parry_max = 10
parry_count = 0
parry_max = 8

input_buffer_jump = 8
input_buffer_secondjump = 8
input_buffer_highjump = 8
player_x = x
player_y = y
targetRoom = 0
targetDoor = "A"

flash = false

key_particles = false
barrel = false
bounce = false
a = 0
idle = 0
attacking = false
slamming = false
superslam = 0
grounded = true
grinding = false

machpunchAnim = false
punch = false
machfreefall = 0
shoot = true
instakillmove = false
windingAnim = 0
facestompAnim = false
ladderbuffer = 0
toomuchalarm1 = 0
toomuchalarm2 = 0

idleanim = 0
momentum = false
cutscene = false
grabbing = false
dir = xscale
shotgunAnim = false

goingdownslope = false
goingupslope = false
fallinganimation = 0
bombpeptimer = 100

suplexmove = false
suplexhavetomash = 0

anger = 0
angry = false
baddiegrabbedID = 0
spr_palette = spr_peppalette
character = "P"

scr_characterspr()
paletteselect = check_shaders()
sprite_index = spr_idle

colorchange = false

palcolors = ds_list_create();
dsread = "";
palsurf = -1;

//Second lap
treasure_x = 0
treasure_y = 0
treasure_room = 0

wallspeed = 0

tauntstoredstate = states.normal
tauntstoredmovespeed = 6
tauntstoredsprite = spr_idle
taunttimer = 0

tube_id = -1

backtohubstartx = 0
backtohubstarty = 0
backtohubroom = hub_room1

slapcharge = 0
slaphand = 1
slapbuffer = 8
slapflash = 0

freefallsmash = 0
costumercutscenetimer = 0

heavy = false

lastroom_x = 0
lastroom_y = 0
lastroom = 0

hallway = false
hallwaydirection = 0
box = false
oldhallway = false

roomstartx = 0
roomstarty = 0

swingdingbuffer = 0
swingdingdash = 0
lastmove = 0
backupweapon = false

stickpressed = false

spotlight = true
macheffect = false
chargeeffectid = obj_null
dashcloudid = obj_null

crazyruneffectid = obj_null
fightball = false
superslameffectid = obj_null
speedlineseffectid = obj_null
angryeffectid = obj_null
thrown = false

candyeffect = noone

mach1snd = -1
mach2snd = -1
mach3snd = -1
knightslide = -1
bombpep1snd = -1
mach4snd = -1
tumble2snd = -1
tumble1snd = -1
tumble3snd = -1
superjumpholdsnd = -1
superjumpprepsnd = -1
suplexdashsnd = -1
flipsnd = -1

pogospeed = 2
pogocharge = 100
pogochargeactive = false
wallclingcooldown = 10

bombcharge = 0

flashflicker = false
flashflickertime = 0
kickbomb = false
doublejump = false

pogospeedprev = false
 fightballadvantage = false
coopdelay = 0

supercharge = 0
supercharged = false
superchargedeffectid = obj_null

pizzashield = false
pizzashieldid = obj_null

pizzapepper = 0

transformation = [
	states.bombpep,
	states.knightpep,
	states.knightpepslopes,
	states.boxxedpep,
	states.cheeseball,
	states.cheesepep,
	states.cheesepepstick,
	states.firemouth,
	states.fireass,
	states.tumble,
	states.stunned,
	states.rideweenie,
	states.gameover,
	states.door,
	states.ghost,
	states.mort,
	states.hitlag,
	states.knightpepattack,
	states.tube,
	states.rocket,
	states.actor,
	states.gotoplayer,
	states.bombgrab,
	states.bombpepup,
	states.bombpepside,
	states.barrelslide,
	states.barreljump,
	states.barrelclimbwall,
	states.cheeseballclimbwall,
	states.motorcycle,
	states.knightpepbump,
	states.knightpepattack,
	states.mortattack,
	states.morthook,
	states.mortjump,
	states.boxxedpepjump,
	states.boxxedpepspin,
	states.rocketslide,
	
	states.cotton,
]

c = 0
revolverbuffer = 0
breakdance = 50;

hooked = false;
sprgot = -1;
nickname = "";
noisetype = (global.gameplay == 0 ? 0 : 1);
noisebombcooldown = 0;
springsjump = false;
keydoor = false;
storedstate = states.normal;
grabbedby = -1;
shake = 0;
drawspr = sprite_index;
online_busy = false;
sjump = true;

// hat
hatsprite = -1;
hatimg = 0;

// pet
petfollow = -1;

// new shit
skateboarding = false;

hurt_buffer = -1;
hurt_max = 120;
invhurt_buffer = 0;
invhurt_max = 30;

shot = false;
shoot_buffer = 0;
shoot_max = 20;

mort = false;
sjumpvsp = -12;
freefallvsp = 15;

hitX = x;
hitY = y;
hithsp = 0;
hitvsp = 0;
hitstunned = false;
hitxscale = 1;
stunned = false;
hitLag = 25;

doorx = x;

verticalhallway = false;
vhallwaydirection = 0;
vhallwaypos = 0;

endtumble = false
hascollision = true

img_angle = 0
canfall = true
godmode = false

konami = "";
konamiend = "UUDDLRLRBA";

input_buffer_faceplant = 8;

// eggplant build shit
vsp_carry = 0
hsp_carry = 0
rocketvsp = 0
sticking = false
platformid = noone
jetpackdash = 0
flamecloud_buffer = 0
rankpos_x = x
rankpos_y = y
transformationlives = 0
punch_afterimage = 0
superchargecombo_buffer = -1
superattackstate = states.normal
afterimagedebris_buffer = 0
scale_xs = 1
scale_ys = 1
verticalbuffer = 0
verticalstate = states.normal
webID = noone
float = 0
boxxedpepjump = 10
boxxedpepjumpmax = 10
icemovespeed = 0
prevmove = 0
prevhsp = 0
prevstate = states.normal
prevxscale = 1
prevsprite = sprite_index
move = 0
prevmovespeed = 0
previcemovespeed = 0
icedir = 1
icemomentum = 0
savedicedir = 1
isgustavo = false
jumped = true
ramp = 0
ramp_points = 0
bombup_dir = 1
knightmomentum = 0
grabbingenemy = 0
blur_effect = 0
firemouth_dir = 1
firemouth_max = 10
firemouth_buffer = firemouth_max
firemouth_afterimage = 0
cow_buffer = 0
balloonbuffer = 0
golfid = -4
bombgrabID = noone
barrelslope = 0
barrel_maxmovespeed = 16
barrel_maxfootspeed = 10
barrel_rollspeed_threshold = 10
barrel_accel = 1
barrel_deccel = 1
barrel_slopeaccel = 0.25
barrel_slopedeccel = 0.5
barrelroll_slopeaccel = 0.5
barrelroll_slopedeccel = 0.35
ratmount_movespeed = 8
ratmount_fallingspeed = 0
ratgrabbedID = -4
ratpowerup = -4
ratshootbuffer = 0
rateaten = 0
gustavodash = 0
brick = 0
ratmountpunchtimer = 25
gustavokicktimer = 5
cheesepep_buffer = 0
cheesepep_max = 10
pepperman_accel = 0.25
pepperman_deccel = 0.5
pepperman_accel_air = 0.15
pepperman_deccel_air = 0.25
pepperman_maxhsp_normal = 6
pepperman_jumpspeed = 11
pepperman_grabID = -4
shoulderbash_mspeed_start = 12
shoulderbash_mspeed_loop = 10
shoulderbash_jumpspeed = 11
input_attack_buffer = 0
input_finisher_buffer = 0
input_up_buffer = 0
input_down_buffer = 0
hit_connected = false
mach4mode = false
railmomentum = 0
railmovespeed = 0
raildir = 1
boxxed = false
boxxeddash = 0
cheesepeptimer = -1
cheeseballbounce = 0
slopejump = 0
slopejumpx = 0
hooked = false
swingdingendcooldown = 0
crouchslipbuffer = 0
breakdance_speed = 0.25
notecreate = 50

// globals
if !variable_global_exists("saveroom")
{
	global.combodropped = false
	
	global.saveroom = ds_list_create();
	global.baddieroom = ds_list_create();
	global.followerlist = ds_list_create();
	global.baddietomb = ds_list_create();
	global.escaperoom = ds_list_create();
	
	global.playerhealth = 100
	
	global.toppintotal = 1
	global.shroomfollow = false
	global.cheesefollow = false
	global.tomatofollow = false
	global.sausagefollow = false
	global.pineapplefollow = false

	global.key_inv = 0
	global.keyget = false
	global.giantkey = false
	global.collect = 0
	global.collectN = 0
	global.treasure = false
	global.gotshotgun = false

	global.combo = 0
    global.previouscombo = 0
    global.combotime = 0
    global.comboscore = 0
    global.savedcomboscore = 0
    global.savedcombo = 0
	global.hit = 0
	
	global.panic = false
	global.snickchallenge = false
	global.snickrematch = false

	global.golfhit = 0
	global.funmode = false
	global.secretfound = 0

	scr_setcoin(0)
	global.pizzacoinstart = global.pizzacoin;

	global.heattime = 0;
	global.style = 0;
	global.stylethreshold = 0;
	global.baddiespeed = 1;
	global.baddiepowerup = false;
	global.baddierage = false;

	global.showgnomelist = true;
	global.pizzadelivery = false;
	global.failcutscene = false;
	global.pizzasdelivered = 0;

	global.spaceblockswitch = true;

	global.bullet = 0;
	global.mort = false;

	global.gerome = false;
	global.stylelock = false;
	
	global.horse = false
    global.checkpoint_room = -4
    global.checkpoint_door = "A"
    global.kungfu = false
    global.graffiticount = 0
    global.graffitimax = 20
    global.noisejetpack = false
    global.hasfarmer = array_create(3, 0)
    global.savedattackstyle = -4
	
	global.lap = false
    global.laps = 0
	
}

