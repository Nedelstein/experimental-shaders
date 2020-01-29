precision highp float;

uniform vec2 u_resolution;
uniform float u_time;

void main(){
    vec2 coord_N=gl_FragCoord.xy/u_resolution;
    coord_N.y/=u_resolution.x/u_resolution.y;
    float sun=distance(vec2(.70,.9),coord_N);
    
    coord_N.x+=u_time*.5;
    float hill1=sin(coord_N.x*1.1)*.200;
    float hill2=sin(coord_N.x*15.)*.05;
    float hill3=sin(coord_N.x*21.1)*.02;
    
    // vec3 out_color = vec3(0.0, 0.0, 0.0);
    // out_color.r = float(step(sun,0.432));
    
    vec3 sky=mix(vec3(.7,.7,1.),vec3(0.,.2,1.),coord_N.y);
    sky=mix(vec3(.855,.764,.005),sky,step(.15,sun));
    vec3 scene=mix(sky,vec3(.338,.900,.430),step(coord_N.y,.3+hill1+hill2+hill3));
    
    gl_FragColor=vec4(scene,1.);
}
