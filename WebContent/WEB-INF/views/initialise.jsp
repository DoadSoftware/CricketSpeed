<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
  <title>Initialise Screen</title>

  <script type="text/javascript" src="<c:url value="/webjars/jquery/3.6.4/jquery.min.js"/>"></script>
  <script type="text/javascript" src="<c:url value="/webjars/bootstrap/5.2.3/js/bootstrap.min.js"/>"></script>
  <script type="text/javascript" src="<c:url value="/resources/javascript/index.js"/>"></script>
  
  <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/5.2.3/css/bootstrap.min.css"/>"/>  
  <link href="<c:url value="/webjars/font-awesome/5.9.0/css/all.css"/>" rel="stylesheet">
		
</head>
<body onload="">
<form name="initialise_form" autocomplete="off" action="output" method="POST" enctype = "multipart/form-data">
<div class="content py-5" style="background-color: #EAE8FF; color: #2E008B">
  <div class="container">
	<div class="row">
	 <div class="col-md-8 offset-md-2">
       <span class="anchor"></span>
         <div class="card card-outline-secondary">
           <div class="card-header">
             <h3 class="mb-0">Initialise</h3>
           </div>
          <div class="card-body">
	          <div id="initialise_div">
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label for="select_broadcaster" class="col-sm-3 col-form-label text-left">Select Broadcaster </label>
				    <div class="col-sm-6 col-md-6">
				      <select id="select_broadcaster" name="select_broadcaster" class="browser-default custom-select custom-select-sm">
				      	<option value="hawkeye">Hawkeye</option>
				      	<option value="Kadamba">Kadamba</option>
				      	<option value="khelAI">Khel AI</option>
				      	<option value="Virtual_Eye">Virtual Eye</option>
				      </select>
				    </div>
				  </div>
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:0.8px;">
				    <label for="select_cricket_matches" class="col-sm-4 col-form-label text-left">Select Cricket Match </label>
				    <div class="col-sm-6 col-md-6">
				      <select id="select_cricket_matches" name="select_cricket_matches" 
				      		class="brower-default custom-select custom-select-sm">
							<c:forEach items = "${match_files}" var = "match">
					          	<option value="${match.name}">${match.name}</option>
							</c:forEach>
				      </select>
				    </div>
				  </div>				  
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label for="speed_directory_path" class="col-sm-3 col-form-label text-left">Speed Source Directory </label>
				    <div class="col-sm-6 col-md-6">
						<input type="text" id="speed_directory_path" name="speed_directory_path" 
	              			maxlength="500" class="form-control form-control-sm floatlabel"
	              			value="${session_configuration.primaryIpAddress}"></input>
	              	</div>
				  </div>
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label for="speed_destination_file_path" class="col-sm-3 col-form-label text-left">Speed Destination Filepath </label>
				    <div class="col-sm-6 col-md-6">
						<input type="text" id="speed_destination_file_path" name="speed_destination_file_path" 
	              			maxlength="500" class="form-control form-control-sm floatlabel"
	              			value="${session_configuration.filename}"></input>
	              	</div>
				  </div>
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label for="select_secondary_broadcaster" class="col-sm-3 col-form-label text-left">Select Bat Speed Broadcaster </label>
				    <div class="col-sm-6 col-md-6">
				      <select id="select_secondary_broadcaster" name="select_secondary_broadcaster" class="browser-default custom-select custom-select-sm">
				      <option value=" "></option>
				      	<option value="spektacom">Spektacom</option>
				      </select>
				    </div>
				  </div>
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label for="bat_speed_source_file_path" class="col-sm-3 col-form-label text-left">Bat Speed Source Filepath </label>
				    <div class="col-sm-6 col-md-6">
						<input type="text" id="bat_speed_source_file_path" name="bat_speed_source_file_path" 
	              			maxlength="500" class="form-control form-control-sm floatlabel"
	              			value="${session_configuration.secondaryIpAddress}"></input>
	              	</div>
				  </div>
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label for="bat_speed_destination_file_path" class="col-sm-3 col-form-label text-left">Bat Speed Destination Filepath </label>
				    <div class="col-sm-6 col-md-6">
						<input type="text" id="bat_speed_destination_file_path" name="bat_speed_destination_file_path" 
	              			maxlength="500" class="form-control form-control-sm floatlabel"
	              			value="${session_configuration.secondaryFilename}"></input>
	              	</div>
				  </div>
				    <button style="margin-top:5px;background-color:#2E008B;color:#FEFEFE;" class="btn btn-sm" type="button"
				  		name="initialise_form_btn" id="initialise_form_btn" onclick="processUserSelection(this)">Continue</button>				  
			  </div>
	       </div>
	    </div>
       </div>
    </div>
  </div>
</div>
</form>
</body>
</html>