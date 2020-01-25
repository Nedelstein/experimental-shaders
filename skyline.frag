#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
// uniform e

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    st.x*=u_resolution.x/u_resolution.y;
    
    vec2 i=floor(st*10.);
    vec2 f=fract(st*10.);
    
    float left=step(.1,f.x);
    float bottom=step(.0,st.y);
    float right=step(f.x,.9);
    float top=step(st.y,sin(i.x*73.)*.25+.5);
    float inRect=left*top*right*bottom;
    
    vec3 sky=mix(vec3(.3,.3,.9),vec3(0.,0.,.65),1.-st.y);
    vec3 scene=mix(sky,vec3(0.,0.,0.),inRect);
    
    gl_FragColor=vec4(scene,1.);
    
}