precision mediump float;
uniform sampler2D tex_y;
uniform sampler2D tex_u;
uniform sampler2D tex_v;
varying vec2 vTexCoord;
uniform float zoom;
uniform float correctionRadius;
void main() {

    vec2 newCoor = vTexCoord-vec2(0.5,0.5);
    float dis = length(newCoor);
    float radius = dis / correctionRadius;
    float theta = 1.0;
    if(radius > 0.0) {
       theta = zoom*atan(radius) / radius;
    }
    vec2 newTextureCoor =  vec2(0.5,0.5)+ newCoor*theta;

    vec4 c = vec4((texture2D(tex_y, newTextureCoor).r - 16./255.) * 1.164);
    vec4 U = vec4(texture2D(tex_u, newTextureCoor).r - 128./255.);
    vec4 V = vec4(texture2D(tex_v, newTextureCoor).r - 128./255.);
    c += V * vec4(1.596, -0.813, 0, 0);
    c += U * vec4(0, -0.392, 2.017, 0);
    c.a = 1.0;
    gl_FragColor = c;
}