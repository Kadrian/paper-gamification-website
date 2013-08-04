var num = 0;
var identifier = "num_words";
// Level 1 goes from 
//         0 to levels[0] 
int [] levels = [50, 100, 200, 300, 500, 1000, 2000, 3000, 5000];

void setup(){
	size(300, 200);
	noLoop();	
	background(0);
	colorMode(HSB,360,100,100,100);
}

void update(stats){
	num = stats[identifier];

	// RESET
	background(0);
	// DRAW STUFF
	render_stats();
	render_level();
	render_brackets();
}

void render_stats(){
	// Render stats
	fill(
		map(num, 0, levels[levels.length - 1], 0, 100),
		100,	
		100
	);
	textFont(createFont("Arial",70,true));       
	textAlign(CENTER);
	text(num, width/2, 100);

}

void render_level(){
	// Determine current level
	level = 1
	for (int l : levels){
		if (num > l)
			level++;
	}

	textAlign(CENTER);
	textFont(createFont("Arial",20,true));       
	if (levels.length == level-1){ // Last level reached
		fill(220,100,50);
		text("LEVEL " + level, width/2, 30);
	} else {
		fill(360,0,100);
		text("LEVEL " + level, width/2, 30);
	}

	render_level_progress(level);
}	

void render_level_progress(level){
	// Render progressbar
	// Parameters
	inset = 80;
	h = 20;
	y_off = 120;
	y_label_off = y_off + h + 25;
	w = width - 2 * inset;
	xp = 0;

	min_level = (level == 1) ? 0 : levels[level-2];
	max_level = (level-1 == levels.length) ? levels[level-2] : levels[level-1];

	xp = map(num, min_level, max_level, 0, w);

	stroke(360,0,100);
	strokeWeight(2);
	noFill();
	// Bar frame
	rect(inset, y_off, w, h);
	// Min and Max labels
	textFont(createFont("Arial", 12, true));       
	dash_len = 25;
	line(inset, y_off, inset, y_off + dash_len);
	line(inset + w, y_off, inset + w, y_off + dash_len);
	text(min_level, inset, y_label_off);
	text(max_level, inset + w, y_label_off);

	fill(360,0,100);
	// Bar value
	rect(inset, y_off, xp, h);
}

void render_brackets(){
	inset = 20;
	corner = 20;

	noFill();
	stroke(360,0,100);
	strokeWeight(2);
	// Left
	beginShape();
	vertex(inset + corner, inset);
	vertex(inset, inset + corner);
	vertex(inset, height - inset - corner);
	vertex(inset + corner, height - inset);
	endShape();

	// Right
	beginShape();
	vertex(width - inset - corner, inset);
	vertex(width - inset, inset + corner);
	vertex(width - inset, height - inset - corner);
	vertex(width - inset - corner, height - inset);
	endShape();
}