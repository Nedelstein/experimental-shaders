Shader "Unlit/Unlit_Lit"
{
    Properties
    {
       _MainTex ("Texture", 2D) = "white" {}
       _Albedo ("Albedo", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

//            vertex to frag shader v2f
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                half3 worldNormal : TEXCOORD1;
                float3 worldPosition : TEXCOORD2;

            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition = mul(v.vertex, unity_ObjectToWorld);

                return o;
            }


            fixed4 _Albedo;
            fixed4 frag (v2f i) : SV_Target
            {

                // start the lit color at black, we'll add each lighting
                // components contribution in turn
                fixed4 litColor = fixed4(0.0,0.0,0.0, 1.0);

                // ambient lighting illuminates all parts of the object equally
                fixed3 ambient_color = fixed3(0.2, 0.3, 0.9);
                litColor.rgb += _Albedo.rgb * ambient_color;

                // diffuse lighting illuminates the parts of the object that face hte light
                // the dot product tells us how aligned the object normal is to the light
                fixed3 diffuse_color = fixed3(1.0,0.2,0.2);
                fixed3 light_position = fixed3(0.3, 1.0, -1.0);
                float dot_product = dot(normalize(light_position), normalize(i.worldNormal));
                dot_product = max(dot_product, 0.0);

                litColor.rgb += _Albedo.rgb * diffuse_color * dot_product;

                // specular lighting simulates reflecting glare
                // specular color reflects off the surface so ignores albedo
                // specular needs to know the camera position, which is hard coded here
                // this won't work if the camera moved.
                fixed3 specular_color = fixed3(1.0,1.0,0.6);

                // half = mediump
                half3 camera_position = half3(0.0,0.0,-2.0);

                float shininess = 20.0;
                half3 R = reflect(normalize(light_position), normalize(i.worldNormal));
                half3 V = normalize(i.worldPosition - camera_position);
                float specular_intensity = pow(max(0,dot(R,V)), shininess);

                litColor.rgb += specular_intensity * specular_color;

                return litColor;
            }
            ENDCG
        }
    }
}
