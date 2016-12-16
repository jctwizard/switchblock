#define InitPlayer
//gameplay
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

exiting = false;
door_x = 0;
door_y = 0;

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
var forceX = 0;
var forceY = 0;

if(GetButton(LEFT))
{
    buttonPressed = true;
    forceX = -1;
    phy_rotation = 270;
}
if(GetButton(RIGHT))
{
    buttonPressed = true;
    forceX = 1;
    phy_rotation = 90;
}
if(GetButton(UP))
{
    buttonPressed = true;
    forceY = -1;
    phy_rotation = 0;
}
if(GetButton(DOWN))
{
    buttonPressed = true;
    forceY = 1;
    phy_rotation = 180;
}

if (place_meeting(x + phy_speed_x - forceX * sprite_width*0.5, y + phy_speed_y + forceY * sprite_height*0.5, obj_wall))
{
    physics_apply_force(x, y, forceX  * t_acceleration, forceY * t_acceleration);
}
else
{
    phy_speed_x = 0;
    phy_speed_y = 0;
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
var multiplier = 1;
if(!onGround)
{
    multiplier = 0.5;
}
if(GetButton(LEFT))
{
    physics_apply_force(x, y, -s_acceleration * multiplier, 0);
    image_xscale = 1;
}
if(GetButton(RIGHT))
{
    physics_apply_force(x, y, s_acceleration * multiplier, 0);
    image_xscale = -1;
}

if(GetButtonReleased(UP))
{
    if(phy_speed_y < 0)
    {
        phy_speed_y *= 0.5;
    }
}

if(place_meeting(x, y+1, obj_block))
{
    if (onGround == false)
    {
        phy_speed_y = 0;
        onGround = true;
    }
}
else if (onGround == true)
{
    onGround = false;
}

if(GetButtonDown(ACTION) && onGround)
{
    print("jump");
    phy_speed_y = 0;
    physics_apply_force(x, y, 0, jumpForce);    
}

if(abs(phy_speed_x) > maxSpeed)
{
    //clamp the x velocity
    phy_speed_x = sign(phy_speed_x) * maxSpeed;
}

if(dead)
{
    PlayerRespawn();
}

#define PlayerUpdateAnimation
///PlayerUpdateSprite()
if(global.topdown)
{
    if(dead)
    {
        sprite_index = spr_player_topdownFall;
        image_speed = runSpeed;
    }
    else if(abs(phy_speed) > 0.1)
    {
        image_xscale = -sign(phy_speed) * abs(image_xscale);
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
        image_xscale = -sign(phy_speed_x) * abs(image_xscale);
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

if (exiting)
{
    image_xscale = image_xscale * 0.95;
    image_yscale = image_yscale * 0.95;
    
    x_diff = (door_x - x);
    y_diff = (door_y - y);
    
    distance = distance_to_point(door_x, door_y);
    
    physics_apply_force(x_diff, y_diff, 100 * sign(x_diff), 100 * sign(y_diff));
    
    if (abs(image_xscale) <= 0.1)
    {
        room_goto_next();
    }
}

#define PlayerRespawn
///PlayerRespawn()
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