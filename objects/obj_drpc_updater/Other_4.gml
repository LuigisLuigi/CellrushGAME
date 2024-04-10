/// @description
if !(running && global.discord_initialized)
	exit;

var r = room_get_name(room);
if room == Realtitlescreen
{
	det = "In the titlescreen";
	state = "";
}
else if room == characterselect
{
	det = "Mode Select";
	state = "";
	if instance_exists(obj_login)
		state = "Logging in...";
}
else
{
	// bottom text
	if global.snickchallenge
	{
		state = "Snick Challenge";
		if global.snickrematch
			state = "Snick's Rematch";
	}
	
	if global.modifier != -1
	{
		event_user(2);
		state = modstate;
	}
	
	if string_startswith(r, "hub")
	{
		det = "Hub";
		if room == hub_room1
			state = "";
	}
	
	else if string_startswith(r, "halloween_entrance")
	{
		det = "Hardoween Hub";
		state = "";
	}
	
	else if string_startswith(r, "Titlescreen")
	{
		det = "Tower Outside";
		state = "";
	}
	
	else if string_startswith(r, "PP_room")
		det = "Tutorial";
	
	else if string_startswith(r, "entrance")
		det = "Entrance";
	
	else if string_startswith(r, "medieval")
	{
		det = "Pizzascape";
		if global.snickrematch
			det = "Snick's Castle (PLN)";
	}
	
	else if string_startswith(r, "ruin")
	{
		det = "The Ancient Cheese";
		if global.snickrematch
			det = "Ruins of The Temple (PLN)";
	}
	
	else if string_startswith(r, "dungeon") or string_startswith(r, "snick_challengeend")
	{
		det = "Bloodsauce Dungeon";
		if global.snickrematch
			det = "Bloodbath Dungeon (PLN)";
	}
	
	else if string_startswith(r, "dragonlair")
		det = "Dragon Lair";
	
	else if string_startswith(r, "floor1")
		det = "Oregano Desert";
	
	else if string_startswith(r, "graveyard")
		det = "The Wasteyard";
	
	else if string_startswith(r, "farm")
		det = "Fun Farm";
	
	else if string_startswith(r, "ufo")
		det = "Space Pinball";
	
	else if string_startswith(r, "beach")
		det = "Pineapple Beach";
	
	else if string_startswith(r, "forest")
		det = "Gnome Forest";
	
	else if string_startswith(r, "kungfu")
		det = "Kung Fu";
	
	else if string_startswith(r, "minigolf")
		det = "Minigolf";
	
	else if string_startswith(r, "war")
		det = "Warzone";
	
	else if string_startswith(r, "chateau")
		det = "Pizzascare";
	
	else if string_startswith(r, "strongcold")
		det = "Strongcold";
	
	else if string_startswith(r, "golf")
		det = "Old Golf";
	
	else if string_startswith(r, "oldmansion")
		det = "Old Mansion";
	
	else if string_startswith(r, "oldfactory")
		det = "Old Factory";
	
	else if string_startswith(r, "oldsewer")
		det = "Old Sewers";
	
	else if string_startswith(r, "oldfreezer")
		det = "Old Freezer";
	
	else if string_startswith(r, "etb")
		det = "Early Test Build";
	
	else if string_startswith(r, "ancient")
		det = "Ancient Tower";
	
	else if string_startswith(r, "grinch")
		det = "Grinch";
	
	else if string_startswith(r, "entryway") && sugaryspire
		det = "Entryway";
	
	else if string_startswith(r, "cotton") && sugaryspire
		det = "Cottontown";
	
	else if string_startswith(r, "mines") && sugaryspire
		det = "Sugarshack Mines";
	
	else if string_startswith(r, "molasses") && sugaryspire
		det = "Molasses Swamp";
	
	else if string_startswith(r, "sanctum") && !global.streamer
		det = "La Burrata Temple";
	
	else if room == rm_test
	{
		det = "Test Room";
		state = "";
	}
	else if room == rm_blank
	{
		det = "rm_blank";
		state = "THE GLORIOUS NOTHINGNESS";
	}
	else if room == rm_mariohell
	{
		det = "Mario";
		state = "";
	}
	else if room == boss_room1
	{
		det = "Boss Fight";
		state = "Noise Crusher";
	}
	else if room == editor_entrance
	{
		det = "Level Editor";
		state = "Browsing the menus";
	}
	else if room == custom_lvl_room
	{
		if instance_exists(obj_onlinemenu)
		{
			if obj_onlinemenu.level_id == 1 && obj_onlinemenu.paging_type != 3
			{
				det = "Testing a level";
				state = "";
			}
		}
		else
		{
			det = "Custom Level Room";
			state = "";
		}
	}
	else if room == rank_room
	{
		if global.snickchallenge
		{
			det = "Snick Challenge";
			if global.snickrematch
				det = "Snick's Rematch";
		}
		
		state = "Ranking";
	}
	else if room == timesuproom
	{
		if global.snickchallenge
		{
			det = "Snick Challenge";
			if global.snickrematch
				det = "Snick's Rematch";
		}
		
		state = "Time's up!";
	}
	else
	{
		det = "???";
		state = "";
	}
}
if state == -1
	state = roomname == "" ? "???" : roomname;

if check_online()
	det = gms_self_name() + " - " + det;

np_setpresence(state, det, large, small);
