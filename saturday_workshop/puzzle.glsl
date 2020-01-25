precision highp float;

void main(){
    
    float d=distance(vec2(300.,300.),gl_FragCoord.xy);
    
    //1 - the step shows the inverse (switches the colors)
    float disc=1.-step(100.,d);
    float side=step(300.,gl_FragCoord.x);
    
    //take the max instead of the min
    float g=max(disc,side);
    gl_FragColor=vec4(g,g,g,1.);
}