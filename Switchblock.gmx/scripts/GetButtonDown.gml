#define GetButtonDown
///GetButtonDown(input macro)
var inputVal = argument0;

with(obj_input)
{
    if(input[inputVal] && !prevInput[inputVal])
    {
        return true;
    }
    return false;
}


#define GetButton
///GetButton(input macro)
var inputVal = argument0;

with(obj_input)
{
    if(input[inputVal])
    {
        return true;
    }
    return false;
}


#define GetButtonReleased
///GetButtonReleased(input macro)
var inputVal = argument0;

with(obj_input)
{  
    if(!input[inputVal] && prevInput[inputVal])
    {
        return true;
    }
    return false;
}