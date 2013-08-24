interestingWords = new Array();

void setup(){
	size(900, 600);
	noLoop();	
	background(0);
}

void update(stats){
	var newInterestingWords = stats["interesting_words"];

	// Mostly for loading the first time
	if (interestingWords.length != newInterestingWords.length){
		interestingWords = newInterestingWords;
		redrawCloud();
	}

	// Check for change
	for (var i = 0; i < interestingWords.length; i++){
		if (interestingWords[i][0] != newInterestingWords[i][0] ||
		  	interestingWords[i][1] != newInterestingWords[i][1]){
			// Change detected
			interestingWords = newInterestingWords;
			redrawCloud();
			break;	
		}
	}
}

void redrawCloud(){
	// RESET
	background(0);

	// SETUP
	var words = new Array();

	for (var i = 0; i < interestingWords.length; i++){
		putWordThere(interestingWords[i], words);	
	}
}

void mousePressed(){
	redrawCloud();
}

void getMaxWordOccurrence(){
	// Assuming interesting words is sorted
	return interestingWords[0][1];
}

void putWordThere(word, words){
	var rotation = randomizeRotation();

	Rectangle wordRect = getRandomWordRect(word, rotation);
	while (overlapsExistingWords(wordRect, words)){
		wordRect = moveWordRect(wordRect);
	}
	words.push(wordRect);

	render(word, wordRect, rotation);
}

void randomizeRotation(){
	var chance = round(random(0,2));

	// Return either -90 degrees or 0
	if (chance == 0){
		return -PI/2.0;
	} else {
		return 0;
	}
}

void collides(Rectangle a, Rectangle b){
	if (a.x1 > b.x2 || // B left of A
		a.x2 < b.x1 || // A left of B
		a.y1 > b.y2 || // B above A
		a.y2 < b.y1){ // A above B
		return false;
	}
	return true;
}

void overlapsExistingWords(wordRect, words){
	for (var i = 0; i < words.length; i++){
		if (collides(wordRect, words[i])){
			return true;
		}
	}
	return false;
}

void getRandomWordRect(word, rotation){
	var wordText = word[0].toUpperCase();
	var wordOccurrences = word[1];
	var wordHeight = map(sq(wordOccurrences), 1, sq(getMaxWordOccurrence()), 10, 70);

	// Set font properties already for measurement
	textSize(wordHeight);
	float wordWidth = textWidth(wordText);

	float ascent = textAscent();
	float descent = textDescent();

	// Consider a canvas related padding when placing the word
	int padding = 250;

	// Consider a word related padding, respective to other words 
	int wordPadding = 2;

	if (rotation != 0){
		// Assume rotation at 90 degrees
		float x1 = random(padding, width - padding) - (wordHeight / 2.0);
		float y1 = random(padding, height - padding) - (wordWidth / 2.0);
		return new Rectangle(x1 + ascent - wordPadding, 
							 x1 + ascent + wordHeight - descent + wordPadding, 
							 y1 - wordPadding, 
							 y1 + wordWidth + wordPadding);
	} else {
		// No rotation
		float x1 = random(padding, width - padding) - (wordWidth / 2.0);
		float y1 = random(padding, height - padding) - (wordHeight / 2.0);
		return new Rectangle(x1 - wordPadding, 
							 x1 + wordWidth + wordPadding, 
							 y1 + ascent - wordPadding, 
							 y1 + ascent + wordHeight - descent + wordPadding);
	}
}

Rectangle moveWordRect(wordRect){
	// Perform a spiral movement from center
	// using the archimedean spiral and polar coordinates
	// equation: r = a + b * phi

	// Calculate mid of rect
	var midX = wordRect.x1 + (wordRect.x2 - wordRect.x1)/2.0;
	var midY = wordRect.y1 + (wordRect.y2 - wordRect.y1)/2.0;

	// Calculate radius from center 
	var r = sqrt(sq(midX - width/2.0) + sq(midY - height/2.0));

	// Set a fixed spiral width: Distance between successive turns
	var b = 15; 

	// Determine current angle on spiral
	var phi = r / b * 2.0 * PI;

	// Increase that angle and calculate new radius
	phi += 0.2;
	r = (b * phi) / (2.0 * PI);

	// Convert back to cartesian coordinates
	var newMidX = r * cos(phi);
	var newMidY = r * sin(phi);

	// Shift back respective to mid
	newMidX += width/2;
	newMidY += height/2;

	// Paint
	// stroke(255,0,0);
	// strokeWeight(3);
	// point(newMidX, newMidY);	

	// Calculate movement 
	var moveX = newMidX - midX;
	var moveY = newMidY - midY;

	// Apply movement
	wordRect.x1 += moveX;
	wordRect.x2 += moveX;
	wordRect.y1 += moveY;
	wordRect.y2 += moveY;

	return wordRect;
}

void render(word, wordRect, rotation){
	fill(random(80, 255), 
		 random(80, 255), 
		 random(80, 255));

	textAlign(CENTER,CENTER);
	// Calculate mid of rect
	var midX = wordRect.x1 + (wordRect.x2 - wordRect.x1)/2.0;
	var midY = wordRect.y1 + (wordRect.y2 - wordRect.y1)/2.0;

	if (rotation != 0){
		pushMatrix();
		translate(midX, midY);
		rotate(rotation);
		text(word[0].toUpperCase(), 0, 0);
		popMatrix();
	}
	else{
		text(word[0].toUpperCase(), midX, midY);
	}

	// fill(255, 50);
	// rect(wordRect.x1, 
	// 	wordRect.y1, 
	// 	wordRect.x2 - wordRect.x1, 
	// 	wordRect.y2 - wordRect.y1);
}

class Rectangle {
	float x1, x2, y1, y2;

	Rectangle(ix1, ix2, iy1, iy2){
		x1 = ix1;
		x2 = ix2;
		y1 = iy1;
		y2 = iy2;
	}
}