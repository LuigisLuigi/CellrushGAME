/// @description palettes & reset choice
switch sel[1]
{
	default:
		spr_palette = spr_peppalette;
		spr_idle = spr_player_idle;
		spr_select = spr_player_skinselect;
		selarray = [
			["YELLOW", "Palette zero.\nLegends say he was pissed on..."],
			["PEPPINO", "A somewhat overweight Italian chef."],
			["BLUE", "He's rocking a blue outfit."],
			["RED", "That's right, he's rocking a red outfit."],
			["GREEN", "Shockingly, he's rocking a green outfit."],
			["GRAY", "It's just a Leaning Nightmare..."],
			["GAMEBOY COLOR", "What a ripoff."],
			["GRAYSCALE", "Depresso spaghetto."],
			["XMAS", "Give me a break."],
			["THE NOISE", "...woag?"],
			["SKETCH", "He crashed into somebody."],
			["GRINCH", "It's Claus!!!!"],
			["LEAN", "No, he wasn't involved in slaughter."],
			["ANTON", "Ugh, I HATE him."],
			["UNFINISHED", "i found a hole in this sprite"],
			["LIGHT", "People also look for Fluorescent Peppino."],
			["AETHER", "Where's a coder when you need one?"],
			["PETER", "Griffin"],
			["SAGE", "PTSD actually stands for \"Pizza Tower Sage Demo\"."],
			["BLACK", "Not the clothes."],
			["MASSACRE", "It's all just a bad dream..."],
			["BURNT PIZZA", "Papa Louie would not be proud."],
			["GAMEBOY", "One of his greatest achievements."],
			["HYPOTHERMIA", "Lesson learned. Don't bathe inside of a freezer."],
			["BONMARIO", "Property of Bonmario of America INC."],
			["DRUNKEN", "Don't ask about the clothes."],
			["ASCENDED PEDDITO", "Likes death, dislikes the livings."],
			["VIRTUAL BOY", "The long awaited all-red palette."],
			["GOLDEN", "He removed the pineapple pizza from the menu."],
			["BLACK", "Ok, they ARE the clothes this time."],
		];
		if global.streamer
		{
			selarray[0][1] = "Palette zero.\nDon't make comparisons.";
			selarray[22] = ["EVIL", "Do you ever just suddenly become very evil and like your skin starts turning pitch black."];
		}
		break;
	
	case "N":
		spr_palette = spr_noisepalette;
		spr_idle = spr_playerN_idle;
		spr_select = spr_playerN_panicidle;
		selarray = [
			["THE NOISE", "The mischievous gremlin."],
			["HALLOWEEN", "Scary."],
			["PEPPINO", "...The classic?"],
			["SNICK", "Legends say he WAS involved in slaughter..."],
			["XMAS", "Merry!!!"],
			["INVERTED", ".yracS"],
			["NAKED", "Hell yeah! Public indecency!"],
			["CONCEPT", "The original."],
			["THE DOISE", "Do not steal."],
			["NOISETTE", "It takes a noiser noise than\nThe Noise's noise to annoy The Noise."],
			["RAINBOW", "What country is that?"],
			["SKETCH", "He's closing his eyes...!"],
			["THE NOID", "Avoid him."],
			["GALAXY", "Stunning."],
			["CHUNGUS", "A fine Chungus, of the big variety."],
			["MR ORANGE", "I'm seeing double! Four Noise!"],
			["DR.B.B.", "Snooping as usual, I see."],
			["SALAD", "You fat bald bastard you piece of subhuman trash\n2000 years of constant human evolution to create a hairless fucking coconut."],
			["BLACKFACE", "That's not nice."],
			["NOIK", "He's canon."],
			["HYPERTHERMIA", "That's NOT how you preheat an oven."],
			["LUIGI", "The L stands for winner."],
		];
		break;
	
	case "V":
		spr_palette = spr_vigipalette;
		spr_idle = spr_playerV_idle;
		spr_select = spr_playerV_gate;
		selarray = [
			["THE VIGILANTE", "AKA Vigert Ebenezer Lantte."],
			["HALLOWEEN", "Trick or treat.\nThis is a threat."],
			["MM8BDM", "A very exciting night."],
			["CHOCOLANTE", "It's still cheese. Just... with, uh, chocolate flavoring?"],
			["JOHN", "A hungry slime."],
			["GOLDEN", "Something, something, carrots."],
			["CHEDDAR", "Cheddar cheese is a relatively hard, off-white (or orange if colourings such as annatto are added),\nsometimes sharp-tasting, natural cheese. Originating in the English village of Cheddar in Somerset,\ncheeses of this style are now produced beyond the region and in several countries around the world."],
			["SEPIA", "Wildstyle pistolero."],
			["SNICK", "It's NOT him. Never trust purple cheese."],
			["EMERALD", "Hmm."],
			["HOLIDAY", "Merry Cheesemas."],
			["CHEESE MAN", "A gag of the Johnson subject."],
			["VIGILATTE", "Chocolate milk."],
			["BLOODSAUCE", "Who the hell dipped cheese in ketchup?!"],
			["VIGILATEX", "What the fuck"],
			["THE BARTENDER", "Give me a drink, Bartender."],
			["MORSHU", "It's yours, my friend."],
			["CASU MARTZU", "Y'know, this cheese summarizes the current state of the game pretty well."],
		];
		if global.streamer
			selarray[14][1] = "no no no no no no no no no no no no no no no no no no no";
		break;
	
	case "S":
		spr_palette = spr_snickpalette;
		spr_idle = spr_snick_idle;
		spr_select = spr_snick_victory;
		selarray = [
			["SNICK", "It's him."],
			["TAIL", "A single tail."],
			["SHADER", "im the greatest living thing my duderino"],
			["BOOTS", "Unlike Snick."],
			["SNICKETTE", "Not to be confused with Satan."],
			["MASTER SYSTEM", "Brought to you by Snicksoft!"],
			["SHADOW", "The obligatory edgy palette."],
			["CYAN", "Don't you dare."],
			["TRANSPARENT", "He seems empty inside... and outside."],
			["MANUAL", "He hosts his own event."],
			["SKETCH", "Let's just say he likes burgers."],
			["SHITK", "Acting sus!"],
			["HALLOWEEN", "Haha don't worry, he's not dead yet."],
			["SOCK", "Sock is without description."],
			["ELMO", "Homosexual, the sixty-ninth."],
			["GAMEBOY", "That's not right..."],
			["HELLSNICK", "Si."],
			["MAJIN", "Fun is infinite."],
			["NEON", "I've seen OC's brighter than this."],
			["PISSK", "Not to be confused with his arch nemesis."],
		];
		if global.streamer
		{
			selarray[4][1] = "No, not THAT one."; // snickette
			selarray[14][1] = "Hilarity ensues."; // elmo
		}
		break;
	
	case "SP":
		if sugaryspire
		{
			spr_palette = spr_pizzpalette;
			spr_idle = spr_playerSP_idle;
			spr_select = spr_playerSP_stunned;
			selarray = [
				["YELLOW", "Take the first 4 letters of Pizzelle."],
				["PIZZELLE", "It's the Candy-making patisje!"],
				["WILD STRAWBERRY", "Also known as pink."],
				["CHERRY", "Lucky!"],
				["LIME", "Uh, make margaritas. I think."],
				["VIOLET", "Now in grape flavor."],
				["ORANGE", "The color or the fruit?"],
				["GUM", "Don't actually chew it please."],
				["CANDY CANE", "It's the Candy		   !"],
				["PUMPKIN", "Now with 30% less fiber."],
				["FAMILIAR GREMLIN", "Something's wrong."],
				["SAGE", "If it ever happens I will shit bricks."],
				["DOOM", "It's the rip and tearing patisje!"],
				["ANNIE", "It's ball-busting time."],
				["SCOOTER", "I- ...wh- what?"],
				["BLURPLE", "Also known as test."],
				["PAINTLAD", "Very original name there."],
				["COTTON CANDY", "Not to say something else."],
				["GREEN APPLE", "Why is this the least favorite candy flavor?"],
				["SECRET", "Lookie! You've found a pretty sweet surprise."],
				["STUPID RAT", "Their beloved, I suppose."],
				["PASTEL", "Soft on the eyes."],
				["BURNT", "You fucking DONKEY."],
				["CRAZY FROG", "Ding ding."],
				["FACTORY", "DOOR STUCK"],
				["PINK", "Bismuth subsalicylate."],
				["SUGAR", "Obviously sugar is green."],
				["MASSACRE", "SUGARY SPIRE 2: The Quest for Diabetes."],
				["RIVALS", "Did we find a coder yet?"],
				["OLD SCHOOL", "Also known as grayscale."],
				["ZOMBIFIED", "Ricochet, eh? I sense some inspiration-ception."],
				["FORESTATION", "Made of sugarcane plants."],
				["LAMDA", "I have nothing to say about this."],
				["GOLDEN", "Unlocks the ability to SHINE... which is bound to no key."],
				["GNOME WIZARD", "Despite being a wizard, he has no redeeming qualities."],
				["SHADOW", "SHUT UP! My dad works at Sugary Spire and can give you PREGNANT."],
			]
			if global.streamer
				selarray[23][1] = "You effing DONKEY.";
		}
		
		//["PAINTLAD", "Did you know Jacko suggested the name Paintlad\nand is probably never going to be credited for it?"],
		break;
	
	case "SN":
		if sugaryspire
		{
			spr_palette = spr_creampalette;
			spr_idle = spr_playerSN_idle;
			spr_select = spr_playerSN_idle;
			selarray = [
				["YELLOW", "Piss ano."],
				["PIZZANO", "YAH-HAH!"],
				["FAMILIAR GREMLIN", "Close enough, but not quite."],
				["FAMILIAR CHEF", "A somewhat overweight Italian nuisance."],
				["LASAGNA", "Mondays."],
				["SPICE", "When you want just a little spiciness on your candy."],
				["PLUMBER", "Holy shit it's Super Fucking Mario"],
				["GREEN APPLE", "Now I know why this is the least favorite candy flavor."],
				["GRAPE SODA", "There's more purple than actual soda in this."],
				["ANTIPATHIC", "Isn't it antipathetic?"],
				["GUMMY BEAR", "Tastes like blood."],
				["LIME", "Unfortunate palette placement."],
				["CRYSTALIZED", "Missed opportunity to make it transparent."],
			];
		}
	break;
	
	case "PP":
		spr_palette = spr_pisspalette;
		spr_idle = spr_playerPP_idle;
		spr_select = spr_playerPP_skinselect;
		selarray = [
			["PISSINO", "God is dead and we killed him."],
			["WHITE", "A somewhat overweight italian failure."],
			["RED", "It could also be-a him, for all we know."],
			["BLUE", "The day he forgot his purpose."],
			["FREDDY", "hor hor horhor hor hor horhor horhor"],
			["SKETCH", "He wouldn't have crashed into somebody.\nHe would've shot a whole convenience store down."],
			["GRAND DAD", "FLINTSTONES HAHAHAHA"],
			["DORITO", "Undertale"],
			["BLACK", "Don't show this to Denchick."],
			["METAL", "Balls of Steel."],
			["???", "You can't get blacker than this."],
			["RANDOM HUMOR", "This isn't even a joke. And I'm asking this personally. Who hurt you?\nWhat happened for things to be this way? Are you okay?"],
			["GRUNT", "To whomever this palette once belonged to, they must be living a pretty sad life right now."],
			["MCDONALDS", "I dislike their soggy fries. Fight me."],
			["ELMO", "You have come to his event. Now you must endure forceful cosplay."],
			["MANUAL", "Do you ever just feel like emanating a strong stench of urine?"],
			["SNICK", "It's not him."],
			["THE EVIL", "Made in hell."],
			["SUPER MARIO", "HOLY SHIT"],
			["LEAN", "This isn't funny anymore. Stop."],
			["4CHAN MYSTERY BOX", "IT'S NOT FUCKING WEED YOU PIECE OF SHIT STONER."],
			["BRODY FOXX", "He died in 2006 from a severe ketamine overdose."],
		]
		if global.streamer
		{
			selarray[8][1] = "Not to be racist."; // black
			selarray[11][1] = "'Go home'? But I JUST got here!"; // random humor
			selarray[20][1] = "IT'S NOT FUCKING WEED."; // 4-chan mystery box
		}
		break;
	
	/*
	case "CT":
		spr_palette = spr_cheemspalette;
		spr_idle = spr_playerCT_idle;
		spr_select = spr_playerCT_panic;
		selarray = [
			["CHEEMSTOON", "Not a furry, just a Void-creature."],
			["GORE", "The obligatory edgy palette!"],
			["GRINCH", "He chose grinch.........................."],
			["SAGE", "It better include a Sonic ripoff character."],
			["SQUIDWARD", "description here"],
		]
		break;
	*/
	
	case "PUFFER":
		spr_palette = spr_pufferpalette;
		spr_idle = spr_pufferfish_move;
		spr_select = spr_pufferfish_idle;
		selarray = [
			["PUFFERFISH", "For, uh... testing purposes. Yeah."],
		]
		break;
	
	#region scrapped (for now)
	
	case "M":
		spr_palette = spr_manpalette;
		spr_idle = spr_playerM_idle;
		selarray = [
			["PEPPERMAN", "A giant red pepper with limbs."],
			["2 HP", "Peppers are a good pumpkin replacement."],
			["1 HP", "568% vitamin C!"],
			["BANANA", "Potassium."],
		];
		break;
	
	case "W":
		spr_palette = spr_peppalette;
		spr_idle = spr_playerW_idle;
		selarray = [
			["PETER", "Wieners don't use drugs!"]
		];
		break;
	
	#endregion
}

switch sel[1]
{
	default:
		if check_online()
			locked = gms_ini_player_read("saveData", "customlock") == sel[1];
		else
			locked = false;
		break;
	
	case "M":
		locked = true;
		break;
}
var basepal = (sel[1] == "P" or sel[1] == "SP" or sel[1] == "SN");

if sel[1] != playerid.character
	sel[0] = basepal;
else
	sel[0] = playerid.paletteselect;

selmin = 0;
selmax = pal_swap_get_pal_count(spr_palette) - 1;

if !check_shaders()
{
	sel[0] = 0;
	if basepal
		selarray[0] = selarray[1];
}

