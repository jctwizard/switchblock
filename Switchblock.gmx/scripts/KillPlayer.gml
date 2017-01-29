with(obj_player)
{
    dead = true;
    repeat(random_range(10, 20))
    {
        instance_create(x, y, obj_blood);
    }
}
