<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <title>TRACER - 타임라인</title>
    
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
<script src="/gantt/codebase/dhtmlxgantt.js?v=8.0.9"></script>
<link rel="stylesheet" href="/gantt/codebase/dhtmlxgantt.css?v=8.0.9">
<style>
		html, body {
			padding: 0px;
			margin: 0px;
			height: 100%;
		}
		div#gantt_here{
			position:absolute;
			top:15%;
		}
		.highlight-parent {
            background-color: #4AE087; 
            border-color: #6EBFE6;
        }
        .highlight {
        	background-color: ;
        	border-color: ;
        }
	</style>
<script type="text/javascript">
$(document).ready(function(){
if(auth != 'admin')
	$('#prjList').hide()
var opts
console.log(pid)
if(pid != "")
	$("option[value='"+pid+"']").prop("selected", true)
$('#prjList').change(function() {
	var selectedVal = $(this).val();
	if(selectedVal == "")
		$('#gantt_here').hide()
	else{
		$('#gantt_here').show()
		pid = selectedVal
		timelineFunc('1', pid)
	}
})
if(auth == "member")
	gantt.config.readonly = true
	
	gantt.locale.labels.icon_save = "저장";
	gantt.locale.labels.icon_cancel = "취소";
	gantt.locale.labels.icon_delete= "삭제";
	gantt.i18n.setLocale({
		
		labels: {
			section_User: "담당자",
			section_description: "일정/업무 내용",
			section_time: "기간",
		}
	})
	gantt.config.date_format = "%Y-%m-%d";
	gantt.config.show_empty_state = true;
	gantt.config.start_date = new Date(2024, 06, 01);
	gantt.config.end_date = new Date(2026, 08, 01);
	gantt.config.columns = [
        { name: "text", label: "일정/업무", width: "300px", tree: true },
        { name: "start_date", label: "시작일", align: "center" },
        { name: "duration", label: "기간", align: "center" },
        { name: "users", label: "담당자", align: "center" },
        { name: "add", label: "+", width: 30, template: function(task) {
            return "<button class='gantt_add_task'>+</button>";
        }}
    ];
	 gantt.templates.task_class = function(start, end, task){
         if(task.parent == 0){
             return "highlight-parent";
         }
         return "highlight";
     };

	gantt.attachEvent("onAfterTaskAdd", function(id, task) {
        console.log("Task added:", id, task);
		if(task.$level==0){
			gantt.deleteTask(id)
			ganttAjaxSchedule("insSchByGantt" ,task, function(){
				timelineFunc('1', pid)
			}, pid)
        }else{
        	gantt.deleteTask(id)
        	ganttAjaxTask("insTaskByGantt" ,task, function(){
				timelineFunc('1', pid)
			}, pid)
        }
        return true; 
    });
    gantt.attachEvent("onAfterTaskUpdate", function(id, task) {
        console.log("Task update:", id, task);
        if(task.$level==0){
        	ganttAjaxSchedule("uptSchByGantt" ,task, function(){
				timelineFunc(task, pid)
			}, pid)
        }else{
        	ganttAjaxSchedule("uptTaskByGantt" ,task, function(){
				timelineFunc(task, pid)
			}, pid)
        }
        return true; 
    });
    
    gantt.attachEvent("onAfterTaskDelete", function(id, task) {
        console.log("Task delete:", id, task);
		if(task.$level==0){
			ganttAjaxSchedule("delSchByGantt" ,task, function(){
				timelineFunc('1', pid)
			}, pid)
        }else{
        	ganttAjaxSchedule("delTaskByGantt" ,task, function(){
				timelineFunc('1', pid)
			}, pid)	
        }
        return true; 
    });
    
    
    gantt.attachEvent("onBeforeTaskAdd", function(id, task) {
    	var parentCount = countParentTasks(id);
    	if(parentCount>1){
			alert('하위 파일을 더 이상 만들 수 없습니다.')
			gantt.deleteTask(id)
			return false;
    	}
        return true; 
    });
    // gantt crud 및 렌더링
	$.ajax({
        url: 'getUsers',
        type: 'POST',
        dataType: 'json',
        success: function(n) {
            // data는 List<String> 형식의 사용자 목록입니다
            // 간트 차트 설정
            gantt.config.lightbox.sections = [
                { name: "description", height: 38, map_to: "text", type: "textarea", focus: true },
                { name: "User", height: 22, map_to: "users", type: "select", 
				options: 
					n.map(function(username) { return { key: username, label: username }; }) },
                { name: "time", height: 72, type: "duration", map_to: "auto" }
            ];
            timelineFunc('1', pid)
        },
        error: function(err) {
            console.error("Failed to load users", err);
        }
    });
});
	
	
	function timelineFunc(task, pid){
		$.ajax({
			data: {pid: pid},
			url: 'timeline',
			type: 'POST',
			dataType: 'json',
			success: function(data){
				
				console.log("Received data:", data)
				gantt.clearAll()
				gantt.init("gantt_here")
				gantt.parse(data, "json")
				gantt.sort("start_date", false)
				if(task != '1')
					gantt.showTask(task.id)
			},
			error: function(err){
				console.log(err)
			}
		})
	}
	function countParentTasks(taskId) {
        var count = 0;
        var task = gantt.getTask(taskId);

        while (task.parent!=0) {
            count++;
            task = gantt.getTask(task.parent);
        }

        return count;
    }// insSchByGantt, insTaskByGantt
	function ganttAjaxSchedule(url, sel, callback, pid){
		$.ajax({
			data: sel,
			url: 'getEmail',
			type: 'POST',
			success: function(data){
				sel.start_date = new Date(sel.start_date).toISOString()
				sel.end_date = new Date(sel.end_date).toISOString()
				sel.email = data
				sel.pid = pid 
				$.ajax({
					data: sel,
					url: url,
					type: 'POST',
					dataType: 'text',
					success: function(data){
						if (callback) callback()
					},
					error: function(err){
						console.log(err)
					}
				})  
			},
			error: function(err){
				console.log(err)
			}
		})
		
	}
	function ganttAjaxTask(url, sel, callback){
		sel.start_date = sel.start_date.toISOString()
		sel.end_date = sel.end_date.toISOString()
		$.ajax({
			data: sel,
			url: url,
			type: 'POST',
			dataType: 'text',
			success: function(data){
				if (callback) callback()
			},
			error: function(err){
				console.log(err)
			}
		})
	}
	

</script>
</head> 

<body class="app">   	
<jsp:include page="/headerSidebar.jsp"/> 
    <div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
			    
			    <div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <span class="h1 app-page-title mb-0">타임라인</span>
			            <label class="ms-3">
			            <select name="prjOpts" id="prjList" class="form-select">
			            	<option value="">프로젝트 선택</option>
			            	<c:forEach items="${prjs}" var="prj">
			            		<option value="${prj.pid }">${prj.title }</option>
			            	</c:forEach>
			            </select></label>
				    </div>
				    
			    </div><!--//row-->
			   <br><br><br>
			    
		<div id="gantt_here" style='width:960px; height:700px;'></div>
	<script>
		
	</script>  
				
				
				
	    </div><!--//app-content-->
	    
	   
	    
    </div><!--//app-wrapper-->    					

 
    <!-- Javascript -->          
    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>  
    
    
    <!-- Page Specific JS -->
    <script src="assets/js/app.js"></script> 
</body>
</html> 

