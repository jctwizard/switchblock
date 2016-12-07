#define InitPlayer
//gameplay
topdown = false;
dead = false;
checkpoint = noone;

//movement
maxSpeed = 5;
s_acceleration = 500;
t_acceleration = 100;
onGround = false;
jumpForce = -1750;

phy_fixed_rotation = true;

//animation
idleSpeed = (1/15);
runSpeed = 0.25;
prevSprite = sprite_index;

#define PlayerShift
///player_shift()
topdown = !topdown

if(topdown)
{
    physics_world_gravity(0.0, 0.0);
}
else
{
    phy_rotation = 0;
    physics_world_gravity(0.0, 50.0);
}

#define PlayerStepTopdown
///PlayerStepTopdown
if(dead)
{
    phy_speed_x = 0;
    phy_speed_y = 0;
    exit;
}
//check the input
var buttonPressed = false;
if(GetButton(LEFT))
{
    buttonPressed = true;
    physics_apply_force(x, y, -t_acceleration, 0);
    phy_rotation = 270;
}
if(GetButton(RIGHT))
{
    buttonPressed = true;
    physics_apply_force(x, y, t_acceleration, 0);
    phy_rotation = 90;
}
if(GetButton(UP))
{
    buttonPressed = true;
    physics_apply_force(x, y, 0, -t_acceleration);
    phy_rotation = 0;
}
if(GetButton(DOWN))
{
    buttonPressed = true;
    physics_apply_force(x, y, 0, t_acceleration);
    phy_rotation = 180;
}

//no button was pressed - decelerate
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
    dead = true;
}

#define PlayerStepPlatform
///PlayerStepPlatform
if(GetButton(LEFT))
{
    physics_apply_force(x, y, -s_acceleration, 0);
    image_xscale = 1;
}
if(GetButton(RIGHT))
{
    physics_apply_force(x, y, s_acceleration, 0);
    image_xscale = -1;
}

if(GetButtonReleased(UP))
{
    if(phy_speed_y < 0)
    {
        phy_speed_y *= 0.5;
    }
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
    if(dead)
    {
        sprite_index = spr_player_topdownFall;
        image_speed = runSpeed;
    }
    else if(abs(phy_speed) > 0.1)
    {
        image_xscale = -sign(phy_speed);
        sprite_index = spr_player_topdownRun;
        image_speed = runSpeed + (runSpeed * (abs(phy_speed) / maxSpeed));
    }
    else
    {
        sprite_index = spr_player_topdown;
        image_speed = idleSpeed;
    }
    
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
    if(!onGround)
    {
        sprite_index = spr_player_platformJump;
    }
}

if(sprite_index != prevSprite)
{
    image_index = 0;
}

prevSprite = sprite_index;

#define PlayerRespawn
///PlayerRespawn()
with(obj_player)
{
    phy_position_x = checkpoint.x;
    phy_position_y = checkpoint.y;
    if(topdown != checkpoint.topdown)
    {
        PlayerShift();
    }
    dead = false;
}
