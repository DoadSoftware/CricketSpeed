<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
  <sec:csrfMetaTags/>
  <meta charset="utf-8" name="viewport" content="width=device-width, initial-scale=1">
  <title>Speed</title>

  <script type="text/javascript" src="<c:url value="/webjars/jquery/3.6.4/jquery.min.js"/>"></script>
  <script type="text/javascript" src="<c:url value="/webjars/bootstrap/5.2.3/js/bootstrap.min.js"/>"></script>
  <script type="text/javascript" src="<c:url value="/resources/javascript/index.js"/>"></script>
  
  <link rel="stylesheet" href="<c:url value="/webjars/bootstrap/5.2.3/css/bootstrap.min.css"/>"/>  
  <link href="<c:url value="/webjars/font-awesome/5.9.0/css/all.css"/>" rel="stylesheet">

</head>
<body onload="afterFormLoad('SPEED')">
<form:form name="cricket_speed_form" autocomplete="off" action="match" method="POST" enctype="multipart/form-data">
<div class="content py-5" style="background-color: #EAE8FF; color: #2E008B">
  <div class="container">
	<div class="row">
	 <div class="col-md-8 offset-md-2">
       <span class="anchor"></span>
         <div class="card card-outline-secondary">
           <div class="card-header">
			  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				<div class="row">
				  <div class="form-group row row-bottom-margin ml-2" style="margin-bottom:5px;">
				    <label id="match_time_hdr" class="col-sm-3 col-form-label text-left">Clock </label>
				    <label id="speed_value" class="col-sm-3 col-form-label text-left">Speed: </label>
				    <label id="bat_speed_value" class="col-sm-3 col-form-label text-left">Bat Speed: </label>
	              	</div>
				  </div>
				</div>
	          </div>
           </div>
         </div>
       </div>
    </div>
  </div>
  <input type="hidden" id="configuration_secondary_source_path" name="configuration_secondary_source_path"
  		value="${session_configuration.secondaryFilename}"></input>
</form:form>
</body>
</html>