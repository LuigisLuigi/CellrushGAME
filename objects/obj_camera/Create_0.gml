sprite_index = -1

n = 0
image_speed = 0.35
alarm[1] = -1
global.seconds = 59
global.minutes = 0
global.miniboss = false
frame = 0
global.pizza = 0
global.pizzameter = 0
global.pillarhunger = 4000 
basement = false
shake_mag = 0;
shake_mag_panic = 0;
shake_mag_acc = 0;
hudframe = 0

chargecamera = 0
chargeprev = 0
chargesmooth = 0

crouchcamera = 0
crouchcameragoingback = false
alpha = 1
zoomh = 540
zoomw = 960

panto = [0, 0];
pancur = [0, 0];

edge_indicator = ds_queue_create()
drawhud = true

//DDP Set this to false to disable background effects to save FPS
// I suggest creating a menu option to set this to false
// moved to obj_load

//DDP During runbacks, waveamount slowly increases
global.maxwave = 0
global.wave = 0
ded = false

player = playerobj
shoving = false
bang = false
image_speed = 0.35
p2pdistance  = 0 
p2pdistancex  = 0 

bound_camera = false;
global.timedgate = false
global.timedgatetime = 0

healthshake = 0
healthold = 100
healthshaketime = 0
playerhealthup = false

targetoverride = noone
targetgoingback = false

lastx = 0
lasty = 0

depth = -9998;

manualhide = false;
zoom = 1
frameone = false;
shaderfade = 0;

// new shit
lastcollect = -1;
color_array = array_create(1, 0);
collect_shake = 0;
hud_posY = 0;
pizzascore_index = 0;
pizzascore_number = sprite_get_number(spr_pizzascore);
detach = false;

keyimg = 0;
zoom = 0;
angle = 0;
limitcam = [0, 0, 960, 540];

previousrank = 0
rank_scale = 1
