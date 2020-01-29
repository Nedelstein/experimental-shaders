
precision mediump float;
uniform vec2 u_mouse;
uniform vec2 u_resolution;

#define PI 3.14159265359

vec2 rotate(vec2 p,float angle){
    float sine=sin(angle);
    float cosine=cos(angle);
    return vec2(
        cosine*p.x+sine*p.y,
        cosine*p.y-sine*p.x
    );
}

void main(){
    vec2 coord_N=gl_FragCoord.xy/u_resolution;
    coord_N.y/=u_resolution.x/u_resolution.y;
    
    vec2 mouse_N=u_mouse/u_resolution;
    mouse_N.y=u_mouse.x/u_mouse.y;
    
    vec2 coord=gl_FragCoord.xy;
    
    // coord*=rotate2d(sin(.05));
    // coord*=.5;
    coord=rotate(coord,.7);
    // coord*=0.5;
    
    // coord_N *= sin(45.);
    
    float left_x=step(u_mouse.x-10.,coord.x)-step(u_mouse.x,coord.x);
    float right_x=step(u_mouse.y-10.,coord.y)-step(u_mouse.y,coord.y);
    
    float c=max(right_x,left_x);
    // vec2 x = vec2(c);
    // c*=step(sin(45.), 1.1);
    gl_FragColor=vec4(vec3(c),1.);
    
}