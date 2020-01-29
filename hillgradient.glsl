precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

float random(in vec2 st){
    return fract(sin(dot(st.xy,
                vec2(12.9898,78.233)))
            *43758.5453123);
        }
        
        float noise(in vec2 st){
            vec2 i=floor(st);
            vec2 f=fract(st);
            
            // Four corners in 2D of a tile
            float a=random(i);
            float b=random(i+vec2(1.,0.));
            float c=random(i+vec2(0.,1.));
            float d=random(i+vec2(1.,1.));
            
            // Smooth Interpolation
            
            // Cubic Hermine Curve.  Same as SmoothStep()
            vec2 u=f*f*(3.-2.*f);
            // u = smoothstep(0.,1.,f);
            
            // Mix 4 coorners percentages
            return mix(a,b,u.x)+
            (c-a)*u.y*(1.-u.x)+
            (d-b)*u.x*u.y;
        }
        
        void main(){
            vec2 coord_N=gl_FragCoord.xy/u_resolution;
            coord_N.y/=u_resolution.x/u_resolution.y;
            
            float hills=sin(coord_N.x/.03)*.08;
            
            // hills *= sin(.);
            hills*=sin(.3)*3.;
            
            vec2 hills_vec2=vec2(hills);
            // hills *= sin(coord_N.y * 3.);
            
            // hills=smoothstep(hills, 0.1,0.2);
            
            float hill_height=step(.4-hills*sin(u_time)*noise(hills_vec2)*200.,coord_N.y);
            
            float r=smoothstep(hill_height,abs(sin(u_time)/.3),2.);
            float g=smoothstep(hill_height,abs(sin(u_time)/.01),.2);
            float b=smoothstep(hill_height,abs(sin(u_time)/.8),.1);
            
            gl_FragColor=vec4(r,g,b,1.);
        }