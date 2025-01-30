uniform float uScrollI;
uniform float uTime;

varying vec2 vUv;

// 2D Random
float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))
                 * 43758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation
    vec2 u = f*f*(3.0-2.0*f);
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

void main() {
    vec2 pos = vec2(vec2(vUv) * 2.0);
    pos += sin(uScrollI * 0.007);

    float strength = noise(pos * 2.0);

    // Change the color to #2d4034 (RGB: 45, 64, 52)
    vec3 color1 = vec3(0.1765, 0.2509, 0.2039); // #2d4034 normalized
    // Change the white to a shade of green
    vec3 color2 = vec3(0.8, 1.0, 0.8); // Light greenish-white

    // Adjust the mixing ratio to favor green more
    vec3 mixedColor = mix(color1, color2, strength * 0.12); // Reduce white content to 12%

    gl_FragColor = vec4(mixedColor, 1.0);
}