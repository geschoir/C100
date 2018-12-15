// Adapted from:
// http://callumhay.blogspot.com/2010/09/gaussian-blur-shader-glsl.html

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

const int MAX_NUM_BALLS = 200;
const int NUM_PARAMS = 3;

uniform float[MAX_NUM_BALLS * NUM_PARAMS] balls;

uniform float HIGH_PASS;
uniform float LOW_PASS;

uniform float glow = 1.0 / MAX_NUM_BALLS * 10;

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {  

	float sum = 0;

	for(int i = 0; i < MAX_NUM_BALLS * NUM_PARAMS; i += 3) {
		
		float x = balls[i + 0];
		float y = balls[i + 1];
		float r = balls[i + 2];

		float dx = x - vertTexCoord.x;
		float dy = y - vertTexCoord.y;

		sum += r / sqrt(dx * dx + dy * dy);

	}

	if(sum > HIGH_PASS) {
		sum = 1;
	}

	else if(sum > LOW_PASS){
		sum = abs((sum - LOW_PASS) / (HIGH_PASS - LOW_PASS));
		}
	else {
		//sum *= glow;
		sum = 0;
		}

	// float dc = 1 - 2 * sqrt((vertTexCoord.x - .5) * (vertTexCoord.x - .5) + (vertTexCoord.y - .5) * (vertTexCoord.y - .5));

	float hue = (80 + sum * 60 + vertTexCoord.x * 60 + vertTexCoord.y * 60) / 360.0;
	float sat = .75 + .25 * (1 - sum * sum);
	float brg = sum;

	vec3 rgb = hsv2rgb(vec3(hue, sat, brg));
	vec4 rgba = vec4(rgb.rgb, sum);

  gl_FragColor = rgba;
}