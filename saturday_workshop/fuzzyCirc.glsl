precision highp float;

void main(){
    float circ1=distance(vec2(200.,300.),gl_FragCoord.xy);
    float circ2=distance(vec2(400.,300.),gl_FragCoord.xy);
    
    float circ1Col=smoothstep(100.,150.,circ1);
    float circ2Col=smoothstep(100.,150.,circ2);
    
    float color=circ1Col*circ2Col;
    
    gl_FragColor=vec4(vec3(color),1.);
}
