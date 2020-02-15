precision highp float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_sampler;

varying vec2 v_texcoord;

void main(){
    
    vec4 noise=texture2D(u_sampler,v_texcoord+vec2(u_time*.1));
    vec4 color=vec4(1.);
    vec2 uv=v_texcoord;
    
    noise-=.1;
    uv+=noise.ba*.1;
    
    float d=distance(vec2(.5),uv);
    float spacing=.03;
    d=mod(d,spacing)/spacing;
    d=step(.6,d);
    color.rgb=vec3(d);
    
    gl_FragColor=color+noise.rbba;
}
