if ds_list_find_index(global.escaperoom, id) != -1  
	instance_destroy(id, false);
if global.snickchallenge
	instance_destroy(id, false);

if global.panic
	image_alpha = 1;
