/// @description turn on rich presence
running = true;

instance_destroy(nekoPresence);
instance_create(0, 0, nekoPresence);
np_initdiscord(DISCORD_APP_ID, true, np_steam_app_id_empty);
