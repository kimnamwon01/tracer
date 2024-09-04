<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title> TRACER - 자원 관리 </title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="favicon.ico">
    <script defer src="assets/plugins/fontawesome/js/all.min.js"></script>
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .iframe-container {
            width: 100%;
            height: 600px; /* 필요한 높이 설정 */
            border: none;
        }
        .card-header-action {
            display: flex;
            justify-content: center; /* 버튼 중앙 정렬 */
            gap: 10px; /* 버튼 간격 추가 */
            margin-top: 10px; /* 위쪽 간격 */
        }
        .app-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
<jsp:include page="/headerSidebar.jsp"/>
<div class="app-wrapper">
    <div class="app-content pt-3 p-md-3 p-lg-4">
        <div class="container-xl">
            <br><br>
            <h1 class="app-page-title">자원 관리</h1>
            <nav id="orders-table-tab" class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
                <a class="flex-sm-fill text-sm-center nav-link active" id="budget-management-tab" data-bs-toggle="tab" href="#budget-management" role="tab" aria-controls="budget-management" aria-selected="true">예산 관리</a>
                <a class="flex-sm-fill text-sm-center nav-link" id="asset-management-tab" data-bs-toggle="tab" href="#asset-management" role="tab" aria-controls="asset-management" aria-selected="false">자산 관리</a>
            </nav>
            <div class="tab-content" id="orders-table-tab-content">
                <!-- 예산 관리 탭 -->
                <div class="tab-pane fade show active" id="budget-management" role="tabpanel" aria-labelledby="budget-management-tab">
                    <div id="budget-management-section">
                        <!-- 예산 관리 내용 -->
                        <div class="app-card app-card-chart h-100 shadow-sm">
                            <div class="app-card-header p-3 border-0">
                                <div class="d-flex justify-content-between align-items-center">
                                    <h4 class="app-card-title">예산 현황</h4>
                                    <select class="form-select form-select-sm ms-3 d-inline-flex w-auto" id="projectSelect">
                                        <c:forEach var="project" items="${projectList}">
                                            <option value="${project.pid}">${project.title}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="card-header-action d-flex justify-content-end mt-2">
                                    <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#addBudgetModal">예산 추가</button>
                                    <button class="btn btn-danger me-2" data-bs-toggle="modal" data-bs-target="#reduceBudgetModal">예산 삭감</button>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#assignBudgetModal">새 프로젝트 예산 부여</button>
                                </div>
                            </div>
                            <div class="app-card-body p-3 p-lg-4">
                                <div class="text-center">
                                    <div class="row justify-content-center">
                                        <div class="col-lg-4">
                                            <h4>전체 예산</h4>
                                            <p id="total-budget">0 원</p>
                                        </div>
                                        <div class="col-lg-8">
                                            <div class="chart-container" style="position: relative; height:40vh; width:40vw; margin: 0 auto;">
                                                <canvas id="budgetDonutChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 자산 관리 탭 -->
                <div class="tab-pane fade" id="asset-management" role="tabpanel" aria-labelledby="asset-management-tab">
                    <div class="app-card app-card-orders-table shadow-sm mb-5">
                        <div class="app-card-body">
                            <div class="left-section mb-3">
                                <label for="assetProjectSelect" class="form-label">프로젝트 선택</label>
                                <select class="form-select" id="assetProjectSelect">
                                    <option value="">전체</option>
                                    <c:forEach var="project" items="${projectList}">
                                        <option value="${project.pid}">${project.title}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAssetModal">자산 추가</button>
                            <div class="table-responsive">
                                <table class="table app-table-hover mb-0 text-left">
                                    <thead>
                                        <tr>
                                            <th class="cell">자산 이름</th>
                                            <th class="cell">구매일/임대일</th>
                                            <th class="cell">만료일</th>
                                            <th class="cell">가격</th>
                                            <th class="cell">사용중인 프로젝트</th>
                                        </tr>
                                    </thead>
                                    <tbody id="asset-table-body">
                                        <c:forEach var="asset" items="${assetList}">
                                            <tr data-pid="${asset.pid}">
                                                <td class="cell">${asset.software_name}</td>
                                                <td class="cell"><fmt:formatDate value="${asset.license_purchase_date}" pattern="yyyy-MM-dd"/></td>
                                                <td class="cell"><fmt:formatDate value="${asset.license_expiry_date}" pattern="yyyy-MM-dd"/></td>
                                                <td class="cell software-price"><fmt:formatNumber value="${asset.software_price}" type="number" pattern="#,###"/> 원</td>
                                                <td class="cell">${asset.projectTitle}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="app-footer">
        <div class="container text-center py-3">
            <small class="copyright">Designed with by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
        </div>
    </footer>
