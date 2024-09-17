/// @description Creates an instance of a given object at a given position.
/// @param x The x position the object will be created at.
/// @param y The y position the object will be created at.
/// @param obj The object to create an instance of.
/// @param var_struct* The object to create an instance of.
function instance_create(xx, yy, obj, var_struct = undefined)
{
	var myDepth = object_get_depth(obj);
	if is_struct(var_struct)
		return instance_create_depth(xx, yy, myDepth, obj, var_struct);
	return instance_create_depth(xx, yy, myDepth, obj);
}
