function defaultkeys()
{
	array_push(inputkeys, {x : 0, y : 0, key : "Z", keyw : 1, keyh : 1});
	array_push(inputkeys, {x : 1, y : 0, key : "UP", keyw : 1, keyh : 1});
	array_push(inputkeys, {x : 2, y : 0, key : "X", keyw : 1, keyh : 1});
	array_push(inputkeys, {x : 0, y : 1, key : "LEFT", keyw : 1, keyh : 1});
	array_push(inputkeys, {x : 1, y : 1, key : "DOWN", keyw : 1, keyh : 1});
	array_push(inputkeys, {x : 2, y : 1, key : "RIGHT", keyw : 1, keyh : 1});
	array_push(inputkeys, {x : 0, y : 2, key : "SHIFT", keyw : 2, keyh : 1});
	array_push(inputkeys, {x : 2, y : 2, key : "C", keyw : 1, keyh : 1});
	
	keysep = 4;
	keysize = 48;
	
	pos[0] = keysep;
	pos[1] = (540 - keysize * 3) - keysep * 3;
	
	pressedcol = merge_colour(c_blue, c_aqua, 0.75);
} 
function savekeys()
{
	file = file_text_open_write("inputdisplay");
	
	file_text_write_real(file, x);
	file_text_writeln(file);
	file_text_write_real(file, y);
	file_text_writeln(file);
	file_text_write_real(file, keysep);
	file_text_writeln(file);
	file_text_write_real(file, keysize);
	file_text_writeln(file);
	file_text_write_real(file, pressedcol);
	file_text_writeln(file);
	file_text_write_string(file, json_stringify(inputkeys));
	
	file_text_close(file);
}
function loadkeys()
{
	file = file_text_open_read("inputdisplay");
	
	pos[0] = file_text_read_real(file);
	file_text_readln(file);
	pos[1] = file_text_read_real(file);
	file_text_readln(file);
	keysep = file_text_read_real(file);
	file_text_readln(file);
	keysize = file_text_read_real(file);
	file_text_readln(file);
	pressedcol = file_text_read_real(file);
	file_text_readln(file);
	inputkeys = json_parse(file_text_read_string(file));
	
	file_text_close(file);
}

clicktimer = 0;
drag = false;
dragoffset = [0, 0];

depth = -10000;

inputkeys = [];
pos = [0, 0];

if !file_exists("inputdisplay")
{
	defaultkeys();
	savekeys();
}
else
{
	loadkeys();
	if pos[0] < 0 or pos[1] < 0 or !is_array(inputkeys) or array_length(inputkeys) == 0
	{
		defaultkeys();
		savekeys();
	}
}

