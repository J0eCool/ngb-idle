shader_type canvas_item;

uniform float x = 0.3;

void fragment() {
	float r = 1.0;
	vec2 pos = 2.0*UV - 1.0;
	if (length(pos) >= r) {
		discard;
	}
	COLOR *= vec4(2.0*pos, x, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
