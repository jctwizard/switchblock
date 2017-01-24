///Raycast(angle, length, increment, object, [out])
///Casts a line from the calling object to check for collisions
///returns collision id or noone
///can output to a vector
var angle = argument[0];
var length = argument[1];
var increment = argument[2];
var object = argument[3];
var out = noone;
if(argument_count > 4)
{
    out = argument[4];
}

//var angle = arctan2(yDir, xDir);

var xEnd = x + (length * cos(angle));
var yEnd = y + (length * sin(angle));

var xVal = x;
var yVal = y;

var steps = length/increment;

var xStep = increment * cos(angle);
var yStep = increment * sin(angle);


for(var i = 0; i < steps; i++)
{    
    if(xVal > room_width || xVal < 0 || yVal > room_height || yVal < 0)
    {
        if(out != noone)
        {
            out.x = xVal;
            out.y = yVal;
        }
        return 0;
    }
    
    var collision = collision_point(xVal, yVal, object, false, true);
    if(collision != noone)
    {
        points = GetBlockPoints(collision);
        if(point_in_rectangle(xVal, yVal, ds_list_find_value(points, 0), ds_list_find_value(points, 1), ds_list_find_value(points, 6), ds_list_find_value(points, 7)))
        {
            if(out != noone)
            {
                out.x = xVal;
                out.y = yVal;
            }
            return collision;
        }
        ds_list_destroy(points);
    }
    xVal += xStep;
    yVal -= yStep;
}

return noone;

