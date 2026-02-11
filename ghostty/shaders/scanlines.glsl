void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 color = texture(iChannel0, uv);
    
    // Scanline intensity
    float scanline = sin(uv.y * iResolution.y * 3.14159) * 0.1;
    
    // Darken every other line slightly
    color -= scanline;
    
    fragColor = color;
}
