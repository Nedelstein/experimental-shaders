precision highp float;

void main(){
    
    // float moon=step(400.296,gl_FragCoord.y+s1+s2);
    
    float sky=1.-(gl_FragCoord.y/600.);
    // float color=sky;
    
    float wave1=sin(gl_FragCoord.x/35.)*30.;
    float waveCol1=step(300.-wave1,gl_FragCoord.y)+.2;
    
    float wave2=sin(gl_FragCoord.x/65.)*30.;
    float waveCol2=step(200.-wave2,gl_FragCoord.y);
    
    float color=min(sky,waveCol1);
    color=min(color,waveCol2);
    
    gl_FragColor=vec4(vec3(color),1.);
}
