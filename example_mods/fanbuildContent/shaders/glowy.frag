//SHADERTOY PORT FIX
#pragma header

void main()
{
    #pragma body

    vec2 uv = openfl_TextureCoordv.xy;
    vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;
    float iTime = 0.0;
    float Size = 0.0;
    const float blurSize = 1.0 / 512.0;
    const float intensity = 0.85;


    vec4 sum = vec4(0.0);
    vec2 texcoord = fragCoord.xy/iResolution.xy;
    int j;
    int i;
    
    sum += flixel_texture2D(bitmap, vec2(texcoord.x - 4.0*blurSize, texcoord.y)) * 0.05;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x - 3.0*blurSize, texcoord.y)) * 0.09;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x - 2.0*blurSize, texcoord.y)) * 0.12;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x - blurSize, texcoord.y)) * 0.15;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y)) * 0.16;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x + blurSize, texcoord.y)) * 0.15;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x + 2.0*blurSize, texcoord.y)) * 0.12;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x + 3.0*blurSize, texcoord.y)) * 0.09;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x + 4.0*blurSize, texcoord.y)) * 0.05;
        
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y - 4.0*blurSize)) * 0.05;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y - 3.0*blurSize)) * 0.09;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y - 2.0*blurSize)) * 0.12;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y - blurSize)) * 0.15;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y)) * 0.16;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y + blurSize)) * 0.15;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y + 2.0*blurSize)) * 0.12;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y + 3.0*blurSize)) * 0.09;
    sum += flixel_texture2D(bitmap, vec2(texcoord.x, texcoord.y + 4.0*blurSize)) * 0.05;
    
    gl_FragColor = sum*intensity + flixel_texture2D(bitmap, texcoord); 
}
