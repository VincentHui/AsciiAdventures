Shader "Custom/vaporWave" {
	 Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _CharTex ("CharTex", 2D) = "white" {} 
        _Brightness ("brightness", Range (0.02,800)) = 200 
        _PixWidth ("width", float) = 128 // sliders
        _PixHeight ("height", float) = 41 // sliders    
    }
    SubShader {
        Pass {
            ZTest Always Cull Off ZWrite Off Fog { Mode off }

            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"
            uniform sampler2D _MainTex;
            uniform sampler2D _CharTex;
            uniform float _PixWidth;
            uniform float _PixHeight;
            uniform float _Brightness;
            
            float3 frag (v2f_img i):COLOR{
                float pixel_width = 1.0f/_PixWidth;
				float pixel_height = 1.0f/_PixHeight;
				half2 new_uv = half2((int)(i.uv.x/pixel_width)*pixel_width, (int)(i.uv.y/pixel_height)*pixel_height);
				float3 c =  tex2D(_MainTex, new_uv);
			    float colR = c.r * 255;
			    float colG = c.g * 255;
			    float colB = c.b * 255;

			    int brighness = min((int)(((colR + colG + colB)/3/_Brightness) * 6), 8);
			    int onSpriteX = (i.uv.x * 31.0f * 128.0f) % 31.0f;
			    int onSpriteY = ((i.uv.y * 52.0f * 41.0f) % 52.0f)*16.0f/9.0f;


			    half2 charCoords = half2((brighness * 31.0f / 300.0f)+(onSpriteX/300.0f),(onSpriteY / 300.0f));

			    float3 charC = tex2D(_CharTex, charCoords);

			    float3 finalColor = float3(0,0,0);

			    if(charC.r != 1.0){
			        finalColor = float3(0,0,0);
			    }else{
			        finalColor = float3(colR/255, colG/255, colB/255);
			    }
			    return finalColor;
            }
            ENDCG
        }
    }
}
