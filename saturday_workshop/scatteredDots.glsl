precision highp float;

float rand(vec2 co){
    return fract(sin(dot(co.xy,vec2(12.9898,78.233)))*43758.5453);
}

void main(){
    vec2 i=floor(gl_FragCoord.xy/vec2(50.,50.));
    vec2 f=fract(gl_FragCoord.xy/vec2(50.,50.));
    
    vec2 offset=vec2(
        rand(i),
        rand(i+.016)
    );
    
    float d=distance(vec2(.5,.5),f+offset*.044);
    float size=rand(i)/1.960;
    float g=step(size,d);
    
    gl_FragColor=vec4(g+rand(i*.7),g+rand(i*.9),g+rand(i*.3),1.);
}
