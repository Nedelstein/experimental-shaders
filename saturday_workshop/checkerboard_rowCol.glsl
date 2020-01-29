precision highp float;

float rand(vec2 co){
    return fract(sin(dot(co.xy,vec2(12.9898,78.233)))*43758.5453);
}

void main(){
    vec2 i=floor(gl_FragCoord.xy/vec2(50.,50.));
    vec2 f=fract(gl_FragCoord.xy/vec2(50.,50.));
    
    vec3 color=vec3(
        rand(vec2(i.x)+.1),
        rand(vec2(i.x)+.2),
        rand(vec2(i.x)+.3)
    );
    
    float tint=rand(vec2(i.y,0.));
    
    tint=tint*.5+.5;
    
    gl_FragColor=vec4(color*tint,1.);
}