    #pragma header

    float zoom = 1.0;
    void main()
    {
        #pragma body

        vec2 uv = openfl_TextureCoordv;
        uv = (uv-.5)*2.;
        uv *= zoom;
        
        uv.x *= 1.0 + pow(abs(uv.y/2.0),3.0);
        uv.y *= 1.0 + pow(abs(uv.x/2.0),3.0);
        uv = (uv + 1.0)*0.5;
        
        vec4 tex = vec4( 
            flixel_texture2D(bitmap, uv+.001).r,
            flixel_texture2D(bitmap, uv).g,
            flixel_texture2D(bitmap, uv-.001).b, 
            flixel_texture2D(bitmap, uv).a
        );
        
        tex *= smoothstep(uv.x,uv.x+0.01,1.0)*smoothstep(uv.y,uv.y+0.01,1.)*smoothstep(-0.01,0.0,uv.x)*smoothstep(-0.01,0.0,uv.y);
        
        float avg = (tex.r+tex.g+tex.b)/3.0;
        gl_FragColor = tex + pow(avg,3.0);
    }