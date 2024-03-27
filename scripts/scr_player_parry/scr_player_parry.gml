function scr_player_parry()
{
	landAnim = false;
	if image_index >= image_number - 1
		state = states.normal;

	if movespeed <= 0
		movespeed = 0;
	else if grounded or global.gameplay != 0
		movespeed -= 0.5;
	
	hsp = movespeed * -xscale;
	
	if grounded && !scr_solid_player(x + hsp, y + 1)
		hsp = 0;
	
	image_speed = 0.5;

	var _grabbedby = 1;
	if parry_count > 0
	{
		parry_count--;
		var parry_threshold = 64;
		
		with obj_baddie
		{
			if object_index != obj_grandpa && object_index != obj_pizzaballOLD
			&& distance_to_object(other) < parry_threshold && state != states.grabbed && state != states.hit && state != states.stun && parryable && !(state == states.stun && thrown)
			{
				if global.gameplay != 0
					other.xscale = -image_xscale;
				else
					image_xscale = -other.xscale;
				
				if global.gameplay == 0
				{
					hsp = abs(hsp) * -image_xscale;
				
					if hp > 1
						hp = 1;
					grabbedby = _grabbedby;
					state = states.grabbed;
				}
				else
				{
					hp -= 5;
					other.hithsp = ((-other.image_xscale) * 25)
					other.hitvsp = -6
					scr_hitthrow(id, other.id);
					
					repeat 3
					{
						instance_create(x, y, obj_slapstar);
						create_particle(x, y, particles.baddiegibs);
					}
					
					with obj_camera
					{
						shake_mag = 3;
						shake_mag_acc = 3 / room_speed;
					}
				}
			}
		}
	}
}