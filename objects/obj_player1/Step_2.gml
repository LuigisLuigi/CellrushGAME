/// @description online
// sync variables
if check_online()
{
	gms_self_set("xscale", xscale);
	gms_self_set("yscale", yscale);
	
	gms_self_set("spr_palette", spr_palette);
	gms_self_set("paletteselect", paletteselect);
	gms_self_set("flash", flash);
	
	gms_self_set("state", state);
	//gms_self_set("eatery", global.eatery);
	
	gms_self_set("nickname", (nickname == "" ? gms_self_name() : nickname));
	gms_self_set("chat", global.__chat);
	
	gms_self_set("visible", visible);
	gms_self_set("image_index", image_index);
	
	gms_self_set("hooked", (place_meeting(x, y, obj_hookup) && state == states.ladder));
	if place_meeting(x, y, obj_hookup)
		gms_self_set("hooky", instance_place(x, y, obj_hookup).y);
	
	gms_self_set("pizzashield", pizzashield);
	gms_self_set("treasure", sprgot);
	gms_self_set("cowboy", hatsprite);
	
	gms_self_set("box", box);
	
	if room == custom_lvl_room
		gms_self_set("levelid", obj_onlinemenu.level_id);
	
	if !instance_exists(baddiegrabbedID)
		baddiegrabbedID = 0;
	
	gms_self_set("grabenemy", ((baddiegrabbedID != 0 && baddiegrabbedID != obj_null && baddiegrabbedID != obj_otherplayer) ? baddiegrabbedID.sprite_index : -1));
	if baddiegrabbedID != 0 && baddiegrabbedID != obj_null
	{
		gms_self_set("grabenemyx", baddiegrabbedID.x);
		gms_self_set("grabenemyy", baddiegrabbedID.y);
		
		if baddiegrabbedID.object_index == obj_sausageman
			gms_self_set("grabenemycigar", baddiegrabbedID.cigar);
		else if baddiegrabbedID.object_index == obj_junk
			gms_self_set("grabenemycigar", scr_checkskin(checkskin.p_anton));
		else
			gms_self_set("grabenemycigar", false);
	}
	
	if global.panic
		gms_self_set("panic", 1);
	else if global.snickchallenge && global.snickrematch
		gms_self_set("panic", 3);
	else if global.snickchallenge
		gms_self_set("panic", 2);
	else
		gms_self_set("panic", 0);
	
	if global.panic or global.snickchallenge
	{
		gms_self_set("panic_sec", global.seconds);
		gms_self_set("panic_min", global.minutes);
	}
	
	gms_self_set("pvp", global.pvp);
	if global.pvp
	{
		gms_self_set("pvp_hurted", hurted);
		gms_self_set("pvp_cutscene", cutscene);
	}
	
	gms_self_set("petind", petfollow);
	gms_self_set("busy", online_busy);
	
	gms_self_set("img_angle", img_angle);
}

// chat
if check_online() && state != states.titlescreen && state != -1
&& !instance_exists(obj_choicebase)
&& !(instance_exists(obj_hubelevator) && obj_hubelevator.state != 0)
&& !(instance_exists(obj_wc) && obj_wc.WC_consoleopen)
&& !(instance_exists(obj_dialoguebox))
&& (room != editor_entrance or instance_exists(obj_wc))
{
	if keyboard_check_pressed(ord("T")) && !global.__chat
	{
		gms_chat_toggle(true);
		keyboard_string = "";
	}
	if keyboard_check_pressed(vk_escape) && global.__chat
	{
		gms_chat_toggle(false);
		keyboard_key_release(vk_escape);
		global.__chat_typing = false;
		global.__chat_directclose = true;
		global.__chat_highl = true;
	}
	
	if keyboard_check_pressed(vk_up) && global.__chat && obj_gms.chat_lastmessage != ""
	{
		global.__chat_typing = true;
		keyboard_string = obj_gms.chat_lastmessage;
	}
}

// drm
if alarm[11] == -1 && !debug
	alarm[11] = 15;
global.pvp = false;

