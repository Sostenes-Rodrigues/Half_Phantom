// Apply gravity if not grounded
if (!on_ground)
{
    // Increase vertical speed with gravity
    vspd += grav;
}

// Apply vertical movement
y += vspd;

#region Simple ground check
if (y >= room_height)
{
    // Snap to ground
    y = room_height
    
    // Reset vertical speed
    vspd = 0
    
    // Set grounded
    on_ground = true
}
else
{
    // Entity is in air
    on_ground = false
}
#endregion
