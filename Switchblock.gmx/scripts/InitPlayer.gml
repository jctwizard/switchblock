#define InitPlayer
//gameplay
topdown = false;

//movement
maxSpeed = 5;
acceleration = 100;
onGround = false;
jumpForce = -500;

phy_fixed_rotation = true;

//animation
idleSpeed = (1/15);
runSpeed = 0.25;

#define PlayerShift
///player_shift()
topdown = !topdown

if(topdown)
{
    physics_world_gravity(0.0, 0.0);
    
}
else
{
    physics_world_gravity(0.0, 10.0);
}

#define PlayerStepTopdown
///PlayerStepTopdown
var buttonPressed = false;
if(GetButton(LEFT))
{
    buttonPressed = true;
    physics_apply_force(x, y, -acceleration, 0);
}
if(GetButton(RIGHT))
{
    buttonPressed = true;
    physics_apply_force(x, y, acceleration, 0);
}
if(GetButton(UP))
{
    buttonPressed = true;
    physics_apply_force(x, y, 0, -acceleration);
}
if(GetButton(DOWN))
{
    buttonPressed = true;
    physics_apply_force(x, y, 0, acceleration);
}
if(!buttonPressed)
{
    phy_speed_x *= 0.75;
    phy_speed_y *= 0.75;
}

//clamp the velocity
if(phy_speed > maxSpeed)
{
    phy_speed_x = (phy_speed_x/phy_speed) * maxSpeed;
    phy_speed_y = (phy_speed_y/phy_speed) * maxSpeed;
}

//check for floor(wall) collisions
if(!place_meeting(x, y, obj_wall))
{
    phy_position_x = xstart;
    phy_position_y = ystart;
}

#define PlayerStepPlatform
///PlayerStepPlatform
if(GetButton(LEFT))
{
    physics_apply_force(x, y, -acceleration, 0);
    image_xscale = 1;
}
if(GetButton(RIGHT))
{
    physics_apply_force(x, y, acceleration, 0);
    image_xscale = -1;
}

if(place_meeting(x, y+1, obj_floor))
{
    onGround = true;
}
else
{
    onGround = false
}

if(GetButtonDown(ACTION) && onGround)
{
    print("jump");
    physics_apply_force(x, y, 0, jumpForce);    
}

if(abs(phy_speed_x) > maxSpeed)
{
    //clamp the x velocity
    phy_speed_x = sign(phy_speed_x) * maxSpeed;
}

#define PlayerUpdateAnimation
///PlayerUpdateSprite()
if(topdown)
{
    sprite_index = spr_player_topdown;
    image_speed = idleSpeed;
}
else
{
    if(abs(phy_speed_x) > 0.1)
    {
        image_xscale = -sign(phy_speed_x);
        sprite_index = spr_player_platformRun;
        image_speed = runSpeed + (runSpeed * (abs(phy_speed_x) / maxSpeed));
    }
    else
    {
        sprite_index = spr_player_platform;
        image_speed = idleSpeed;
    }
}