#pragma header

vec2 uv;
vec2 fragCoord;
vec2 iResolution;
float iTime;
#define iChannel0 bitmap
#define iChannel1 bitmap
#define iChannel2 bitmap
#define iChannelResolution bitmap
#define texture texture2D
#define fragColor gl_FragColor
#define mainImage main
float uTime;
vec4 iMouse;

const float amount = 1.0;

float dim = 2.0;
float Directions = 17.0;
float Quality = 20.0; 
float Size = 22.0; 
vec2 Radius;

void mainImage()
{ 
    uv = openfl_TextureCoordv.xy;
    fragCoord = openfl_TextureCoordv * openfl_TextureSize; //hi its me mariomaster
    iResolution = openfl_TextureSize;
    iTime = 0.0;
    uTime = 0.0;
    iMouse = vec4(0.0, 0.0, 0.0, 0.0);

    float Pi = 6.28318530718; // Pi*2
        
    vec4 Color = texture2D( bitmap, uv);
    
    for( float d=0.0; d<Pi; d+=Pi/Directions){
    for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality){
    float ex = (cos(d)*Size*i)/openfl_TextureSize.x;
    float why = (sin(d)*Size*i)/openfl_TextureSize.y;

    Color += texture2D(bitmap, uv+vec2(ex,why));	
    }
    }
        
    Color /= (dim * Quality) * Directions - 15.0;
    vec4 bloom =  (texture2D(bitmap, uv)/ dim)+Color;

    gl_FragColor = bloom;
}