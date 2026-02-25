/// DRAW EVENT

// Draw player normally
draw_self();

// If hitbox is active
if (hitbox_attack.active and global.debug)
{
    // Set red color
    draw_set_color(c_red);
    
    // Set transparency
    draw_set_alpha(0.4);
    
    // Draw rectangle
    draw_rectangle(hitbox_attack.x1, hitbox_attack.y1, hitbox_attack.x2, hitbox_attack.y2, false);
    
    // Reset alpha
    draw_set_alpha(1);
}
