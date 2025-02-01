shader_type canvas_item;

uniform int N = 5;

void fragment() {
	vec2 pos = 2.0*UV - 1.0;
	float angle = atan(pos.y, pos.x) + PI; // [0, 2pi)
	
	int seg = int(float(N)*angle/TAU); // [0,N)
	float a1 =   float(seg)/float(N)*TAU;
	float a2 = float(seg+1)/float(N)*TAU;

	// attempt 1: test w/ a cross product; works but size isn't clean
	vec2 p1 = vec2(cos(a1), sin(a1));
	vec2 p2 = vec2(cos(a2), sin(a2));
	vec3 dp1 = vec3(pos - p1, 0);
	vec3 d2p = vec3(p2 - pos, 0);
	float z = cross(d2p, dp1).z;
	float size = 2.0; //sqrt(float(N));
	if (z > size) {
		discard;
	}
	
	// color based on segment
	const int N_COLORS = 8;
	vec3 colors[N_COLORS] = {
		vec3(1.0, 0.0, 0.0),
		vec3(0.0, 1.0, 0.0),
		vec3(0.0, 0.0, 1.0),
		vec3(1.0, 1.0, 0.0),
		vec3(0.0, 1.0, 1.0),
		vec3(1.0, 0.0, 1.0),
		vec3(1.0, 1.0, 1.0),
		vec3(0.0, 0.0, 0.0)
	};
	COLOR = vec4(colors[seg % N_COLORS], 1.0);
}
