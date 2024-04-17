sprite_index = -1

image_speed = 0.1
chose = false

//Text & TV
message = ""
showtext = false
tvsprite = spr_tvdefault
noisesprite = spr_noiseHUD_idle
xi = 500
yi = 600
imageindexstore = 0
once = false
global.hurtcounter = 0
global.hurtmilestone = 10
alpha = 1
shownranks = false
shownranka = false
shownrankb = false
shownrankc = false

global.srank = 0
global.arank = 0
global.brank = 0
global.crank = 0

character = "PEPPINO"
display_set_gui_size(960, 540)

pizzacoinframe = 0
manualhide = false
surf = -1
panicy = 0
tvimg = 0

depth = -9998;

jumpscare = -1;
jumpscareimage = irandom(sprite_get_number(spr_scares) - 1);
jumpscaretext = 0;

// new shit
tvprompts_list = ds_list_create()
state = states.transitioncutscene
promptxstart = 641
promptx = promptxstart
prompt = ""
promptspd = 1
prompt_buffer = 0
prompt_max = 150
promptsurface = -1
special_prompts = noone
hud_posx = 0
hud_posY = 0
bubbleindex = 0
bubblespr = noone
idleanim = 180
collect_shake = 0
combo_state = 0
combo_posX = 0
combo_vsp = 0
combo_posY = -500
combofill_x = 0
combofill_y = 0
combofill_index = 0
noisemax = 6 // tv static time
noisebuffer = noisemax
expressionsprite = noone
expressionbuffer = 0
golfsurf = noone

sugary = false
sugary_propeller = 0
combo_prev = global.combo
combo_shake = 0
combo_fade = 0
sprite_prev = -1
happy_timer = 0
panic_timer = 0
panic_anim = 0
panic_sprite = -1
popsurf = -1
chunkmax = 0
timer_xstart = 327
timer_ystart = 464
timer_x = timer_xstart
timer_y = timer_ystart + 212
pizzaface_sprite = spr_timer_pizzaface1
pizzaface_index = 0
johnface_sprite = spr_timer_johnface
johnface_index = 0
hand_sprite = spr_timer_hand1
hand_index = 0
bar_surface = noone
barfill_x = 0
showtime_buffer = 0

if global.gameplay != 0
{
	promptsurface = surface_create(290, 102)
	tvsprite = spr_tv_idle;
	sprite_index = spr_tv_off;
}
animset = sprite_index;

mask_index = spr_null;