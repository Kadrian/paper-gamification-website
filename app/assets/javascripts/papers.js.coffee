# Sketches: sketch id + boolean if the sketch has loaded yet
sketches = {
	"words": 0, 
	"average": 0, 
	"distinct": 0, 
	"oxford": 0,
	"fancy": 0,
	"awl": 0,
	"awl-details": 0
}

totalWordsLevels = [50, 100, 200, 300, 500, 1000, 2000, 3000, 5000];
totalWordsIdentifier = "num_words";

distinctLevels = [10, 50, 100, 150, 200, 300, 400, 800, 1000];
distinctIdentifier = "different_words";


@updateSketches = (id) ->
	$.ajax id.toString(),
		type: 'GET'
		dataType: 'json'
		error: (jqXHR, textStatus, errorThrown) ->
			console.log "WARNING: Couldn't get current stats"
		success: (data, textStatus, jqXHR) ->
			console.log "SUCCESS: Got current stats, updating sketches..."

			for sketch of sketches
				updateSketch(sketch, data)


@updateSketch = (sketch, data) ->
	# Sketches aren't loaded when document is ready
	# --> wait for them to load, since Processing.js provides no callback
	timer = 0
	timeout = 2000
	clearInterval(mem)
	mem = setInterval ->
		instance = Processing.getInstanceById(sketch);
		if instance
			if not sketches[sketch]
				# Load this sketch for the first time 
				initSketch(sketch, instance)
			instance.update($.parseJSON(data["stats"]));
			clearInterval(mem);
		else
			timer += 10
			if timer > timeout
				console.log("WARNING: Failed to load sketch");
				clearInterval(mem);
	, 10


@initSketch = (sketch, instance) ->
	switch sketch
		when "words"
			instance.setIdentifier(totalWordsIdentifier);
			instance.setLevels(totalWordsLevels);
		when "distinct"
			instance.setIdentifier(distinctIdentifier);
			instance.setLevels(distinctLevels);
		else # Do nothing

	sketches[sketch] = 1


$ ->
	if $('.visualization').length > 0 # See if we're on a paper_show page
		paper_id = $('#paper_id').html()
		updateSketches(paper_id)

		setInterval ->
			updateSketches(paper_id)
		, 5000
