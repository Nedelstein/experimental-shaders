precision highp float;

// to change spacing, you change the size and then compensate by changing the spacing
void main(){
    vec2 i=floor(gl_FragCoord.xy/vec2(50.,50.));// unused!
    vec2 f=fract(gl_FragCoord.xy/vec2(50.,50.));
    float d=distance(vec2(.5,.5),f);
    // float g=step(.5,d);
    float g=step(i.x*.02,d);
    
    gl_FragColor=vec4(g,g,g,1.);
}

// void main() {
    //     float y = gl_FragCoord.y;
    //     y += sin(gl_FragCoord.x / 20.0) * 10.;
    //     y+= mod(gl_FragColor.x,2.);
    //     float g = step(20.0, mod(y, 50.0));
    //     gl_FragColor = vec4(g, g, g, 1.0);
// }

