# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@updateSketches = (id) ->
	sketch_ids = ["words", "average", "distinct", "oxford", "fancy", "awl", "awl-details"]

	$.ajax id.toString(),
		type: 'GET'
		dataType: 'json'
		error: (jqXHR, textStatus, errorThrown) ->
			console.log "WARNING: Couldn't get current stats"
		success: (data, textStatus, jqXHR) ->
			console.log "SUCCESS: Got current stats, updating sketches..."

			for sketch in sketch_ids
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
			instance.update($.parseJSON(data["stats"]));
			clearInterval(mem);
		else
			timer += 10
			if timer > timeout
				console.log("WARNING: Failed to load sketch");
				clearInterval(mem);
	, 10


$ ->
	if $('.visualization').length > 0 # See if we're on a paper_show page
		paper_id = $('#paper_id').html()
		updateSketches(paper_id)

		setInterval ->
			updateSketches(paper_id)
		, 5000
