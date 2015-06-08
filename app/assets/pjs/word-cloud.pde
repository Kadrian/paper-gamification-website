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
	// Assign each word a font size based on its occurrence
	var wordText = word[0].toUpperCase();
	var wordOccurrences = word[1];
	var wordHeight = map(sq(wordOccurrences), 0, sq(getMaxWordOccurrence()), 10, 70);

	// Set font properties already for measurement
	textSize(wordHeight);
	float wordWidth = textWidth(wordText);


	float ascent = textAscent();
	float descent = textDescent();

	// Consider a canvas related padding when placing the word
	int padding = 250;

	// Consider a word related padding, respective to other words
	int wordPadding = 4;

	// TODO: Refactor, looks ugly ;-)
	Point p = new Point(0,0);
	if (rotation != 0){
		// Assume rotation at 90 degrees
		p.x = random(padding, width - padding) - (wordHeight / 2.0);
		p.y = random(padding, height - padding) - (wordWidth / 2.0);
		return new Rectangle(p.x + ascent - wordPadding,
							 p.x + ascent + wordHeight - descent + wordPadding,
							 p.y - wordPadding,
							 p.y + wordWidth + wordPadding);
	} else {
		// No rotation
		p.x = random(padding, width - padding) - (wordWidth / 2.0);
		p.y = random(padding, height - padding) - (wordHeight / 2.0);
		return new Rectangle(p.x - wordPadding,
							 p.x + wordWidth + wordPadding,
							 p.y + ascent - wordPadding,
							 p.y + ascent + wordHeight - descent + wordPadding);
	}
}

Rectangle moveWordRect(wordRect){
	Point mid = wordRect.getMiddlePoint();

	Point newMid = movePointOnSpiral(mid, 0.2);

	Point movement = newMid.subtract(mid);
	wordRect.move(movement);

	return wordRect;
}

Point movePointOnSpiral(Point p, float movementRadians){
	// Perform a spiral movement from center
	// using the archimedean spiral and polar coordinates
	// equation: radius = a + b * phi

	// Calculate radius from center
	float radius = sqrt(sq(p.x - width/2.0) + sq(p.y - height/2.0));

	// Set a fixed distance between successive turns
	float spiralWidth = 15.0;

	// Determine current angle on spiral
	float phi = radius / spiralWidth * 2.0 * PI;

	// Increase that angle and calculate new radius
	phi += movementRadians;
	radius = (spiralWidth * phi) / (2.0 * PI);

	return polarToCartesian(radius, phi);
}

void render(word, wordRect, rotation){
	fill(random(80, 255),
		 random(80, 255),
		 random(80, 255));

	textAlign(CENTER,CENTER);
	// Calculate mid of rect
	Point mid = wordRect.getMiddlePoint();

	if (rotation != 0){
		pushMatrix();
		translate(mid.x, mid.y);
		rotate(rotation);
		text(word[0].toUpperCase(), 0, 0);
		popMatrix();
	}
	else{
		text(word[0].toUpperCase(), mid.x, mid.y);
	}

	// fill(255, 50);
	// rect(wordRect.x1,
	// 	wordRect.y1,
	// 	wordRect.x2 - wordRect.x1,
	// 	wordRect.y2 - wordRect.y1);
}

class Point {
	float x, y;

	Point(ix, iy){
		x = ix;
		y = iy;
	}

	Point subtract(Point p){
		return new Point(x - p.x, y - p.y);
	}

	Point add(Point p){
		return new Point(x + p.x, y + p.y);
	}
}

class Rectangle {
	float x1, x2, y1, y2;

	Rectangle(ix1, ix2, iy1, iy2){
		x1 = ix1;
		x2 = ix2;
		y1 = iy1;
		y2 = iy2;
	}

	Point getMiddlePoint(){
		return calculateMid(new Point(x1, y1), new Point(x2, y2));
	}

	void move(Point p){
		x1 += p.x;
		x2 += p.x;
		y1 += p.y;
		y2 += p.y;
	}
}

Point calculateMid(Point p1, Point p2){
	return new Point(
		(p1.x + p2.x) / 2.0,
		(p1.y + p2.y) / 2.0
	);
}

Point polarToCartesian(float radius, float phi){
	return new Point(
		radius * cos(phi) + width/2.0,
		radius * sin(phi) + height/2.0
	);
}
