shader_type canvas_item;
render_mode blend_add;

uniform vec4 color = vec4(100.0, 70.0, 50.0, 59.0);

void vertex(){
	COLOR = vec4(1.0 - VERTEX.x / color.r, 1.0- VERTEX.x / color.g, 1.0 - VERTEX.x / color.b, 1.0 - VERTEX.x / color.a);
}
