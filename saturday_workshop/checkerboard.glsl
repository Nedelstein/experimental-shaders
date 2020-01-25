precision highp float;

// warping the checkerboard with coord;
void main(){
    
    vec2 coord=gl_FragCoord.xy;
    coord.y+=sin(coord.x/200.)*40.;
    float x=floor(coord.x/50.);
    float y=floor(coord.y/50.);
    
    float g=mod(x+y,2.);
    
    // float v = mod(x, 2.0);
    // float h = mod(y, 2.0);
    // float g = abs(h - v);
    
    gl_FragColor=vec4(g,g,g,1.);
}
