#version 300 es
precision mediump float;

// New shader written for this project (no course example renders a self-luminous
// body). It reuses the rim/Fresnel glow idea seen in lighting exercises, but
// repurposes it: instead of highlighting a *selected* object from an external
// light, here the glow IS the object's own light source -- a pulsing corona
// around a turbulent, noise-shaded emissive surface.
uniform vec3 uBaseColor;
uniform vec3 uGlowColor;
uniform float uTime;

in vec3 fNormal, fView, worldPos;

layout(location = 0) out vec4 fragColor;

// cheap turbulence: layered sine waves sampled in object space (no texture lookup)
float turbulence(vec3 p, float t)
{
    float n = sin(p.x * 2.6 + t) * sin(p.y * 3.1 - t * 1.3) * sin(p.z * 2.3 + t * 0.8);
    n += 0.5 * sin(p.x * 5.0 - t * 1.7) * sin(p.z * 4.4 + t * 1.1);
    return n * 0.5 + 0.5; // -> [0, 1]
}

void main()
{
    vec3 normal = normalize(fNormal);
    vec3 view = normalize(fView);

    float n = turbulence(worldPos, uTime);
    vec3 surface = mix(uBaseColor * 0.65, uBaseColor * 1.35, n);

    float rim = pow(1.0 - max(dot(normal, view), 0.0), 2.0);
    float pulse = 0.65 + 0.35 * sin(uTime * 2.0);
    vec3 corona = uGlowColor * rim * pulse;

    fragColor = vec4(surface + corona, 1.0);
}
