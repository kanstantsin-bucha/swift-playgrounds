//
//  DistortionShader.metal
//  SwiftUI1


#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] float2 sineShader(float2 position, float2 size) {
    float f = sin(position.x / size.x * M_PI_F * 2);
    return float2(position.x, position.y + f * 20);
}

[[ stitchable ]] float2 transitionShader(float2 position, float2 size, float effectValue) {
    float skewF = 0.1 * size.x;
    float yRatio = position.y / size.y;
    
    float positiveEffect = effectValue * sign(effectValue);
    float skewProgress = min(0.5 - abs(positiveEffect - 0.5), 0.2) / 0.2;
    
    float skew = effectValue > 0 ? yRatio * skewF * skewProgress : (1 - yRatio) * skewF * skewProgress;
    float shift = effectValue * size.x;
    
    return float2(position.x + (shift + skew * sign(effectValue)), position.y);
}

[[ stitchable ]] float2 slideAwayShader(float2 position, float2 size, float time, float direction) {
    float2 c = size / 2;
    float2 v = position - c;
    
    float f = (direction > 0 ? position.x : (size.x - position.x)) / size.x;
    
    if (time > f) {
        float mul = (time - f) / (1 - f);
        return c + v * mul;
    }
    else {
        return float2(-1, -1);
    }
}


