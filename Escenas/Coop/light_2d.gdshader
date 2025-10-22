shader_type canvas_item;
render_mode blend_add;

void vertex(){
	COLOR = vec4(1.0 - VERTEX.x / 100.0, 1.0- VERTEX.x / 70.0, 1.0 - VERTEX.x / 50.0, 1.0 - VERTEX.x / 59.0);
}
