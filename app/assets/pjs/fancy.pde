void setup(){
	size(300, 200);
	noLoop();	
	background(0);
}

void update(stats){
	num_hits = stats["fancy_coverage"]["num_hits"];
	total = stats["fancy_coverage"]["total"];

	// RESET
	background(0);

	// SETUP
	PFont f;
	f = createFont("Arial",40,true); 
	textFont(f);       
	fill(255);
	textAlign(CENTER);
	text(num_hits + " of " + total, width/2, 60);
}