precision highp float;

void main(){
    float y=gl_FragCoord.y;
    y+=sin(gl_FragCoord.x/200.)*100.;
    y+=sin(gl_FragCoord.x/20.)*10.;
    y+=sin(gl_FragCoord.x/5.)*5.;
    
    float g=step(20.,mod(y,50.));
    gl_FragColor=vec4(g,g,g,1.);
}
