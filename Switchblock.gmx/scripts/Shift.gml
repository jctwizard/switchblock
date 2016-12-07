///Shift()
global.topdown = !global.topdown

if(global.topdown)
{
    physics_world_gravity(0.0, 0.0);
}
else
{
    obj_player.phy_rotation = 0;
    physics_world_gravity(0.0, 50.0);
}
