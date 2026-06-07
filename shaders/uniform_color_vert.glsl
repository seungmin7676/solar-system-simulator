#version 300 es
layout(location = 0) in vec3 vPosition;

uniform mat4 worldMat, viewMat, projMat;

void main()
{
    gl_Position = projMat * viewMat * worldMat * vec4(vPosition, 1);
    // ignored for non-POINTS primitives; lets this shader double as the starfield's point shader
    gl_PointSize = 2.0;
}