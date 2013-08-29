hoverBlocks = [];

void setup(){
	size(1000, 80);
	noLoop();	
	background(0);
	colorMode(HSB, 360, 100, 100, 100);
}

void update(stats){
	var paragraphs = stats["paragraphs"];

	// RESET
	background(0);

	// DRAW STUFF
	renderParagraphs(paragraphs);
}

void renderParagraphs(paragraphs){
	float barWidth = 990;
	float xInset = (width - barWidth) / 2.0;
	float y = 2;
	float yHeight = 20;

	int sum = 0;
	for (var i = 0; i < paragraphs.length; i++){
		sum += paragraphs[i][1]
	}

	// Block sizes for mouseover
	// Will look like: hoverX, title, wordCount
	// E.g:  200, "Title", 44
	hoverBlocks = [];

	float x = xInset;
	for (var i = 0; i < paragraphs.length; i++){
		float blockWidth = float(paragraphs[i][1]) / float(sum) * float(barWidth);

		// Rainbow colors
		// fill(map(x + blockWidth / 2.0, xInset, width - xInset, 0, 360), 100, 100);
		fill(0,0,100);

		stroke(0);
		strokeWeight(6);
		rect(x, y, blockWidth, yHeight);	

		x += blockWidth;	

		if (i == paragraphs.length - 1){ // Check for last paragraph
			hoverBlocks.push([width, paragraphs[i][0], paragraphs[i][1]]);
		} else {
			hoverBlocks.push([x, paragraphs[i][0], paragraphs[i][1]]);
		}
	}
}

void resetCaption(){
	fill(0);
	stroke(0);
	rect(0,25,width, height);
}

void mouseMoved(){
	resetCaption();

	for (var i = 0; i < hoverBlocks.length; i++){
		if (mouseX < hoverBlocks[i][0]){
			textAlign(CENTER);
			fill(0,0,100);
			noStroke();
			// Draw number of words
			textSize(20);
			text(hoverBlocks[i][2] + " words", width/2, 50);
			// Draw caption
			textSize(15);
			text(hoverBlocks[i][1], width/2, 70);
			break;
		}
	}
}

void mouseOut(){
	resetCaption();
}