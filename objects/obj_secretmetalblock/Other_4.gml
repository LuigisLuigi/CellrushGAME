if ds_list_find_index(global.saveroom, id) != -1  
{
	scr_secretbigdebris(false);
	instance_destroy(id, false);
}

