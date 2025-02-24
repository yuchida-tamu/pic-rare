//
//  horographicShader.metal
//  pic-rare
//
//  Created by Yuta Uchida on 2025/02/24.
//

#include <metal_stdlib>
using namespace metal;


half4 hue2Rgba(half h) {
    half hueDeg = h * 360.0;
    half x = (1 - abs(fmod(hueDeg / 60.0, 2) - 1));
    half4 rgba;
    if (hueDeg < 60) rgba = half4(1, x, 0, 1);
    else if (hueDeg < 120) rgba = half4(x, 1, 0, 1);
    else if (hueDeg < 180) rgba = half4(0, 1, x, 1);
    else if (hueDeg < 240) rgba = half4(0, x, 1, 1);
    else if ( hueDeg < 300) rgba = half4(x, 0, 1, 1);
    else rgba = half4(1, 0, x, 1);
    return rgba;
}

// RGB to HSV変換
float3 rgb2hsv(float3 rgb) {
    float r = rgb.r;
    float g = rgb.g;
    float b = rgb.b;

    float maxVal = max(max(r, g), b);
    float minVal = min(min(r, g), b);
    float h, s, v = maxVal;

    if (maxVal == minVal) {
        h = 0;
    } else {
        float d = maxVal - minVal;
        if (maxVal == r) {
            h = (g - b) / d + (g < b ? 6 : 0);
        } else if (maxVal == g) {
            h = (b - r) / d + 2;
        } else {
            h = (r - g) / d + 4;
        }
        h /= 6;
    }

    s = (maxVal == 0 ? 0 : (maxVal - minVal) / maxVal);

    return float3(h, s, v);
}

// HSV to RGB変換
float3 hsv2rgb(float3 hsv) {
    float h = hsv.x;
    float s = hsv.y;
    float v = hsv.z;

    float3 rgb;

    if (s == 0) {
        rgb = float3(v);
    } else {
        float i = floor(h * 6);
        float f = h * 6 - i;
        float p = v * (1 - s);
        float q = v * (1 - f * s);
        float t = v * (1 - (1 - f) * s);

        if (i == 0) rgb = float3(v, t, p);
        else if (i == 1) rgb = float3(q, v, p);
        else if (i == 2) rgb = float3(p, v, t);
        else if (i == 3) rgb = float3(p, q, v);
        else if (i == 4) rgb = float3(t, p, v);
        else rgb = float3(v, p, q);
    }

    return rgb;
}

// float2 position, half4 colorはcolorEffectに含まれるデフォルトの引数
// texture2d<half> voronoiは .image(voronoi)
// float offsetは .float(offset)
[[ stitchable ]] half4 holographic(float2 position, half4 color, texture2d<half> voronoi, float offset, float saturation) {
    // positionがView上の位置なので、0〜1の値に正規化する(voronoiを3倍(Retina)サイズで作成しているのでx3してます）
    float2 coord = float2(position.x / voronoi.get_width() * 3, position.y / voronoi.get_height() * 3);
    // voronoiの値
    half4 sampled = voronoi.sample(metal::sampler(metal::filter::linear), coord);
    // offsetを足して少数部分を取り、色相からRGBに変換する
    half4 tempRgba = hue2Rgba(fract(sampled.x + offset));
    
    float3 hsv = rgb2hsv(float3(tempRgba.x, tempRgba.y, tempRgba.z));
    // 色相をRGBに変換
    float3 rgb = hsv2rgb(float3(hsv.x, hsv.y * (1 + saturation), hsv.z)); // 彩度を調整
    half4 rgba = half4(rgb.r, rgb.g, rgb.b, 1.0);

    // 加算合成
    half4 mixed = mix(color, rgba, 0.04);
    mixed.a = color.a;
    return mixed;
}
