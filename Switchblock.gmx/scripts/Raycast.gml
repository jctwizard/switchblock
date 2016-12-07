///Raycast(xDir, yDir, length, increment, object)
///Casts a line from the calling object to check for collisions
///returns collision id or noone
var xDir = argument0;
var yDir = argument1;
var length = argument2;
var increment = argument3;
var object = argument4;

var angle = arctan2(yDir, xDir);

var xEnd = phy_position_x + (length * cos(angle));
var yEnd = phy_position_y + (length * sin(angle));

var xVal = phy_position_x;
var yVal = phy_position_y;

var steps = length/increment;

var xStep = increment * cos(angle);
var yStep = increment * sin(angle);


for(var i = 0; i < steps; i++)
{    
    
    var collision = collision_point(xVal, yVal, object, false, true)
    if(collision != noone)
    {
        return collision;
    }
    xVal += xStep;
    yVal -= yStep;
}

return noone;

