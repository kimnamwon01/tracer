<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <title>TRACER - 참여 팀 정보</title>
    
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <meta name="description" content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
    <meta name="author" content="Xiaoying Riley at 3rd Wave Media">    
    <link rel="shortcut icon" href="favicon.ico"> 
    
    <!-- FontAwesome JS-->
    <script defer src="assets/plugins/fontawesome/js/all.min.js"></script>
    
    <!-- App CSS -->  
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">


 <script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("form").on("keypress", function(event) {
        if (event.key === "Enter") {
            event.preventDefault(); 
        }
    });

	$("#mainBtn").click(function(){
		location.href="index${user_info.auth == 'member' ? 'U' : 'M'}"
	})
	$.ajax({
		data: {tid: $('[name=tid]').val()},
		url: 'getParticipantsTeam',
		type: 'POST',
		success: function(data){
			$('#participantList').html('')
			data.forEach(function(item){
				$('#participantList').append('<button value="'+item.email+'" class="btn" type="button">'+item.nickname+'</button>')
			})
			
		}
	})
	
});

</script>
</head> 
<body class="app">   	
<input class="loading" type="hidden"/>
<jsp:include page="/headerSidebar.jsp"/> 
    <div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
			    
			    <div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <h1 class="app-page-title mb-0">팀 정보</h1>
				    </div>
				    <div class="col-auto">
					     <div class="page-utilities">
						    <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
							    <div class="col-auto">
								    
					                
							    </div><!--//col-->
						    </div><!--//row-->
					    </div><!--//table-utilities-->
				    </div><!--//col-auto-->
			    </div><!--//row-->
			   
			
			  
				
				
				<div class="container">
	<form id="teamFrm"> <!-- 등록시 controller호출.. -->
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">프로젝트 id</span>
		</div>
		<input name="pid" class="form-control" value="${selTeam.pid}" readonly />	
	</div>	
	<div class="input-group mb-3">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">팀 id</span>
		</div>
		<input name="tid" class="form-control" value="${selTeam.tid}" />	
	</div>	
	<div class="input-group mb-3">	
		<div class="input-group-prepend">
			<span class="input-group-text">팀명</span>
		</div>
		<input name="name" class="form-control" value="${selTeam.name }"/>
		
	</div>	
	<div class="input-group mb-3 participants">	
		<div class="input-group-prepend ">
			<span class="input-group-text  justify-content-center">참여자</span>
		</div>
		<div id="participantList">
		
		</div>
		
	</div>	
	<div style="text-align:right;">
			<input type="button" class="btn btn-secondary" value="메인화면으로" id="mainBtn"/>
			
	</div></form>	<!--  http://localhost:7080/springweb/emp.do?empno=1000 -->
	    </div><!--//app-content-->
	    
	    <footer class="app-footer">
		    <div class="container text-center py-3">
		         <!--/* This template is free as long as you keep the footer attribution link. If you'd like to use the template without the attribution link, you can buy the commercial license via our website: themes.3rdwavemedia.com Thank you for your support. :) */-->
            <small class="copyright">Designed with <span class="sr-only">love</span><i class="fas fa-heart" style="color: #fb866a;"></i> by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
		    </div>
	    </footer><!--//app-footer-->
	    
    </div><!--//app-wrapper-->    					
</div>
</div>    
    <!-- Javascript -->          
    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>  
    
    
    <!-- Page Specific JS -->
    <script src="assets/js/app.js"></script> 
</body>
</html> 

