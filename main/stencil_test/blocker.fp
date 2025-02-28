varying mediump vec2 var_texcoord0;
uniform lowp sampler2D texture_sampler;

void main()
{
    // Sample the texture
    vec4 color = texture2D(texture_sampler, var_texcoord0.xy);

    // Discard fragment if alpha is below threshold (e.g. 0.1)
    // This prevents writing to the stencil buffer for transparent pixels
    if (color.a < 0.1) {
        discard;
    }

    // Otherwise output white (the actual color doesn't matter for stencil test)
    // Since we're using color masking when drawing blockers,
    // this won't be visible on screen anyway
    gl_FragColor = vec4(1.0);
}    