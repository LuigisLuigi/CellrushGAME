if ds_list_find_index(global.saveroom, id) != -1  
{
	if is_array(layers)
		scr_secretbigdebris(false,,,layers);
	else
		scr_secretbigdebris(false);
	instance_destroy()
}

