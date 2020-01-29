precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;

void main(){
    
    float vertical_line=step(u_mouse.x-20.,gl_FragCoord.x)
    -step(u_mouse.x,gl_FragCoord.x);
    
    float horizontal_line=step(u_mouse.y-20.,gl_FragCoord.y)
    -step(u_mouse.y,gl_FragCoord.y);
    
    float c=max(vertical_line,horizontal_line);
    
    gl_FragColor=vec4(vec3(c),1.);
}