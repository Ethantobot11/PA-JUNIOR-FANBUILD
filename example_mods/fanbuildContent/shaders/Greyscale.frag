#pragma header

void main() //https://www.shadertoy.com/view/tllSz2
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = openfl_TextureCoordv;

    vec4 tex = flixel_texture2D(bitmap, uv);
    vec3 greyScale = vec3(0.333333333, 0.333333333, 0.333333333);
    gl_FragColor = vec4(vec3(dot(tex.rgb, greyScale)), tex.a);
}