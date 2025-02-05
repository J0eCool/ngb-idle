shader_type canvas_item;

uniform int N = 5;
uniform float rotation_deg = 90;
uniform float edge_width = 0.5;
uniform vec4 edge_color: source_color = vec4(1);
uniform float ridge = 0.65;
uniform float ridge_depth = 1.0;

void fragment() {
	float rot = radians(rotation_deg);
	vec2 P = 2.0*UV - 1.0; // normalize to [-1,1] coordinates
	float p = mod(atan(P.y, P.x) + TAU, TAU);
	float angle = p + rot; // shift into [0, 2pi) range

	int seg = int(float(N)*angle/TAU); // segment index, [0,N)
	float a = float(  seg)/float(N)*TAU - rot;
	float b = float(seg+1)/float(N)*TAU - rot;
	vec2 A = vec2(cos(a), sin(a));
	vec2 B = vec2(cos(b), sin(b));

	// project P onto AB, find corresponding point D
	// P is in tri iff DP points toward origin
	vec2 AP = P - A;
	vec2 AB = B - A;
	vec2 uAB = normalize(AB);
	vec2 normal = vec2(AB.y, -AB.x); // 90degree clockwise rotation
	vec2 D = A + uAB*dot(AP, uAB);
	vec2 DP = P - D;
	float dist = length(dot(P, normal));
	if (dot(P, DP) >= 0.0) {
		discard;
	}

	// draw ridges
	float w = edge_width / 5.0 / float(N);
	bool on_ridge = abs(dist - ridge) < w;
	bool on_edge = dist >= ridge && dist*min(abs(p-a), abs(p-b)) < w;
	if (on_ridge || on_edge) {
		COLOR.rgb = mix(COLOR.rgb, edge_color.rgb, edge_color.a);
	}
	if (dist >= ridge) {
		float t = (dist-ridge)/(1.0-ridge);
		COLOR.rgb *= mix(1.0, 1.0-ridge_depth, t);
	}
}
