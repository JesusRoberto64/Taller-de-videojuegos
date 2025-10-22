shader_type canvas_item;
render_mode blend_mul;
uniform float radius : hint_range(0.0, 1.0, 0.01) = 0.6;
uniform float softness : hint_range(0.0, 1.0, 0.01) = 0.3;
uniform float amount : hint_range(0.0, 1.0, 0.01) = 0.3;

void fragment() {
	float dist = distance(UV, vec2(0.5));
	float mask = smoothstep(radius, radius - softness, dist);

	COLOR.rgb *= mask * amount;
}
