# Sprite Masking in Defold

## Overview
This repository implements a masking system for sprites and spine animations in Defold using stencil buffer techniques. The approach allows for controlled visibility of game elements, showing them only where mask objects exist.

## Key Components

### Custom Render Script
The render script handles the core functionality by:
- Adding a dedicated "blocker" predicate for defining mask shapes
- Setting up proper stencil buffer configuration and testing
- Ensuring game elements only render where the stencil test passes
- Managing the rendering pipeline to maintain proper masking behavior

### Fragment Shader for Masks
```glsl
varying mediump vec2 var_texcoord0;
uniform lowp sampler2D texture_sampler;
void main()
{
   // Sample the texture
   vec4 color = texture2D(texture_sampler, var_texcoord0.xy);
   // Discard fragment if alpha is below threshold
   if (color.a < 0.1) {
       discard;
   }
   // Output white (actual color doesn't matter due to color masking)
   gl_FragColor = vec4(1.0);
}
```

### Rendering Process

Enable stencil testing and disable color writing
Draw blocker objects to the stencil buffer, marking visible areas
Re-enable color writing and set stencil test to only draw where stencil = 1
Render game objects (tiles, sprites, particles) with the stencil test active
Disable stencil testing for UI and debug elements

### Result
The implementation creates a masking effect where game elements only appear within the shapes defined by blocker objects. This can be used for revealing mechanics, special effects, or UI elements.

### Future Improvements
Implement anti-aliasing for mask edges to eliminate the current pixelation
Add support for alpha blending at boundaries for smoother transitions
Consider optimizing the stencil operations for better performance
