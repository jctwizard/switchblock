///ResetLevel()
//reset the player
with(obj_player)
{
    phy_position_x = checkpoint.x;
    phy_position_y = checkpoint.y;
    if(global.topdown != checkpoint.topdown)
    {
        Shift();
    }
    dead = false;
}
//reset any interactible objects
with(obj_block)
{
    phy_position_x = xstart;
    phy_position_y = ystart;
    phy_rotation = 0;
    phy_speed_x = 0;
    phy_speed_y = 0;
    phy_angular_velocity = 0;
}
