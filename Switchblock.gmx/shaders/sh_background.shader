//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float f_Time;

void main()
{
    float adjusted_time = f_Time * 0.01;
    float hue = (sin(v_vTexcoord.x * 1000.0 * cos(adjusted_time) + adjusted_time) + 1.0) * 0.5 * (cos(v_vTexcoord.y * 1000.0 * sin(adjusted_time) + adjusted_time) + 1.0) * 0.5;
    vec4 colour = hue * vec4(0.6, 0.3, 0.8, 1.0);
    gl_FragColor = colour;
}
