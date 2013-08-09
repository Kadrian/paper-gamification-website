// Level 1 goes from 0 to levels[0]
int [] levels = [10, 20, 50, 100, 150, 200, 300, 400, 570];

void setup(){
	size(300, 200);
	noLoop();	
	background(0);
	colorMode(HSB, 360, 100, 100, 100);
}

void update(stats){
	wordsHits = stats["awl_coverage"]["words_hits"];
	wordsTotal = stats["awl_coverage"]["words_total"];
	categoryHits = stats["awl_coverage"]["category_num_hits"];
	categoryTotal = stats["awl_coverage"]["category_total"];

	// RESET
	background(0);

	// DRAW STUFF
	renderStats();
	renderLevel();
	renderBrackets();
}

void renderStats(){
	// Render stats
	fill(
		map(categoryHits, 0, levels[levels.length - 1], 0, 100),
		100,	
		100
	);
	int yOff = 95;
	textFont(createFont("Arial",45,true));
	textAlign(CENTER);
	text(categoryHits + " of " + categoryTotal, width/2, yOff);
	textFont(createFont("Arial",20,true));       
	text("categories unlocked", width/2, yOff + 30);
}

void renderLevel(){
	// Determine current level
	level = 1
	for (int l : levels){
		if (categoryHits > l)
			level++;
	}

	yOff = 40;
	textAlign(CENTER);
	textFont(createFont("Arial", 20, true));
	if (levels.length == level - 1){
		fill(120, 100, 100); // Last level reached -> green
		text("LEVEL " + level, width/2, yOff);
	} else {
		fill(360, 0, 100); // White
		text("LEVEL " + level, width/2, yOff);
	}

	renderLevelProgress(level);
}	

void renderLevelProgress(level){
	// Layout Parameters 
	inset = 80;
	h = 20;
	yOff = 150;
	yLabelOff = yOff + h + 25;
	w = width - 2 * inset;

	minLevel = (level == 1) ? 0 : levels[level-2];
	maxLevel = (level-1 == levels.length) ? levels[level-2] : levels[level-1];

	// Calculate current xp in pixels
	xp = map(categoryHits, minLevel, maxLevel, 0, w);

	stroke(360,0,100);
	strokeWeight(2);
	noFill();

	// Progress bar frame
	rect(inset, yOff, w, h);

	// Min and Max labels
	textFont(createFont("Arial", 12, true));       
	dashLen = 25;
	line(inset, yOff, inset, yOff + dashLen);
	line(inset + w, yOff, inset + w, yOff + dashLen);
	text(minLevel, inset, yLabelOff);
	text(maxLevel, inset + w, yLabelOff);

	// Bar value
	fill(360, 0, 100);
	rect(inset, yOff, xp, h);
}

void renderBrackets(){
	inset = 20;
	corner = 20;

	noFill();
	stroke(360, 0, 100);
	strokeWeight(2);
	// Left
	beginShape();
	vertex(inset + corner, inset);
	vertex(inset, inset + corner);
	vertex(inset, height - inset - corner);
	vertex(0, height - inset);
	endShape();

	// Right
	beginShape();
	vertex(width - inset - corner, inset);
	vertex(width - inset, inset + corner);
	vertex(width - inset, height - inset - corner);
	vertex(width, height - inset);
	endShape();
}