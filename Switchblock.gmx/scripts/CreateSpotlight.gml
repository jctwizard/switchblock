///CreateSpotlight(x, y, spotAngle, direction, distance, colour)
var xVal = argument0;
var yVal = argument1;
var angle = argument2;
var dir = argument3;
var distance = argument4;
var colour = argument5;

var newSpot = instance_create(xVal, yVal, obj_spotLight);
newSpot.angle = angle;
newSpot.direction = dir;
newSpot.distance = distance;
newSpot.colour = colour;

return newSpot;