</div>


<!-- 예산 추가 모달 -->
<div class="modal fade" id="addBudgetModal" tabindex="-1" aria-labelledby="addBudgetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBudgetModalLabel">예산 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addBudgetForm" method="post">
                    <div class="mb-3">
                        <label for="addBudgetProjectSelect" class="form-label">프로젝트 선택</label>
                        <select class="form-select" id="addBudgetProjectSelect" name="pid" required>
                            <c:forEach var="project" items="${projectList}">
                                <option value="${project.pid}">${project.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="addBudgetAmount" class="form-label">금액</label>
                        <input type="number" class="form-control" id="addBudgetAmount" name="amount" required>
                    </div>
                    <button type="submit" class="btn btn-primary">저장</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 예산 삭감 모달 -->
<div class="modal fade" id="reduceBudgetModal" tabindex="-1" aria-labelledby="reduceBudgetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="reduceBudgetModalLabel">예산 삭감</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="reduceBudgetForm" method="post">
                    <div class="mb-3">
                        <label for="reduceBudgetProjectSelect" class="form-label">프로젝트 선택</label>
                        <select class="form-select" id="reduceBudgetProjectSelect" name="pid" required>
                            <c:forEach var="project" items="${projectList}">
                                <option value="${project.pid}">${project.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="reduceBudgetAmount" class="form-label">금액</label>
                        <input type="number" class="form-control" id="reduceBudgetAmount" name="amount" required>
                    </div>
                    <button type="submit" class="btn btn-danger">삭감</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 새 프로젝트 예산 부여 모달 -->
<div class="modal fade newPrjMoney" id="assignBudgetModal" tabindex="-1" aria-labelledby="assignBudgetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="assignBudgetModalLabel">새 프로젝트 예산 부여</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="assignBudgetForm" method="post">
                    <div class="mb-3">
                        <label for="assignBudgetProjectSelect" class="form-label">프로젝트 선택</label>
                        <select class="form-select" id="assignBudgetProjectSelect" name="pid" required>
                            <c:forEach var="project" items="${projectsWithNoAssignedBudget}">
                                <option value="${project.pid}">${project.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="assignBudgetAmount" class="form-label">금액</label>
                        <input type="number" class="form-control" id="assignBudgetAmount" name="amount" required>
                    </div>
                    <button type="submit" class="btn btn-success">부여</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 자산 추가 모달 -->
<div class="modal fade" id="addAssetModal" tabindex="-1" aria-labelledby="addAssetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addAssetModalLabel">자산 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addAssetForm" method="post">
                    <div class="mb-3">
                        <label for="addAssetName" class="form-label">자산 이름</label>
                        <input type="text" class="form-control" id="addAssetName" name="software_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="addAssetType" class="form-label">자산 유형</label>
                        <select class="form-select" id="addAssetType" name="rtype" required>
                            <option value="EQUIPMENT">장비</option>
                            <option value="FEE">이용권</option>
                            <option value="LICENSE">라이센스</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="addAssetPurchaseDate" class="form-label">구매일/임대일</label>
                        <input type="date" class="form-control" id="addAssetPurchaseDate" name="license_purchase_date" required>
                    </div>
                    <div class="mb-3">
                        <label for="addAssetExpiryDate" class="form-label">만료일</label>
                        <input type="date" class="form-control" id="addAssetExpiryDate" name="license_expiry_date" required>
                    </div>
                    <div class="mb-3">
                        <label for="addAssetPrice" class="form-label">가격</label>
                        <input type="number" class="form-control" id="addAssetPrice" name="software_price" required>
                    </div>
                    <div class="mb-3">
                        <label for="addAssetProjectSelect" class="form-label">프로젝트 선택</label>
                        <select class="form-select" id="addAssetProjectSelect" name="pid" required>
                            <c:forEach var="project" items="${projectList}">
                                <option value="${project.pid}">${project.title}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">저장</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="assets/plugins/popper.min.js"></script>
<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/plugins/chart.js/chart.min.js"></script>
<script src="assets/js/app.js"></script>

<!-- JavaScript 코드 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 최대 금액을 설정합니다 (예: 21억).
    const MAX_AMOUNT = 2100000000; // 21억

    // 금액을 검증하는 함수
    function validateAmount(inputElement) {
        const value = parseInt(inputElement.value, 10);

        // 음수 금액이 입력되었는지 확인
        if (value < 0) {
            alert('금액은 음수가 될 수 없습니다.');
            inputElement.value = ''; // 입력을 초기화합니다.
            inputElement.focus();
            return false;
        }

        // 최대 금액 초과 여부 확인
        if (value > MAX_AMOUNT) {
            alert('금액은 ' + MAX_AMOUNT.toLocaleString() + ' 원 이하로 입력해주세요.');
            inputElement.value = ''; // 입력을 초기화합니다.
            inputElement.focus();
            return false;
        }

        return true;
    }

    // '새 프로젝트 예산 부여' 버튼 클릭 시 새 프로젝트가 있는지 확인
    document.querySelector('[data-bs-target="#assignBudgetModal"]').addEventListener('click', function(event) {
        const projectOptions = document.querySelectorAll('#assignBudgetProjectSelect option');
        if (projectOptions.length === 0) {
            alert('새 프로젝트가 없습니다. 새 프로젝트를 추가한 후 시도해주세요.');
            window.location.reload()
        }
    });

    // 예산 관련 폼에서 금액 입력 시 제한을 검증합니다.
    $('#addBudgetForm, #reduceBudgetForm, #assignBudgetForm').on('submit', function(event) {
        const amountInput = $(this).find('input[name="amount"]');
        if (!validateAmount(amountInput[0])) {
            event.preventDefault(); // 폼 제출을 막습니다.
        }
    });

    // 자산 추가 폼에서 가격 입력 시 제한을 검증합니다.
    $('#addAssetForm').on('submit', function(event) {
        const priceInput = $(this).find('input[name="software_price"]');
        if (!validateAmount(priceInput[0])) {
            event.preventDefault(); // 폼 제출을 막습니다.
        }
    });

    // 예산 관리 차트 초기화 함수
    function updateChart(pid) {
        $.ajax({
            url: '/getBudget',
            type: 'GET',
            data: { pid: pid },
            success: function(data) {
                var totalBudget = data.assigned_budget || 0;
                $('#total-budget').text(totalBudget.toLocaleString() + ' 원');
                budgetDonutChart.data.datasets[0].data = [totalBudget - data.used_budget, data.used_budget];
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
                data: [0, 0],
                backgroundColor: ['#36a2eb', '#ff6384']
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

    var initialPid = $('#projectSelect').val();
    if (initialPid) {
        updateChart(initialPid);
    }

    $('#addBudgetForm').on('submit', function(event) {
    	const amountInput = $(this).find('input[name="amount"]');
		if (!validateAmount(amountInput)) {
            event.preventDefault(); // 폼 제출을 막습니다.
        }else{
	        const formData = $(this).serialize();
	        $.post('/addBudget', formData, function(response) {
	            alert(response);
	            window.location.reload();
	        }).fail(function(xhr) {
	            
	        });
        }
    });

    $('#reduceBudgetForm').on('submit', function(event) {
    	const amountInput = $(this).find('input[name="amount"]');
    	if (!validateAmount(amountInput)) {
            event.preventDefault(); // 폼 제출을 막습니다.
        }else{
	        event.preventDefault();
	        const formData = $(this).serialize();
	        $.post('/reduceBudget', formData, function(response) {
	            alert(response);
	            window.location.reload();
	        }).fail(function(xhr) {
	            
	        });
        }
    });

    $('#assignBudgetForm').on('submit', function(event) {
    	const amountInput = $(this).find('input[name="amount"]')
    	if (!validateAmount(amountInput)) {
            event.preventDefault(); // 폼 제출을 막습니다.
        }else{
	        event.preventDefault();
	        const formData = $(this).serialize();
	        $.post('/assignBudget', formData, function(response) {
	            alert(response);
	            window.location.reload();
	        }).fail(function(xhr) {
	            alert('새 프로젝트 예산 부여 실패: ' + xhr.responseText);
	        });
        }
    });
    
    const assetProjectSelect = document.getElementById('assetProjectSelect');
    const assetTableBody = document.getElementById('asset-table-body');

    assetProjectSelect.addEventListener('change', function() {
        const selectedPid = this.value;
        const rows = assetTableBody.getElementsByTagName('tr');

        for (let row of rows) {
            if (selectedPid === "" || row.getAttribute('data-pid') === selectedPid) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    });

    $('#addAssetForm').on('submit', function(event) {
        event.preventDefault();
        const formData = new FormData(this);
        fetch('/addAsset', {
            method: 'POST',
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            alert(data);
            window.location.reload();
        })
        .catch(error => {
            alert('자산 추가 실패: ' + error.message);
        });
    });
});
</script>


</body>
</html>
