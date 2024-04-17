with (obj_teleporter_editor)
if trigger = other.trigger && start = 0
repeat (8) with instance_create(x+random_range(50,-50),y+random_range(50,-50),obj_cloudeffect)
sprite_index=  spr_teleporteffect

player.visible =true
player.state = storedstate
player.movespeed = storedmovespeed
player.grav = storedgrav
player.image_index = storedimageindex
player.sprite_index = storedspriteindex
player.freefallsmash = storedfreefallsmash
