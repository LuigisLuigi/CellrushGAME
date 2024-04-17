// clean ups prevent memory leaks
ds_list_destroy(tvprompts_list);
if surface_exists(promptsurface)
	surface_free(promptsurface);
if surface_exists(surf)
	surface_free(surf);
if surface_exists(popsurf)
	surface_free(popsurf);

