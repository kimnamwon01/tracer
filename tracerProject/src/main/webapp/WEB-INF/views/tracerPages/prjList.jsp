<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <title>TRACER - 프로젝트 목록</title>
    
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
            event.preventDefault(); // Enter 키 입력 시 폼 제출을 막음
        }
    });
    // 프로젝트 검색 버튼 클릭 이벤트
    $(".prjSchBtn").click(function(){
        var pid = $(this).parent().attr('class');
        $.ajax({
            data: $("form.schPrj").serialize(),  // 데이터 객체로 전달
            url: 'prjList',
            type: 'POST',
            success: function(data){
            	$("tbody.prjList").empty();  // 기존 목록 지우기
				for(i=0;i<data.length;i++){
	                $("tbody.prjList").append('<tr class="' + data[i].pid + '">'
                            + '<td class="cell">' + data[i].pid + '</td>'
                            + '<td class="cell"><span class="truncate">' + data[i].title + '</span></td>'
                            + '<td class="cell">' + formatDate(data[i].start_date) + '</td>'
                            + '<td class="cell">' + formatDate(data[i].end_date) + '</td>'
                            + '<td class="cell"><a class="btn-sm app-btn-secondary prjDetail">세부내용/수정</a><a class="btn-sm app-btn-secondary prjDelBtn" href="#">삭제</a></td>'
                            + '</tr>')
				}
				$(".prjDelBtn").off('click').on('click', prjDel);
            },
            error: function(err){
                console.log(err);
            }
        });
    });
    $(document).on('click', '.prjDetail', function() {
        location.href = 'prjDetail?pid=' + $(this).closest('tr').attr('class');
    });
    // 프로젝트 삭제 함수 정의
    var prjDel = function() {
        var that = this; // `this`의 컨텍스트 저장
        if(confirm('정말 삭제하시겠습니까?')) {
            var pid = $(that).parent().parent().attr('class');
            console.log(pid)
            $.ajax({
                data: { pid: pid },  // 데이터 객체로 전달
                url: 'delPrj',
                type: 'POST',
                success: function(data) {
                    // 서버에서 JSON 형식으로 프로젝트 목록을 반환한다고 가정
                    $("tbody.prjList").empty();  // 기존 목록 지우기
                    for(i=0;i<data.length;i++) {
                    	$("tbody.prjList").append('<tr class="' + data[i].pid + '">'
                                + '<td class="cell">' + data[i].pid + '</td>'
                                + '<td class="cell"><span class="truncate">' + data[i].title + '</span></td>'
                                + '<td class="cell">' + formatDate(data[i].start_date) + '</td>'
                                + '<td class="cell">' + formatDate(data[i].end_date) + '</td>'
                                + '<td class="cell"><a class="btn-sm app-btn-secondary prjDetail">세부내용/수정</a><a class="btn-sm app-btn-secondary prjDelBtn" href="#">삭제</a></td>'
                                + '</tr>')
                        
                    };
					
                    // 동적으로 추가된 삭제 버튼에 클릭 이벤트 다시 등록
                    $(".prjDelBtn").off('click').on('click', prjDel);
                },
                error: function(err) {
                    console.log(err);
                }
            });
        }
    };

    // 초기 삭제 버튼에 클릭 이벤트 등록
    $(".prjDelBtn").click(prjDel);

    // 날짜 형식 변환 함수
    function formatDate(date) {
        var d = new Date(date);
        var month = '' + (d.getMonth() + 1);
        var day = '' + d.getDate();
        var year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [year, month, day].join('-');
    }
});

</script>
</head> 
<body class="app">   	
<jsp:include page="/headerSidebar.jsp"/> 
    <div class="app-wrapper">
	    
	    <div class="app-content pt-3 p-md-3 p-lg-4">
		    <div class="container-xl">
			    
			    <div class="row g-3 mb-4 align-items-center justify-content-between">
				    <div class="col-auto">
			            <h1 class="app-page-title mb-0">프로젝트 목록</h1>
				    </div>
				    <div class="col-auto">
					     <div class="page-utilities">
						    <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
							    <div class="col-auto">
								    <form class="schPrj table-search-form row gx-1 align-items-center">
					                    <div class="col-auto">
					                        <input type="text" id="search-orders" name="prjTitle" class="form-control search-orders" placeholder="프로젝트 명 입력">
					                    </div>
					                    <div class="col-auto">
					                        <button type="button" class="prjSchBtn btn app-btn-secondary">검색</button>
					                    </div>
					                </form>
					                
							    </div><!--//col-->
						    </div><!--//row-->
					    </div><!--//table-utilities-->
				    </div><!--//col-auto-->
			    </div><!--//row-->
			   
			    
			  
				
				
				<div class="tab-content" id="orders-table-tab-content">
			        <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
					    <div class="app-card app-card-orders-table shadow-sm mb-5">
						    <div class="app-card-body">
							    <div class="table-responsive">
							        <table class="table app-table-hover mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">프로젝트 id</th>
												<th class="cell">프로젝트명</th>
												<th class="cell">시작일</th>
												<th class="cell">종료일</th>
												<th class="cell"></th>
											</tr>
										</thead>
										<tbody class="prjList">
										<c:forEach items="${prjs }" var="prj">
											<tr class="${prj.pid }">
												<td class="cell">${prj.pid}</td>
												<td class="cell"><span class="truncate">${prj.title }</span></td>
												<td class="cell"><fmt:formatDate value="${prj.start_date}" pattern="yyyy-MM-dd"/></td>
												<td class="cell"><fmt:formatDate value="${prj.end_date}" pattern="yyyy-MM-dd"/></td>
												<td class="cell"><a class="btn-sm app-btn-secondary prjDetail">세부내용/수정</a><a class="btn-sm app-btn-secondary prjDelBtn">삭제</a></td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
						        </div><!--//table-responsive-->
						    </div><!--//app-card-body-->		
						</div><!--//app-card-->
			        </div><!--//tab-pane-->
		    </div><!--//container-fluid-->
	    </div><!--//app-content-->
	    
	    <footer class="app-footer">
		    <div class="container text-center py-3">
		         <!--/* This template is free as long as you keep the footer attribution link. If you'd like to use the template without the attribution link, you can buy the commercial license via our website: themes.3rdwavemedia.com Thank you for your support. :) */-->
            <small class="copyright">Designed with <span class="sr-only">love</span><i class="fas fa-heart" style="color: #fb866a;"></i> by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
		    </div>
	    </footer><!--//app-footer-->
	    
    </div><!--//app-wrapper-->    					

 
    <!-- Javascript -->          
    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>  
    
    
    <!-- Page Specific JS -->
    <script src="assets/js/app.js"></script> 
</body>
</html> 

