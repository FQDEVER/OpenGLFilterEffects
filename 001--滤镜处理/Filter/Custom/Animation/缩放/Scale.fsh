precision mediump float;
varying vec2 TextureCoordsVarying;
uniform sampler2D Texture;

void main()
{
    vec4 color = texture2D(Texture,TextureCoordsVarying);
    gl_FragColor = color;
}


