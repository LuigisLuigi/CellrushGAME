switch loadwhat
{
	case -1:
		window_center();
		scr_initinput();
		scr_initinput2();
		
		loadwhat = 0;
		break;
	
	case 0:
		if !ds_list_empty(tex_list) && ds_exists(tex_list, ds_type_list)
		{
		    var b = ds_list_find_value(tex_list, 0);
		    for (var i = 0; i < array_length(b); i++)
		    {
		        if !texture_is_ready(b[i])
		            texture_prefetch(b[i]);
		    }
		    ds_list_delete(tex_list, 0);
		}
		else
		{
		    ds_list_destroy(tex_list);
		    loadwhat = -5;
			alarm[1] = 5;
		}
		break;
}
alarm[0] = 1;
