shader_type canvas_item;
render_mode blend_add;

uniform float amount : hint_range(0.0, 1.0, 0.1) = 0.6;

void fragment() {
	COLOR.rgb *= amount;
}

