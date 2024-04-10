/// @description literal "controller" support (lmao)
global.cont = -1;
global.cont2 = -1;
connected = false;

var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++)
{
	if gamepad_is_connected(i)
	{
		global.cont = i;
		connected = true;
		break;
	}
}

vibration = [0, 0, 0];
vibration2 = [0, 0, 0];
prevstate = states.normal;

pausebg = -1;
disconnected = false;
instlist = [];
onpause = false;

