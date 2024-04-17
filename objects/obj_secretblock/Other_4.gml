if ds_list_find_index(global.saveroom, ID) != -1  
{
	if is_array(layers)
		scr_secretdebris(false,,,layers);
	else
		scr_secretdebris(false);
	instance_destroy() 
}

