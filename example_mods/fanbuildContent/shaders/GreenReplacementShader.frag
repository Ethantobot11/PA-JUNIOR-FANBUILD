#pragma header

uniform float rCol;
uniform float gCol;
uniform float bCol;

void main()
{
    vec2 uv = openfl_TextureCoordv;
        
    vec4 greenScreen = vec4(0.,1.,0.,1.);
    vec3 color = flixel_texture2D(bitmap, uv).rgb;
    float alpha = flixel_texture2D(bitmap, uv).a;
        
    vec3 diff = color.xyz - greenScreen.xyz;
    float fac = smoothstep(0.5-0.05,0.5+0.05, dot(diff,diff));
        
    //color = mix(color, replacementColour, 1.-fac);
    color = mix(color, vec3(rCol, gCol, bCol), 1.-fac);
    gl_FragColor = vec4(color.rgb * alpha, alpha);
}