precision highp float;
uniform sampler2D Texture;
varying vec2 TextureCoordsVarying;

const float mosaicSize = 0.03;

void main()
{
    float length = mosaicSize;
    float TR = 0.866025;
    float TB = 1.5;

    float x = TextureCoordsVarying.x;
    float y = TextureCoordsVarying.y;
    
    int wx = int(x / (TB * length));
    int wy = int(y / (TR * length));
    
    vec2 v1, v2, vn;
    if(wx/2 * 2 == wx){
        if (wy/2 * 2 == wy) {
            v1 = vec2(length * TB * float(wx),length * TR * float(wy));
            v2 = vec2(length * TB * float(wx+1),length * TR * float(wy+1));
        }else{
            v1 = vec2(length * TB * float(wx+1),length * TR * float(wy));
            v2 = vec2(length * TB * float(wx),length * TR * float(wy+1));
        }
    }else{
        if (wy/2 * 2 == wy) {

            v1 = vec2(length * TB * float(wx+1),length * TR * float(wy));
            v2 = vec2(length * TB * float(wx),length * TR * float(wy+1));
        }else{
            
            v1 = vec2(length * TB * float(wx),length * TR * float(wy));
            v2 = vec2(length * TB * float(wx+1),length * TR * float(wy+1));
        }
    }
    
    float s1 = sqrt(pow(v1.x - x,2.0) + pow(v1.y - y,2.0));
    float s2 = sqrt(pow(v2.x - x,2.0) + pow(v2.y - y,2.0));
    
    vn = s1 < s2 ? v1 : v2;

    float a = atan((x - vn.x)/(y - vn.y));
    float PI6 = 0.523599;
    
    vec2 area1 = vec2(vn.x,vn.y - length * TR / 2.0);
    vec2 area2 = vec2(vn.x + length * 0.5,vn.y - length * TR / 2.0);
    vec2 area3 = vec2(vn.x + length * 0.5,vn.y + length * TR / 2.0);
    vec2 area4 = vec2(vn.x,vn.y + length * TR / 2.0);
    vec2 area5 = vec2(vn.x - length * 0.5,vn.y + length * TR / 2.0);
    vec2 area6 = vec2(vn.x - length * 0.5,vn.y - length * TR / 2.0);
    
    
    if (a >= PI6 && a < PI6 * 3.0) {
        vn = area1;
    }else if (a >= PI6 * 3.0 && a < PI6 * 5.0){
        vn = area2;
    }else if ((a >= PI6 * 5.0 && a <= PI6 * 6.0) || (a < -PI6 * 5.0 && a > -PI6 * 6.0)){
        vn = area3;
    }else if (a < -PI6 * 3.0 && a >= -PI6 * 5.0){
        vn = area4;
    }else if (a <= -PI6 && a > -PI6 * 3.0){
        vn = area5;
    }else if (a > -PI6 && a < PI6){
        vn = area6;
    }
    
    vec4 color = texture2D(Texture,vn);
    gl_FragColor = color;
}

