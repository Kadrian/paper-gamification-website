// Global variables
var num = 0;
var identifier = "";
int [] levels = []; // Level 1 goes from 0 to levels[0]

void setup(){
	size(300, 200);
	noLoop();	
	background(0);
	colorMode(HSB, 360, 100, 100, 100);
}

void setLevels(lev){
	levels = lev;
}

void setIdentifier(id){
	identifier = id;
}

void update(stats){
	num = stats[identifier];

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
		map(num, 0, levels[levels.length - 1], 0, 100),
		100,	
		100
	);
	yOff = 110;
	textFont(createFont("Arial", 70, true));       
	textAlign(CENTER);
	text(num, width/2, yOff);
}

void renderLevel(){
	// Determine current level
	level = 1
	for (int l : levels){
		if (num >= l)
			level++;
	}

	yOff = 40;
	textAlign(CENTER);
	textFont(createFont("Arial",20,true));       
	if (levels.length == level-1){ // Last level reached
		fill(120, 100, 100);
		text("LEVEL " + level + " (MAX)", width/2, yOff);
	} else {
		fill(360, 0, 100);
		text("LEVEL " + level, width/2, yOff);
	}

	renderLevelProgress(level);
}	

void renderLevelProgress(level){
	// Parameters
	inset = 80;
	h = 20;
	yOff = 130;
	yLabelOff = yOff + h + 25;
	w = width - 2 * inset;
	xp = 0;

	// Determine level min + max borders
	minLevel = 0;
	maxLevel = 0;
	if (level == 1){
		// First level
		maxLevel = levels[level-1];
	} else if (level-1 == levels.length) {
		// Last level
		minLevel = levels[level-2];
		maxLevel = num;
	} else {
		// Default	
		minLevel = levels[level-2];
		maxLevel = levels[level-1];
	}

	// Calculate current xp in pixels
	xp = map(num, minLevel, maxLevel, 0, w);

	// In case we've hit the max level render full bar
	if (minLevel == maxLevel){
		xp = w;
	}

	stroke(360, 0, 100);
	strokeWeight(2);
	noFill();

	// Bar frame
	rect(inset, yOff, w, h);

	// Min and Max labels
	textFont(createFont("Arial", 12, true));       
	dashLen = 25;
	line(inset, yOff, inset, yOff + dashLen);
	line(inset + w, yOff, inset + w, yOff + dashLen);
	text(minLevel, inset, yLabelOff);
	text(maxLevel, inset + w, yLabelOff);

	// Bar value
	fill(360,0,100);
	rect(inset, yOff, xp, h);
}

void renderBrackets(){
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