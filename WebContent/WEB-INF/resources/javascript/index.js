var config, speed_data, bat_speed;
function processWaitingButtonSpinner(whatToProcess) 
{
	switch (whatToProcess) {
	case 'START_WAIT_TIMER': 
		$('.spinner-border').show();
		$(':button').prop('disabled', true);
		break;
	case 'END_WAIT_TIMER': 
		$('.spinner-border').hide();
		$(':button').prop('disabled', false);
		break;
	}
}
function afterFormLoad(whatToProcess) {
	switch(whatToProcess) {
	case 'SPEED':
		setInterval(function () {
			processCricketProcedures('SPEED');
			processCricketProcedures('BAT_SPEED');
			processMatchTime();
		}, 1000);
		break;
	}
}
function processMatchTime() {
	var today = new Date();
	document.getElementById('match_time_hdr').innerHTML = 'Clock ' 
		+ today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
}
function processUserSelection(whichInput)
{	
	switch ($(whichInput).attr('name')) {
	case 'initialise_form_btn': 
		if(!document.getElementById('speed_directory_path').value) {
			alert('Source speed directory path cannot be blank');
			return false;
		} else if(!document.getElementById('speed_destination_file_path').value) {
			alert('Destination speed file path cannot be blank');
			return false;
		}
		processWaitingButtonSpinner('START_WAIT_TIMER');
		uploadFormDataToSessionObjects('INITIALISE');
		break;
	}
	
}
function populateFormObject(whatToProcess) {
	
	switch (whatToProcess){
	case 'SPEED':
		if(speed_data) {
			document.getElementById('speed_value').innerHTML = 'Speed: ' + speed_data.speedValue;
		} else {
			document.getElementById('speed_value').innerHTML = 'NO SPEED FOUND';
		}
		break;
	case 'BAT_SPEED':
		if(bat_speed) {
			document.getElementById('bat_speed_value').innerHTML = 'Bat Speed: ' + bat_speed.batSpeed;
		} else {
			document.getElementById('bat_speed_value').innerHTML = 'NO BAT SPEED FOUND';
		}
		break;
	}
	
}
function uploadFormDataToSessionObjects(whatToProcess)
{
	var formData = new FormData();
	var url_path;

	switch(whatToProcess.toUpperCase()) {
	case 'INITIALISE':
		formData.append($('#select_broadcaster').attr('id'),$('#select_broadcaster').val());  
		formData.append($('#speed_directory_path').attr('id'),$('#speed_directory_path').val());  
		formData.append($('#speed_destination_file_path').attr('id'),$('#speed_destination_file_path').val());  
		formData.append($('#select_secondary_broadcaster').attr('id'),$('#select_secondary_broadcaster').val());  
		formData.append($('#bat_speed_source_file_path').attr('id'),$('#bat_speed_source_file_path').val());  
		formData.append($('#bat_speed_destination_file_path').attr('id'),$('#bat_speed_destination_file_path').val());  
		break;
	}

	switch(whatToProcess.toUpperCase()) {
	case 'INITIALISE':
		url_path = 'upload_initialise_data';
		break;
	}
	
	$.ajax({    
		headers: {'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')},
        url : url_path,     
        data : formData,
        cache: false,
        contentType: false,
        processData: false,
        type: 'POST',     
        success : function(data) {

        	switch(whatToProcess.toUpperCase()) {
			case 'INITIALISE':
				config = data;
	    		document.initialise_form.method = 'post';
    	    	document.initialise_form.action = 'output';
    	       	document.initialise_form.submit();			
        		break;
        	}
        	
        },    
        error : function(e) {    
       	 	console.log('Error occured in uploadFormDataToSessionObjects with error description = ' + e);     
        }    
    });		
}
function processCricketProcedures(whatToProcess)
{
	var value_to_process; 

	switch (whatToProcess) {
	case 'BAT_SPEED':
		if(document.getElementById('configuration_secondary_source_path').value) {
		} else {
    		processWaitingButtonSpinner('END_WAIT_TIMER');
			return false;
		}
		break;
	}
	
	$.ajax({    
        type : 'Get',     
        url : 'processCricketProcedures.html',     
        data : 'whatToProcess=' + whatToProcess + '&valueToProcess=' + value_to_process, 
        dataType : 'json',
        success : function(data) {
			switch (whatToProcess) {
			case 'SPEED':
				if(data) {
					speed_data = data;
					populateFormObject(whatToProcess);
				}
				break;
			case 'BAT_SPEED':
				if(data) {
					bat_speed = data;
					populateFormObject(whatToProcess);
				}
				break;
			}
    		processWaitingButtonSpinner('END_WAIT_TIMER');
	    },    
	    error : function(e) {    
	  	 	console.log('Error occured in ' + whatToProcess + ' with error description = ' + e);     
	    }    
	});
}
