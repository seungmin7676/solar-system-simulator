#version 300 es
precision mediump float;

// Based on light_tex_frag.glsl (Blinn-Phong + texture). The original assumes a
// constant uniform `lightDir`, i.e. a directional light such as sunlight on Earth.
// That model doesn't fit a scene where the Sun is a point light at the centre of
// the system: every planet must be lit from the direction *toward the Sun*, which
// changes from fragment to fragment (and from planet to planet). So `lightDir` is
// replaced with `sunPos`, and the light direction/attenuation are derived per-fragment.
uniform sampler2D texImage;
uniform vec3 matSpec, matAmbi, matEmit;
uniform float matSh;
uniform vec3 srcDiff, srcSpec, srcAmbi;
uniform vec3 sunPos;

in vec3 fNormal, fView, worldPos;
in vec2 fTexCoord;

layout(location = 0) out vec4 fragColor;

void main()
{
    vec3 normal = normalize(fNormal);
    vec3 view = normalize(fView);

    vec3 toSun = sunPos - worldPos;
    float dist = length(toSun);
    vec3 light = toSun / dist;
    float atten = 1.0 / (1.0 + 0.0008 * dist * dist);

    vec4 texColor = texture(texImage, fTexCoord);
    vec3 matDiff = texColor.rgb;
    vec3 diff = max(dot(normal, light), 0.0) * srcDiff * matDiff;

    vec3 halfVec = normalize(light + view);
    vec3 spec = pow(max(dot(normal, halfVec), 0.0), matSh) * srcSpec * matSpec;

    vec3 ambi = srcAmbi * matAmbi;

    fragColor = vec4((diff + spec) * atten + ambi + matEmit, texColor.a);
}
