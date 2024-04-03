/// @description sync
if instance_number(object_index) < 50
{
	gms_instance_sync_var_add("sugary", sugary);
	if sugary
		gms_instance_sync_var_add("blend2", color2);
	gms_instance_sync(self, is_onetime | isc_local);
}

