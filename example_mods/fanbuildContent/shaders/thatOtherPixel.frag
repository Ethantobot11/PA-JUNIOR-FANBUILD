/*#pragma header

vec2 fragCoord;
vec2 iResolution;
uniform float size;

void main() {
	fragCoord = openfl_TextureCoordv*openfl_TextureSize;
	iResolution = openfl_TextureSize;
	vec2 coordinates = fragCoord.xy/iResolution.xy;
	vec2 pixelSize = vec2(size/iResolution.x, size/iResolution.y);
	vec2 position = floor(coordinates/pixelSize)*pixelSize;
	vec4 finalColor = flixel_texture2D(bitmap, position);
	gl_FragColor = finalColor;
}*/
#pragma header
vec2 uv;
vec2 fragCoord;
vec2 iResolution;
float iTime;
#define iChannel0 bitmap
#define texture texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float size;

void mainImage() {
    uv = openfl_TextureCoordv.xy;
    fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    iResolution = openfl_TextureSize;
	vec2 coordinates = fragCoord.xy/iResolution.xy;
	vec2 pixelSize = vec2(size/iResolution.x, size/iResolution.y);
	vec2 position = floor(coordinates/pixelSize)*pixelSize;
	vec4 finalColor = texture2D(iChannel0, position);
	fragColor = finalColor;
}