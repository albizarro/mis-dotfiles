void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 color = texture(iChannel0, uv);
    
    // El efecto de bloom debe conservarse
    float intensity = 0.2;
    float spread = 2.0;
    vec4 sum = vec4(0.0);
    vec2 size = 1.0 / iResolution.xy;
    for (int x = -2; x <= 2; x++) {
        for (int y = -2; y <= 2; y++) {
            sum += texture(iChannel0, uv + vec2(x, y) * size * spread);
        }
    }
    vec4 blur = sum / 25.0;
    
    // Cursor "Pulse" Effect based on time
    // Usa el tiempo global (iTime) para pulsar la intensidad del color
    // Esto es un "ambient effect" ya que no dependemos de la posición exacta
    // del cursor si no se expone propiamente.
    float pulse = (sin(iTime * 4.0) + 1.0) / 4.0; // Pulso suave de 0.0 a 0.5
    
    // Combinar: Color base + Bloom + un tinte cíclico muy sutil
    fragColor = color + blur * intensity + (color * pulse * 0.1);
}
