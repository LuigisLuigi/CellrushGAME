/*
if instance_exists(obj_gms)
{
	gms_logout();
	instance_destroy(obj_gms);
	global.roommessage = "LOGGED OUT";
}

global.optimize = 0;
global.autotile = true;
global.font_small = font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!._1234567890:?▯|',\"()=-+@:;█", true, -2)//"ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:"


/*
enum states
{
normal,
revolver,
dynamite,
boots,
grabbed,
tumble,
finishingblow,
ejected,
transitioncutscene,
fireass,
firemouth,
mort,
hook,
ghost,
titlescreen,
hookshot,
tacklecharge,
cheeseball,
slap,
cheesepep,
cheesepepstick,
rideweenie,
boxxedpep,
pistolaim,
climbwall,
knightpepslopes,
portal,
secondjump,
chainsawbump,
handstandjump,
gottreasure,
knightpep,
knightpepattack,
meteorpep,
bombpep,
grabbing,
chainsawpogo,
shotgunjump,
pogo,
stunned,
highjump,
chainsaw,
facestomp,
mach4,
timesup,
machroll,
shotgun,
pistol,
machfreefall,
_throw,
slam,
superslam,
skateboard,
grind,
grab,
punch,
backkick,
uppunch,
shoulder,
backbreaker,
bossdefeat,
pizzathrow,
bossintro,
gameover,
keyget,
tackle,
jump,
ladder,
slipnslide,
comingoutdoor,
smirk,
Sjump,
victory,
Sjumpprep,
crouch,
crouchjump,
crouchslide,
mach1,
mach2,
machslide,
bump,
hurt,
freefall,
hang,
turning,
freefallland,
door,
barrel,
current,
boulder,
taxi,
runonball,
mach3,
freefallprep,
Sjumpland,
faceplant, 
rage,
//enemy states
idle,
bounce,
charge,
pizzagoblinthrow,
turn,
hitceilling,
hitwall,
rolling,
walk,
fall,
land,
hit,
stun,
recovery,
stomped,
chase,
spawn,
arenaintro,
actor,
parry,

}

*/

global.loadeditor = false;

obj_player1.targetDoor = "A";
obj_player1.x = -500;
obj_player1.character = "P";
obj_player1.paletteselect = 1;
with obj_player1
	scr_characterspr();