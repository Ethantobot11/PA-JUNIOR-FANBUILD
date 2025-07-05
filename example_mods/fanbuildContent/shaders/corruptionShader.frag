#pragma header
        
float POWER = 0.005; // How much the effect can spread horizontally
float VERTICAL_SPREAD = 3.0; // How vertically is the sin wave spread
float ANIM_SPEED = 0.25; // Animation speed
// Time used for updating the shader!!
uniform float iTime;
vec2 uv = openfl_TextureCoordv.xy;
void main()
{
    float y = (uv.y + iTime * ANIM_SPEED) * VERTICAL_SPREAD;
            
    uv.x += ( 
        // This is the heart of the effect, feel free to modify
        // The sin functions here or add more to make it more complex 
        // and less regular
        sin(y) 
        + sin(y * 10.0) * 0.2 
        + sin(y * 50.0) * 0.03
    ) 
    * POWER // Limit by maximum spread
    * sin(uv.y * 3.14) // Disable on edges / make the spread a bell curve
    * sin(iTime); // And make the power change in time
            
    gl_FragColor = flixel_texture2D(bitmap, uv);
}