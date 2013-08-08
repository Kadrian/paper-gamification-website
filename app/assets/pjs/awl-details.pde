void setup(){
	size(900, 700);
	noLoop();	
	background(0);
	colorMode(HSB,360,100,100,100);
	strokeCap(SQUARE);
}

void update(stats){
	background(0);
	// category_hits = {"word1": 5, "word2": 10, "abcdedaweff": 4, "hongodongo": 1, "woraefawf": 5, "wo12": 5, "wowfeoi": 5, "woeee": 5, "woeieieieie": 5, "word555": 10, "abcdedawyo": 4, "hongoawefpiaef": 1, "word5": 10, "abcde1": 4, "hongod": 1, "word889": 10, "acdedaweff": 4, "hongodo": 1, "word111": 10, "abcedawef": 4, "hongodon": 1, "word2000": 10, "abcdeeff": 4, "hongodong": 1 };
	category_hits = stats["awl_coverage"]["category_hits"];

	setup_lines();
	setup_words();
}

void setup_lines(){
	strokeWeight(2);
	stroke(360,0,100);
	var inset = 5;
	var mid_gap = 170;
	var h = 80;
	// Top horizontal lines
	line(inset, inset, width/2 - mid_gap, inset);
	line(width/2 + mid_gap, inset, width-inset, inset);
	// Top vertical lines
	line(inset, inset, inset, h);
	line(width-inset, inset, width-inset, h);
	// Bottom horizontal lines
	line(inset, height-inset, width/2 - mid_gap, height-inset);
	line(width/2 + mid_gap, height-inset, width-inset, height-inset);
	// Bottom vertical lines
	line(inset, height-inset-h, inset, height-inset);
	line(width-inset, height-inset-h, width-inset, height-inset);
}

void setup_words(){
	var total_categories = 570;
	var per_column = total_categories / 10;
	var inset = 20;
	var y_step = (height - inset) / per_column;
	var x_step = (width - inset) / 10;

	textFont(createFont("Arial", 12, true));       
	int index = 0;

	// Determine max hits to map color later
	max_val = 0;
	for (key in category_hits){
		if (category_hits[key] > max_val)
			max_val = category_hits[key];
	}

	for (key in category_hits){
		int x = floor(index / per_column);
		int y = index % per_column;
		// if (true){
		if (category_hits[key] > 0){
			fill(360, 0, map(category_hits[key], 0, max_val, 50, 100), 100);
			text(key, inset + x * x_step , inset + y * y_step);
		}
		index++;
	}
}