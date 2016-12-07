var inputVal = argument0;

with(obj_input)
{  
    if(!input[inputVal] && prevInput[inputVal])
    {
        return true;
    }
    return false;
}

