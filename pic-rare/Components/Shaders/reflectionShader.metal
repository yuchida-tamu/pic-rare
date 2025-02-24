//
//  reflectionShader.metal
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
    float2 texcoord [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float2 texcoord;
};

vertex VertexOut vertexShader(VertexIn in [[stage_in]]) {
    VertexOut out;
    out.position = in.position;
    out.texcoord = in.texcoord;
    return out;
}

[[ stitchable ]] half4 imageFilterShader(float2 position,
                                    half4 color,
                                         float offsetX,
                                         float offsetY ) {
    // Calculate the "light direction" based on the offset.
    // You can tweak these values to adjust the reflection effect.
    float3 lightDir = normalize(float3(offsetX, offsetY, 1.0)); // Z is important for "3D" effect
    
    // Get the surface normal (assuming a flat card for simplicity.  For more complex shapes, you'd need normals from your geometry).
    float3 normal = float3(0, 1, 0);  // Card facing directly forward
    
    // Calculate the dot product between the light direction and the normal.
    // This will be higher when the light is more aligned with the surface normal.
    float reflectionFactor = dot(lightDir, normal);
    
    // Clamp the reflection factor to avoid negative values (no light from behind).
    reflectionFactor = clamp(reflectionFactor, 0.0, 1.0);
    
    // Create a highlight color (e.g., white or a lighter version of your base color).
    half4 highlightColor = half4(1.0, 1.0, 1.0, 1.0); // White highlight
    half4 finalColor = color + ( highlightColor - color ) * ( reflectionFactor * 0.1f );

    
    return finalColor;
}
