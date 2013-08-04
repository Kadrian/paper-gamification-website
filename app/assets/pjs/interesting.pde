void setup(){
	size(300, 200);
	noLoop();	
	background(0);
	textAlign(LEFT);

}

void update(stats){
	// TODO: Do somethign with stats
	interestingWords = ["super-magnificent", "nice", "shiat", "Hello", "super-magnificent", "nice", "yoyo"];

	// RESET
	background(0);
	
	// SETUP
	x_off = 30;
	y_off = 40;
	from = 0;
	to = 200;
	for (int i = 0; i < interestingWords.length; i++){
		// Calc color
		fill(200);

		textFont(createFont("Arial",20,true));       
		y = float(height-y_off) / float(interestingWords.length);
		text(interestingWords[i].toUpperCase(), x_off, y_off + i * y);
	}
}