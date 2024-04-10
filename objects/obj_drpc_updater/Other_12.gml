modstate = "";
if global.modifier != -1
{
	switch global.modifier
	{
		default:
			modstate = "Modifier";
			break;
			
		case mods.no_toppings:
			modstate = "No Toppings MOD.";
			break;
		case mods.pacifist:
			modstate = "Pacifist MOD.";
			break;
		case mods.hardmode:
			modstate = "Hardmode MOD.";
			break;
		case mods.shadow:
			modstate = "Shadow Follower MOD.";
			break;
	}
	if global.failedmod
		modstate += " (failed)";
}
