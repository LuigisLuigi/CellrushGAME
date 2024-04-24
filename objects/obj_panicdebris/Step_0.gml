//Panic debris
if global.panic && alarm[0] == -1
	alarm[0] = 5;

if !global.panic
	alarm[0] = -1;

if flasha > 0
	flasha -= 0.075;

