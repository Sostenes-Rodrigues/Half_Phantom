/// DRAW EVENT

// Draw player normally
draw_self();

// If hitbox is active
if (hitbox.active and global.debug)
{
    // Set red color
    draw_set_color(c_red);
    
    // Set transparency
    draw_set_alpha(0.4);
    
    // Draw rectangle
    draw_rectangle(hitbox.x1, hitbox.y1, hitbox.x2, hitbox.y2, false);
    
    // Reset alpha
    draw_set_alpha(1);
}
