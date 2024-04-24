function scr_panicbg_init(stop = false)
{
	// Initialize wavy panic background whenever timer starts or room changes
	if !check_shaders()
		exit;
	
	var layers, layernum = 0

	// Check for all layers that exist
	for(var i = 0; i < ds_list_size(global.roombgs); i++)
	{
		var l = global.roombgs[|i];
		if layer_get_depth(l.lay) < 0 // trust me it would completely break the game
			continue;
		
		var bg = layer_background_get_sprite(l.bg);
		if bg != bg_etbbrick && bg != bg_select
			layers[layernum++] = layer_get_name(l.lay);
	}
	
	// No backgrounds found
	if !layernum
		exit;
	
	// Change to panic shader on top layer, reset on bottom layer
	var bottom_id = layer_get_id(layers[layernum - 1])
	var top_id = layer_get_id(layers[0])
	layer_script_begin(bottom_id, stop ? -1 : scr_panicbg_start)
	layer_script_end(top_id, stop ? -1 : scr_panicbg_end)
}

function scr_panicbg_start()
{
	//DDP This script is run every time the first background starts to draw
	if !check_shaders()
		exit;
	
	if !variable_global_exists("panicbg_surface") or !surface_exists(global.panicbg_surface)
		global.panicbg_surface = surface_create(_camw + 128, _camh + 128)
	global.panicbg_width = 960;

	if event_type == ev_draw and event_number == 0
	{
		// Render all background layers to panicbg_surface instead of application_surface
		surface_set_target(global.panicbg_surface);
		draw_clear_alpha(c_black, 0);
		
		// Offset each layer to account for scrolling
		var _cam_x = camera_get_view_x(view_camera[0])
		var _cam_y = camera_get_view_y(view_camera[0])
		
		var siz = ds_list_size(global.roombgs);
		for (var i = 0; i < siz; i++;)
		{
			var l = global.roombgs[|i], lay = l.lay;
			if layer_get_depth(lay) < 0
				continue;
			
			layer_x(lay, layer_get_x(lay) - _cam_x + 64)
			layer_y(lay, layer_get_y(lay) - _cam_y + 64)
			
			global.panicbg_width = max(global.panicbg_width, sprite_get_width(layer_background_get_sprite(l.bg)));
		}
	}
}

function scr_panicbg_end()
{
	//DDP This script is run after the last background element has been drawn
	if !check_shaders()
		exit;
	
	if event_type == ev_draw && event_number == 0
	{
		// demo 3 stuff because i CAN
		gpu_set_blendenable(false)
		gpu_set_colorwriteenable(false, false, false, true)
		draw_rectangle(-192, -192, _camw + 192, _camh + 192, 0)
		gpu_set_blendenable(true)
		gpu_set_colorwriteenable(true, true, true, true)
		
		// Set panic background shader and render to application_surface
		surface_reset_target()
		
		if instance_exists(obj_panicdebris)
		{
			shader_set(shd_panicbg)
			
			// Set panic intensity in shader
			var panic_id = shader_get_uniform(shd_panicbg, "panic")
			shader_set_uniform_f(panic_id, global.wave / global.maxwave)
			
			// Set current time in shader
			var time_id = shader_get_uniform(shd_panicbg, "time")
			shader_set_uniform_f(time_id, current_time / (global.panicbg_width + 40))
			
			// Set amplitude
			var mult_id = shader_get_uniform(shd_panicbg, "mult");
			shader_set_uniform_f(mult_id, 1);
			
			// Draw panicbg_surface and reset to application surface
			var x1 = camera_get_view_x(view_camera[0]) - 64;
			var y1 = camera_get_view_y(view_camera[0]) - 64;
			var x2 = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 64;
			var y2 = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 64;
			
			draw_surface_ext(global.panicbg_surface, x1, y1, 1, 1, 0, -1, 1)
			shader_reset()
			
			// flash white for escape bgs
			if obj_panicdebris.flasha > 0
			{
				draw_set_alpha(obj_panicdebris.flasha);
				draw_set_colour(c_white);
				draw_rectangle(x1, y1, x2, y2, false);
				draw_set_alpha(1);
			}
		}
	}
}

