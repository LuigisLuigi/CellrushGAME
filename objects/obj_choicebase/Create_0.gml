depth = -9999;
instance_destroy(obj_pausefadeout);

scr_soundeffect(sfx_diagopen);

keyboard_clear(global.key_up);
keyboard_clear(global.key_taunt);

playerid = playerobj;

img = 0;
xoffset = 0;
yoffset = 0;

spr_idle = -1;
spr_palette = -1;

sel = [0, 0];
selmin = 1;
selmax = 0;

stickpressed = true;
locked = false;

selarray = [];
palname = "";
paldesc = "";

selvert = false;

pizza = spr_pizzacollect1;
if irandom_range(0, 100) >= 80
	pizza = spr_pizzacollect2;
if irandom_range(0, 100) >= 95
	pizza = spr_pizzacollect3;
pizzasurf = -1;

holdt = -1;
titlefont = global.bigfont;
descfont = global.font_small;
basetext = true;

con = 0;
t = 0;

