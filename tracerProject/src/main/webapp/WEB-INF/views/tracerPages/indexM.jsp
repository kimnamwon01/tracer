<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title> TRACER - 관리자 대시보드 </title>
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" contents="width=device-width, initial-scale=1.0">
    <meta name="description" content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
    <meta name="author" content="Xiaoying Riley at 3rd Wave Media">
    <link rel="shortcut icon" href="favicon.ico">
    <!-- FontAwesome JS-->
    <script defer src="assets/plugins/fontawesome/js/all.min.js"></script>
    <!-- App CSS -->
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .app-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .app-card-header .left-section {
            display: flex;
            align-items: center;
        }
        .app-card-header .left-section select {
            margin-left: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="/headerSidebar.jsp"/>
<div class="app-wrapper">
    <div class="app-content pt-3 p-md-3 p-lg-4">
        <div class="container-xl">
            <br><br>
            <h1 class="app-page-title">관리자 대시보드</h1>
            <div class="app-card alert alert-dismissible shadow-sm mb-4 border-left-decoration" role="alert">
                <div class="inner">
                    <div class="app-card-body p-3 p-lg-4">
                        <h3 class="mb-3">환영합니다. ${user_info.nickname }님.</h3>
                        <div class="row gx-5 gy-3">
                            <div class="col-12 col-lg-9">
                                <div>오늘도 즐거운 하루 되세요.</div>
                            </div><!--//col-->
                            <div class="col-12 col-lg-3"></div><!--//col-->
                        </div><!--//row-->
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div><!--//app-card-body-->
                </div><!--//inner-->
            </div><!--//app-card-->
            <div class="row g-4 mb-4">
                <div class="col-6 col-lg-3">
                    <div class="app-card app-card-stat shadow-sm h-100">
                        <div class="app-card-body p-3 p-lg-4">
                            <h4 class="stats-type mb-1">오늘 할 일</h4>
                            <div class="stats-figure">${todayDoCount } 개</div>
                        </div><!--//app-card-body-->
                        <a class="app-card-link-mask" href="newTask"></a>
                    </div><!--//app-card-->
                </div><!--//col-->
                <div class="col-6 col-lg-3">
                    <div class="app-card app-card-stat shadow-sm h-100">
                        <div class="app-card-body p-3 p-lg-4">
                            <h4 class="stats-type mb-1">이번 주 할 일</h4>
                            <div class="stats-figure">${thisWeekDo } 개</div>
                        </div><!--//app-card-body-->
                        <a class="app-card-link-mask" href="newTask"></a>
                    </div><!--//app-card-->
                </div><!--//col-->
                <div class="col-6 col-lg-3">
                    <div class="app-card app-card-stat shadow-sm h-100">
                        <div class="app-card-body p-3 p-lg-4">
                            <h4 class="stats-type mb-1">마감 기한</h4>
                            <div class="stats-figure">${dDay }</div>
                            <div class="stats-meta">
                                <fmt:formatDate value="${dueto}" pattern="yyyy-MM-dd"/>
                            </div>
                        </div><!--//app-card-body-->
                        <a class="app-card-link-mask" href="timeline"></a>
                    </div><!--//app-card-->
                </div><!--//col-->
                <div class="col-6 col-lg-3">
                    <div class="app-card app-card-stat shadow-sm h-100">
                        <div class="app-card-body p-3 p-lg-4">
                            <h4 class="stats-type mb-1">요청받은 결재 개수</h4>
                            <div class="stats-figure">${requestApprovalCount} 개</div>
                        </div><!--//app-card-body-->
                        <a class="app-card-link-mask" href="newApproval"></a>
                    </div><!--//app-card-->
                </div><!--//col-->
            </div><!--//row-->
            <div class="row g-4 mb-4">
                <div class="col-12 col-lg-6">
                    <div class="app-card app-card-progress-list h-100 shadow-sm">
                        <div class="app-card-header p-3">
                            <div class="row justify-content-between align-items-center">
                                <div class="col-auto">
                                    <h4 class="app-card-title">프로젝트 진행률</h4>
                                </div><!--//col-->
                                <div class="col-auto">
                                    <div class="card-header-action">
                                        <a href="#">진행 중인 프로젝트 확인하기</a>
                                    </div><!--//card-header-actions-->
                                </div><!--//col-->
                            </div><!--//row-->
                        </div><!--//app-card-header-->
                        <div class="app-card-body">
                            <c:forEach var="project" items="${projectProgressList}">
                                <div class="row align-items-center mb-2">
                                    <div class="col">
                                        <div class="title mb-1">${project.title}</div>
                                        <div class="progress">
                                            <div class="progress-bar bg-success" role="progressbar"
                                                style="width: ${project.progress}%;"
                                                aria-valuenow="${project.progress}" aria-valuemin="0"
                                                aria-valuemax="100" data-toggle="tooltip"
                                                title="${project.progress}% 
                                                (${project.completedTasks}/${project.totalTasks})">
                                            </div>
                                        </div>
                                    </div><!--//col-->
                                </div><!--//row-->
                            </c:forEach>
                            <h5>팀원별 진행률</h5>
                            <c:forEach var="userProgress" items="${teamProgressList}">
                                <div class="row align-items-center mb-2">
                                    <div class="col">
                                        <div class="title mb-1">${userProgress.nickname}</div>
                                        <div class="progress">
                                            <div class="progress-bar bg-info" role="progressbar"
                                                style="width: ${userProgress.progress}%;"
                                                aria-valuenow="${userProgress.progress}" aria-valuemin="0"
                                                aria-valuemax="100" data-toggle="tooltip"
                                                title="${userProgress.progress}%">
                                            </div>
                                        </div>
                                    </div><!--//col-->
                                </div><!--//row-->
                            </c:forEach>
                        </div><!--//app-card-body-->
                    </div><!--//app-card-->
                </div><!--//col-->
            </div><!--//row-->
        </div><!--//container-fluid-->
    </div><!--//app-content-->
    <footer class="app-footer">
        <div class="container text-center py-3">
            <small class="copyright">Designed with by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
        </div>
    </footer><!--//app-footer-->
</div><!--//app-wrapper-->
</body>
</html>
