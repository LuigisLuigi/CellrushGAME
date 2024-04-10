randomize();
if !code_is_compiled() // if not yyc, warn
	trace("!!RUNNING IN VM!!");

// no shader mode
ini_open("saveData.ini");
if !check_shaders() && !ini_read_real("online", "shitgraphs", false)
{
	show_message("Shaders failed to compile.\nAll special effects, including palettes, will be disabled.");
	ini_write_real("online", "shitgraphs", true);
}

pal_swap_init_system(shd_pal_swapper, -1, -1);

// fonts
global.bigfont = font_add_sprite_ext(spr_font, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:_-?'", true, 0)
global.smallfont = font_add_sprite_ext(spr_smallerfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.:?1234567890',", true, 0)
global.font_small = font_add_sprite_ext(spr_smallfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!._1234567890:;?▯|*/',\"()=-+@█%~ÁÉÍÓÚáéíóúÑñ[]<>$", true, -2)
global.smallnumber = font_add_sprite_ext(spr_smallnumber, "1234567890-.", true, 0)
global.collectfont = font_add_sprite_ext(spr_font_collect, "0123456789.-", true, 0)
global.collectfontPP = font_add_sprite_ext(spr_font_collectPP, "0123456789.-", true, 0)
global.candyfont = font_add_sprite_ext(spr_font_candycollect, "0123456789", true, 0)
global.combofont = font_add_sprite_ext(spr_font_combo, "0123456789.-", true, 0)
global.combofont2 = font_add_sprite_ext(spr_tv_combobubbletext, "0123456789", true, 0)
global.sugarybigfont = font_add_sprite_ext(spr_font_ss, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.1234567890:_-?'", true, 0)
global.sugarysmallfont = font_add_sprite_ext(spr_smallfont_ss, "ABCDEFGHIJKLMNOPQRSTUVWXYZ!.:?1234567890',", true, 0)
loadfont = global.bigfont;

// variable
global.secretdebris = ini_read_real("online", "secretdebris", true);
global.gameplay = ini_read_real("online", "gameplay", 2);
global.shownames = ini_read_real("online", "shownames", true);
global.chatbubbles = ini_read_real("online", "chatbubbles", true);
global.synceffect = ini_read_real("online", "synceffect", true);
global.richpresence = ini_read_real("online", "richpresence", false);
global.streamer = ini_read_real("online", "streamer", false);
global.showfps = ini_read_real("online", "showfps", false);
global.pvp = /*ini_read_real("online", "pvp", false)*/ false; // i removed most of the pvp code long ago so don't get your hopes up
global.drawborder = ini_read_real("online", "drawborder", false);
global.camerasmoothing = ini_read_real("online", "camerasmoothing", 0);
global.inputdisplay = ini_read_real("online", "inputdisplay", false);
global.gamepadvibration = ini_read_real("online", "gamepadvibration", true);
global.showhud = true;

global.panicbg = ini_read_real("online", "panicbg", false); // waving background
global.panicmelt = ini_read_real("online", "panicmelt", false); // motion blur
global.panicshake = ini_read_real("online", "panicshake", true); // shaking
global.panicnightmare = ini_read_real("online", "panicnightmare", true); // panic backgrounds

global.musicvolume = ini_read_real("online", "musicvolume", 0.6);
global.soundvolume = ini_read_real("online", "soundvolume", 1);
global.mastervolume = ini_read_real("online", "mastervolume", 1);
global.machsound = ini_read_real("online", "machsound", 0);
global.musicgame = ini_read_real("online", "musicgame", 0);

audio_master_gain(!game_is_compiled() ? global.mastervolume / 2 : global.mastervolume);

// other variables
global.lastroom = 0;
while room_exists(global.lastroom)
	global.lastroom++;
global.lastroom -= 1;

global.saveslot = "";
global.fun = irandom_range(0, 100);

globalvar playerobj;
playerobj = obj_player;
global.coop = false;

// create the shell
instance_create(0, 0, obj_shell);

// unlock sugary spire content
globalvar sugaryspire;
sugaryspire = true;

// language
global.language = ini_read_string("online", "language", "en") // language
global.langmap = -1;
lang_load(global.language);

// window resolution
global.option_fullscreen = ini_read_real("Option", "fullscreen", false)  
global.option_resolution = ini_read_real("Option", "resolution", 1)  
window_set_fullscreen(global.option_fullscreen);

if !global.option_fullscreen
{
	switch global.option_resolution
	{
		case 0: window_set_size( 480, 270 ); break;
		case 1: window_set_size( 960, 540 ); break;
		case 2: window_set_size( 1920, 1080 ); break;
	}
}

// eggplant build loading screen
draw_flush();
var group_arr = ["tg_player", "tg_background", "tg_baddie", "tg_palette", "tg_hud", "Default"]

tex_list = ds_list_create();
tex_pos = 0;
for (var i = 0; i < array_length(group_arr); i++)
{
    var _tex_array = texturegroup_get_textures(group_arr[i]);
    ds_list_add(tex_list, _tex_array);
}
tex_max = ds_list_size(tex_list);
alarm[0] = 30;

// done
loadwhat = -1;
ini_close();
