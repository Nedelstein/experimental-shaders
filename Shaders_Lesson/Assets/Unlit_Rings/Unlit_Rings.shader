Shader "Unlit/Unlit_Rings"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
                float2 uv : TEXCOORD0;
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float d = distance(float2(.5, .5), i.uv);
                d += _SinTime.z;
                d = fmod(d, .2) * 20.0;
                d = step(.5, d);
                float r = d * abs(sin(_Time.y));
                r *= i.uv;
                float g = d * abs(cos(_Time.z));
                // g *= i.uv;
                float b = d * abs(sin(_Time.w));
                // b = b / i.uv;
                // b +=sin(coord.x * sin(u_time / 60.0) * 300.0) + sin(coord.y * cos(u_time / 60.0) * 90.0)
                fixed4 col = float4(r, g, b, 1.0);
              
                return col;
            }
            ENDCG
        }
    }
}
