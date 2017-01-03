///GetBlockPoints(block)
var block = argument0;

points = ds_list_create();

//top left
ds_list_add(points, block.x, block.y);

var rotation = block.phy_rotation * (pi / 180);
var width = TILE_SIZE * block.image_xscale;
var height = TILE_SIZE * block.image_yscale;

//top right
ds_list_add(points, block.x + width*cos(rotation));
ds_list_add(points, block.y + height*sin(rotation));
//bottom left
ds_list_add(points, block.x - height*sin(rotation));
ds_list_add(points, block.y + height*cos(rotation));
//bottom right
ds_list_add(points, block.x + width*cos(rotation) - height*sin(rotation));
ds_list_add(points, block.y + height*sin(rotation) + height*cos(rotation));

return points;
