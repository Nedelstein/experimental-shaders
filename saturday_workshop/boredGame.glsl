precision highp float;

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

float rand(vec2 co){
    return fract(sin(dot(co.xy,vec2(12.9898,78.233)))*43758.5453);
}

vec2 rotate(vec2 p,float angle){
    float sine=sin(angle);
    float cosine=cos(angle);
    return vec2(
        cosine*p.x+sine*p.y,
        cosine*p.y-sine*p.x
    );
}

//  rect_coord -= vec2(0.5, 0.5);
//     rect_coord = rotate(rect_coord, u_time);
//     rect_coord -= vec2(0.0, 0.3);
//     rect_coord = rotate(rect_coord, u_time * -5.0);
//     rect_coord *= 1.0 + sin(u_time);

void main(){
    vec2 i=floor(gl_FragCoord.xy/vec2(50.,50.));
    vec2 f=fract(gl_FragCoord.xy/vec2(50.,50.));
    
    vec2 mousePos=u_mouse/u_resolution;
    vec2 coord_N=u_resolution/gl_FragCoord.xy;
    vec2 offset=vec2(
        rand(i),
        rand(i+.016)
    );
    
    offset-=vec2(.9,.9);
    offset=rotate(offset,u_time);
    offset-=vec2(.6,.65);
    offset*=1.+sin(u_time);
    
    offset*=mousePos*4.5;
    
    vec3 sky=mix(vec3(.0824,.9529,.9529),vec3(.4431,.8392,.3255),coord_N.y);
    
    float d=distance(vec2(.5,.5),f+offset*.044);
    float size=rand(i)/2.*abs(sin(u_time/6.));
    float g=step(size,d);
    
    // g *= step(mousePos.y, d);
    
    vec3 color=vec3(g+rand(i*.7)*abs(sin(u_time/2.)),g+rand(i*.3)*abs(sin(u_time)),g+rand(i*.5)*abs(cos(u_time)));
    vec3 bgCol=-vec3(g+rand(i*.7)*abs(sin(u_time/2.)),g+rand(i*.3)*abs(sin(u_time)),g+rand(i*.5)*abs(cos(u_time)));
    
    // color=mix(color, sky, smoothstep(0.15, sky.x, 0.7));
    // color = mix(color,bgCol,);
    // color = smoothstep(color.y, 0.3,0.2);
    gl_FragColor=vec4(color,1.);
}