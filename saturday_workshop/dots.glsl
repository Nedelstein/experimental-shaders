precision highp float;

// to change spacing, you change the size and then compensate by changing the spacing
void main(){
    vec2 i=floor(gl_FragCoord.xy/vec2(50.,50.));
    vec2 f=fract(gl_FragCoord.xy/vec2(50.,50.));
    float d=distance(vec2(.5,.5),f);
    // float g=step(.5,d);
    float g=step(i.x*.023,d);
    
    gl_FragColor=vec4(g,g,g,1.);
}

