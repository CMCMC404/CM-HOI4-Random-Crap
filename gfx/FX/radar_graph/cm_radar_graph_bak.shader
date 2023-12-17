Includes = {
}

PixelShader =
{
	Samplers =
	{
		MapTexture =
		{
			Index = 0
			MagFilter = "Point"
			MinFilter = "Point"
			MipFilter = "None"
			AddressU = "Wrap"
			AddressV = "Wrap"
		}
	}
}


VertexStruct VS_INPUT
{
	float3 vPosition  : POSITION;
	float2 vTexCoord  : TEXCOORD0;
};

VertexStruct VS_OUTPUT
{
	float4  vPosition : PDX_POSITION;
	float2  vTexCoord : TEXCOORD0;
};


ConstantBuffer( 0, 0 )
{
float4x4 WorldViewProjectionMatrix	;
float4 Color 						;
float vXOffset						;	// For textures with more than one frame
};



VertexShader =
{
	MainCode VertexShader
	[[
		
		VS_OUTPUT main(const VS_INPUT v )
		{
		    VS_OUTPUT Out;
			//framed sprite divide texture x into num of frames slices 
			float frame_number = 10000;   
		    Out.vPosition  = mul( WorldViewProjectionMatrix, float4( float( v.vPosition.x * frame_number )  , float( v.vPosition.y * 1 ) , v.vPosition.z , 1 ) );
		    Out.vTexCoord  = v.vTexCoord;
			Out.vTexCoord.x *= frame_number; 

		    return Out;
		}
		
		
	]]
}

PixelShader =
{
	MainCode PixelShaderUp
	[[
			
		float4 main( VS_OUTPUT v ) : PDX_COLOR
		{
			// edit this for any other n sided polygon, in this demo n = 6 for hexagon 	
			float sides = 6;

			float4 color1 = tex2D( MapTexture, v.vTexCoord );		

			//calculate interior angle of n sided polygon
			float pi = acos(-1);				
			float rad = 2*pi/sides ;
			 
			//xoffset start at 0 and would be off by 1
			//hopefully this doesn't introduce new issues, +.5 to fix float point shenanigans
			float frame_number = 10000;	
			float frame_input = vXOffset;	
			frame_input *= frame_number;			
			frame_input = floor(frame_input + 1.5 ) ;
			
			//break up the 4 digits interger into two		
			float l0 =  floor( frame_input*0.01 ); 				
			float l1 = ( frame_input ) % 100;
			//for aesthetic, should look better?
			if( l0 < 5 ){ l0 = 5; }			
			if( l1 < 5 ){ l1 = 5; }
			//convert to percentage, then scaled down by half
			l0 *= 0.005;
			l1 *= 0.005;
			//l0 & l1's end point coord (x0,y0) & (x1,y1) 
			//float x0 = 0;
			float y0 = 0.5 - l0;
			float x1 = l1*sin(rad);
			float y1 = 0.5 - l1*cos(rad);
			//slope of l1 and l2
			float k1 = (y1 - 0.5 ) / x1;
			float k2 = (y1 - y0 ) / x1;
			
			float4 OutColor = color1;
			OutColor.a = 0;
			
			if ( 
				// when y lower than k1*x + 0.5 and higher than k2*x + y0, 
				// together with x >=0 (by default) enclosed the area of a triangle
				(  v.vTexCoord.y <= v.vTexCoord.x*k1 + 0.5f )
				&& 
				(  v.vTexCoord.y >= k2*v.vTexCoord.x + y0 )  
			) { 
				OutColor.a = color1.a;  
			}
			//find the ratio between distance and 1px, multiply to alpha if distance smaller than 1 for aa
			float grad = abs(k2*v.vTexCoord.x - v.vTexCoord.y + y0)/sqrt(k2*k2 + 1)/0.01; 
			if ( grad < 1 ){ OutColor.a *= grad; }

			OutColor *= Color;		 	 
		    return OutColor;
		}
		
			
		
	]]
}


BlendState BlendState
{
	BlendEnable = yes
	AlphaTest = no
	SourceBlend = "src_alpha"
	DestBlend = "inv_src_alpha"
}


Effect Up
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

Effect Down
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

Effect Disable
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

Effect Over
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShaderUp"
}

