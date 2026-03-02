//
// Basic box blur fragment shader
//

varying vec2 v_vTexcoord;

uniform float u_blur;        // Blur intensity
uniform vec2 u_texel;        // Texture pixel size

void main()
{
    vec4 sum = vec4(0.0);

    // Sample 9 pixels (3x3 blur)
    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2(-1.0, -1.0)) * 0.111;
    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2( 0.0, -1.0)) * 0.111;
    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2( 1.0, -1.0)) * 0.111;

    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2(-1.0,  0.0)) * 0.111;
    sum += texture2D(gm_BaseTexture, v_vTexcoord)                             * 0.111;
    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2( 1.0,  0.0)) * 0.111;

    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2(-1.0,  1.0)) * 0.111;
    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2( 0.0,  1.0)) * 0.111;
    sum += texture2D(gm_BaseTexture, v_vTexcoord + u_texel * vec2( 1.0,  1.0)) * 0.111;

    gl_FragColor = sum;
}