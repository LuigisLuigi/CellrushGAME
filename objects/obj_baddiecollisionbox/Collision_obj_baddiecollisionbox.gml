//Throw Collision
if instance_exists(baddieID) && instance_exists(other.baddieID)
{
	if global.gameplay == 0
	{
		// old
		if baddieID.state != states.grabbed
		{
			with other
			{
				if baddieID != other.baddieID && id != other.id && other.baddieID.killbyenemy
				{
					if baddieID.state == states.stun && baddieID.thrown
					{
						other.baddieID.hsp = baddieID.hsp;
						instance_destroy(other.baddieID);
					}
				}
			}
		}
	}
	else
	{
		// new
		if !baddieID.thrown && baddieID.state != states.hit && other.baddieID.thrown
		&& baddieID.killbyenemy && baddieID != other.id && baddieID.state != states.grabbed
		&& !baddieID.invincible && baddieID.instantkillable
		{
		    scr_soundeffect(sfx_punch)
		    if baddieID.object_index != obj_tank or baddieID.hp <= 0
		    {
				baddieID.hp -= 99
		        baddieID.image_xscale = other.baddieID.image_xscale
				
		        with obj_camera
		        {
		            shake_mag = 3
		            shake_mag_acc = 3 / room_speed
		        }
				
		        baddieID.hitvsp = -8
		        baddieID.hithsp = -other.baddieID.image_xscale * 15
				
				scr_hitthrow(baddieID)
		        instance_destroy(baddieID)
		    }
		    if other.baddieID.object_index != obj_tank or other.baddieID.hp <= 0
		        instance_destroy(other.baddieID)
		}
	}
}
