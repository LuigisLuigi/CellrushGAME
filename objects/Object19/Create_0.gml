if room != rm_disclaimer
{
	instance_destroy();
	exit;
}
global.onlinemode = debug;

con = -1;
size = 0;
cancon = false;

version = 10;

// crack my own drm
drm = false;
str = "Welcome to Pizza Tower ONLINE.";
global.onlinemode = true;
global.pastdisclaimer = true;

req = -1;
net = true; // is connected to the internet
t = 0; // animation timer
showwait = false;
cancon = true;

// if you have seen the disclaimer already, skip it
/*
ini_open("saveData.ini");
if ini_read_real("online", "disclaimer", false)
{
	event_user(0);
	ini_close();
	exit;
}
else
*/
	event_user(1); // show disclaimer
//ini_close();

/*
drm = true;
if !patron
	drm = false;

str = lang_string("disclaimer.offline");

req = -1;
net = os_is_network_connected();
if net == true
	req = http_get(base64_decode("aHR0cDovL3B0b2xldmVsZWRpdG9yLjAwMHdlYmhvc3RhcHAuY29tL2Rpc2NsYWltZXI="));
else
	event_user(1);

t = 0;

alarm[1] = room_speed * 5;
showwait = false;
*/
