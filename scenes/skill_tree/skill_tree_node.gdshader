shader_type canvas_item;

uniform int N = 5;
uniform float rotation_deg = 90;

void fragment() {
	float rot = radians(rotation_deg);
	vec2 P = 2.0*UV - 1.0; // normalize to [-1,1] coordinates
	float angle = atan(P.y, P.x) + TAU + rot; // shift into [0, 2pi) range
	
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
	vec2 D = A + uAB*dot(AP, uAB);
	vec2 DP = P - D;
	if (dot(P, DP) >= 0.0) {
		discard;
	}
}
