Shader "TRI/THS/BumpMapped"
{
	Properties
	{
		_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
		_Shininess ("Shininess", Range (0.03, 1)) = 0.078125
	
		// set by terrain engine
		[HideInInspector] _Control ("Control (RGBA)", 2D) = "red" {}
		[HideInInspector] _Splat3 ("Layer 3 (A)", 2D) = "white" {}
		[HideInInspector] _Splat2 ("Layer 2 (B)", 2D) = "white" {}
		[HideInInspector] _Splat1 ("Layer 1 (G)", 2D) = "white" {}
		[HideInInspector] _Splat0 ("Layer 0 (R)", 2D) = "white" {}
		[HideInInspector] _Normal3 ("Normal 3 (A)", 2D) = "bump" {}
		[HideInInspector] _Normal2 ("Normal 2 (B)", 2D) = "bump" {}
		[HideInInspector] _Normal1 ("Normal 1 (G)", 2D) = "bump" {}
		[HideInInspector] _Normal0 ("Normal 0 (R)", 2D) = "bump" {}
		// used in fallback on old cards & base map
		[HideInInspector] _MainTex ("BaseMap (RGB)", 2D) = "white" {}
		[HideInInspector] _Color ("Main Color", Color) = (1,1,1,1)

		// plugin-specific
		[HideInInspector] _CutoutModeHideAlpha("Cutout Mode Hide Alpha", Range(-1, 1)) = .5
		[HideInInspector] _TransparencyMap("Transparency Map (RGBA)", 2D) = "black" {}
	}
	
	// without no-shadows-mode
	SubShader
	{
		LOD 1001
		Tags
		{
			"SplatCount" = "4"
			"Queue" = "Geometry"
			"RenderType" = "TransparentCutout"
		}
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaTest Greater [_CutoutModeHideAlpha]
		Cull Off // comment out this line to only show the front faces of terrain surfaces
		
		CGPROGRAM
		#pragma surface surf BlinnPhong vertex:vert alphatest:_none exclude_path:prepass
		#pragma target 3.0
		
		void vert (inout appdata_full v)
		{
			v.tangent.xyz = cross(v.normal, float3(0,0,1));
			v.tangent.w = -1;
		}
		
		struct Input
		{
			float2 uv_Control : TEXCOORD0;
			float2 uv_Splat0 : TEXCOORD1;
			float2 uv_Splat1 : TEXCOORD2;
			float2 uv_Splat2 : TEXCOORD3;
			float2 uv_Splat3 : TEXCOORD4;
		};
		
		sampler2D _Control;
		sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
		sampler2D _Normal0,_Normal1,_Normal2,_Normal3;
		half _Shininess;
		
		float _CutoutModeHideAlpha;
		sampler2D _TransparencyMap;

		void surf (Input IN, inout SurfaceOutput o)
		{
			fixed4 splat_control = tex2D (_Control, IN.uv_Control);
			fixed4 col;
			col  = splat_control.r * tex2D (_Splat0, IN.uv_Splat0);
			col += splat_control.g * tex2D (_Splat1, IN.uv_Splat1);
			col += splat_control.b * tex2D (_Splat2, IN.uv_Splat2);
			col += splat_control.a * tex2D (_Splat3, IN.uv_Splat3);
			o.Albedo = col.rgb;
		
			fixed4 nrm;
			nrm  = splat_control.r * tex2D (_Normal0, IN.uv_Splat0);
			nrm += splat_control.g * tex2D (_Normal1, IN.uv_Splat1);
			nrm += splat_control.b * tex2D (_Normal2, IN.uv_Splat2);
			nrm += splat_control.a * tex2D (_Normal3, IN.uv_Splat3);
			// Sum of our four splat weights might not sum up to 1, in case of more than 4 total splat maps. Need to lerp toward "flat normal" in that case.
			fixed splatSum = dot(splat_control, fixed4(1,1,1,1));
			fixed4 flatNormal = fixed4(0.5,0.5,1,0.5); // this is "flat normal" in both DXT5nm and xyz*2-1 cases
			nrm = lerp(flatNormal, nrm, splatSum);
			o.Normal = UnpackNormal(nrm);
		
			o.Gloss = col.a * splatSum;
			o.Specular = _Shininess;
			
			o.Alpha = 0.0;
			
			fixed transApplication = tex2D(_TransparencyMap, IN.uv_Control).a;
			fixed totalOpacity = 1 - transApplication;
			
			if (_CutoutModeHideAlpha != -1) // cutout mode enabled
			{
				if (totalOpacity > _CutoutModeHideAlpha)
				{
					o.Albedo = col / totalOpacity;
					o.Alpha = 1;
				}
			}
			else
			{				
				o.Alpha = totalOpacity;
				o.Albedo = col / o.Alpha;
			}
		}
		ENDCG
	}

	// with no-shadows-mode
	SubShader
	{
		LOD 1000
		Tags
		{
			"SplatCount" = "4"
			"Queue" = "AlphaTest+100"
			"RenderType" = "TransparentCutout"
		}
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaTest Greater [_CutoutModeHideAlpha]
		Cull Off // comment out this line to only show the front faces of terrain surfaces
		
		CGPROGRAM
		#pragma surface surf BlinnPhong vertex:vert alphatest:_none exclude_path:prepass
		#pragma target 3.0
		
		void vert (inout appdata_full v)
		{
			v.tangent.xyz = cross(v.normal, float3(0,0,1));
			v.tangent.w = -1;
		}
		
		struct Input
		{
			float2 uv_Control : TEXCOORD0;
			float2 uv_Splat0 : TEXCOORD1;
			float2 uv_Splat1 : TEXCOORD2;
			float2 uv_Splat2 : TEXCOORD3;
			float2 uv_Splat3 : TEXCOORD4;
		};
		
		sampler2D _Control;
		sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
		sampler2D _Normal0,_Normal1,_Normal2,_Normal3;
		half _Shininess;
		
		float _CutoutModeHideAlpha;
		sampler2D _TransparencyMap;

		void surf (Input IN, inout SurfaceOutput o)
		{
			fixed4 splat_control = tex2D (_Control, IN.uv_Control);
			fixed4 col;
			col  = splat_control.r * tex2D (_Splat0, IN.uv_Splat0);
			col += splat_control.g * tex2D (_Splat1, IN.uv_Splat1);
			col += splat_control.b * tex2D (_Splat2, IN.uv_Splat2);
			col += splat_control.a * tex2D (_Splat3, IN.uv_Splat3);
			o.Albedo = col.rgb;
		
			fixed4 nrm;
			nrm  = splat_control.r * tex2D (_Normal0, IN.uv_Splat0);
			nrm += splat_control.g * tex2D (_Normal1, IN.uv_Splat1);
			nrm += splat_control.b * tex2D (_Normal2, IN.uv_Splat2);
			nrm += splat_control.a * tex2D (_Normal3, IN.uv_Splat3);
			// Sum of our four splat weights might not sum up to 1, in case of more than 4 total splat maps. Need to lerp toward "flat normal" in that case.
			fixed splatSum = dot(splat_control, fixed4(1,1,1,1));
			fixed4 flatNormal = fixed4(0.5,0.5,1,0.5); // this is "flat normal" in both DXT5nm and xyz*2-1 cases
			nrm = lerp(flatNormal, nrm, splatSum);
			o.Normal = UnpackNormal(nrm);
		
			o.Gloss = col.a * splatSum;
			o.Specular = _Shininess;
			
			o.Alpha = 0.0;
			
			fixed transApplication = tex2D(_TransparencyMap, IN.uv_Control).a;
			fixed totalOpacity = 1 - transApplication;
			
			if (_CutoutModeHideAlpha != -1) // cutout mode enabled
			{
				if (totalOpacity > _CutoutModeHideAlpha)
				{
					o.Albedo = col / totalOpacity;
					o.Alpha = 1;
				}
			}
			else
			{				
				o.Alpha = totalOpacity;
				o.Albedo = col / o.Alpha;
			}
		}
		ENDCG
	}
	
	Dependency "AddPassShader" = "Hidden/Nature/Terrain/Bumped Specular AddPass"
	Dependency "BaseMapShader" = "Specular"
	
	Fallback "Diffuse"
}