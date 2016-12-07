///print(string);
var event = ""
switch(event_type)
{
    case ev_create:
        event = "Create";
        break;
    case ev_destroy:
        event = "Destroy";
        break;
    case ev_step:
        event = "Step";
        break;
    case ev_alarm:
        event = "Alarm";
        break;
    case ev_keyboard:
        event = "Keyboard";
        break;
    case ev_keypress:
        event = "Keyboard Press";
        break;
    case ev_keyrelease:
        event = "Keyboard Release";
        break;
    case ev_mouse:
        event = "Mouse";
        break;
    case ev_collision:
        event = "Collision";
        break;
    case ev_other:
        event = "Other";
        break;
    case ev_draw:
        event = "Draw";
        break;
    default:
        event="Unknown Event";
        break;
}

show_debug_message(object_get_name(event_object) + " - " + event + "::    " + string(argument0));
