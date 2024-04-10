if running && global.discord_initialized
{
	// little icon for character
	if instance_exists(obj_player1) && room != Realtitlescreen && room != characterselect
	{
		setda = false;
		if obj_player1.character != charprev
		{
			charprev = obj_player1.character;
			switch charprev
			{
				case "P":
					small = "char_p";
					np_setpresence_more("Peppino", "", false);
					break;
				case "N":
					small = "char_n";
					np_setpresence_more("The Noise", "", false);
					break;
				case "V":
					small = "char_v";
					np_setpresence_more("Vigilante", "", false);
					break;
				case "S":
					small = "char_s";
					np_setpresence_more("Snick", "", false);
					break;
				case "PP":
					small = "char_pp";
					np_setpresence_more("Pissino", "", false);
					break;
				case "SP":
					small = "char_sp";
					np_setpresence_more("Pizzelle", "", false);
					break;
				case "SN":
					small = "char_sn";
					np_setpresence_more("Pizzano", "", false);
					break;
				case "PUFFER":
					small = "char_puffer";
					np_setpresence_more("Pufferfish", "", false);
					break;
				default:
					small = "char_unknown";
					np_setpresence_more(lang_string("drpc.nullino"), "", false);
					break;
			}
		}
	}
	else if !setda
	{
		setda = true;
		charprev = "";
		small = "";
		np_setpresence_more("", "", false);
	}
	np_setpresence(state, det, large, small);
}
