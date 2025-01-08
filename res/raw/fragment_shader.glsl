#extension GL_OES_EGL_image_external : require
precision mediump float;
varying vec2 vTexCoord;
uniform samplerExternalOES sampler2d;
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
	gl_FragColor  = texture2D(sampler2d, newTextureCoor);
}
