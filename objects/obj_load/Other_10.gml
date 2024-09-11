/// @description sugary room censorship

/* 
	this procedure actually could be used for deleting patron exclusive levels
	from a theoretical non patron version of this mod.


if !sugaryspire
{
	for(var i = 0; i < global.lastroom; i++)
	{
		if !room_exists(i)
			continue;
		if check_sugary(i)
			room_assign(i, rm_blank);
	}
}

*/

//TODO: figure out what the hell sugaryspire is and why this exists