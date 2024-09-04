<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title> TRACER - 대시보드 </title>
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
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<jsp:include page="/headerSidebar.jsp"/>
<div class="app-wrapper">
    <div class="app-content pt-3 p-md-3 p-lg-4">
        <div class="container-xl">
            <br><br>
            <h1 class="app-page-title">대시보드</h1>
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
                        <a class="app-card-link-mask" href="#"></a>
                    </div><!--//app-card-->
                </div><!--//col-->
                <div class="col-6 col-lg-3">
                    <div class="app-card app-card-stat shadow-sm h-100">
                        <div class="app-card-body p-3 p-lg-4">
                            <h4 class="stats-type mb-1">이번 주 할 일</h4>
                            <div class="stats-figure">${thisWeekDo } 개</div>
                        </div><!--//app-card-body-->
                        <a class="app-card-link-mask" href="#"></a>
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
                        <a class="app-card-link-mask" href="#"></a>
                    </div><!--//app-card-->
                </div><!--//col-->
                <div class="col-6 col-lg-3">
                    <div class="app-card app-card-stat shadow-sm h-100">
                        <div class="app-card-body p-3 p-lg-4">
                            <h4 class="stats-type mb-1">프로젝트 진행 중</h4>
                            <div class="stats-figure">${countPro }</div>
                        </div><!--//app-card-body-->
                        <a class="app-card-link-mask" href="#"></a>
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
                                        <a href="#">전체 프로젝트 확인하기</a>
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
                        </div><!--//app-card-body-->
                    </div><!--//app-card-->
                </div><!--//col-->
                <div class="col-12 col-lg-6">
                    <div class="app-card app-card-chart h-100 shadow-sm">
                        <div class="app-card-header p-3 border-0">
                            <div class="left-section">
                                <h4 class="app-card-title">자산 현황</h4>
                                <select class="form-select form-select-sm ms-3 d-inline-flex w-auto" id="projectSelect">
                                    <c:forEach var="project" items="${projectList}">
                                        <option value="${project.pid}">${project.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="card-header-action">
                                <a href="charts.html">자세히 보기</a>
                            </div><!--//card-header-actions-->
                        </div><!--//app-card-header-->
                        <div class="app-card-body p-3 p-lg-4">
                            <div class="chart-container">
                                <canvas id="budgetDonutChart"></canvas>
                            </div>
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

<!-- Javascript -->
<script src="assets/plugins/popper.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<!-- Charts JS -->
<script src="assets/plugins/chart.js/chart.min.js"></script>
<!-- Page Specific JS -->
<script src="assets/js/app.js"></script>
<script>
    $(document).ready(function() {
        function updateChart(pid) {
            $.ajax({
                url: '/getBudget',
                type: 'GET',
                data: { pid: pid },
                success: function(data) {
                    console.log(data);
                    budgetDonutChart.data.datasets[0].data = 
                    	[data.assigned_budget, data.used_budget];
                    budgetDonutChart.update();
                },
                error: function(xhr, status, error) {
                    console.error('Error: ' + error);
                },
                dataType: 'json'
            });
        }

        var ctx = document.getElementById('budgetDonutChart').getContext('2d');
        var budgetDonutChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['남은 예산', '사용 예산'],
                datasets: [{
                    data: [0, 0], // 초기값으로 비워둠
                    backgroundColor: ['#36a2eb', '#ff6384'] // 남은 예산: 파란색, 사용 예산: 빨간색
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    position: 'top'
                },
                animation: {
                    animateScale: true,
                    animateRotate: true
                },
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                            var label = data.labels[tooltipItem.index];
                            var value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                            return label + ': ' + value.toLocaleString() + ' 원';
                        }
                    }
                }
            }
        });

        $('#projectSelect').change(function() {
            var selectedPid = $(this).val();
            updateChart(selectedPid);
        });

        // 초기 선택된 프로젝트에 대한 차트 업데이트
        var initialPid = $('#projectSelect').val();
        if (initialPid) {
            updateChart(initialPid);
        }

        // Tooltip 초기화
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
</body>
</html>