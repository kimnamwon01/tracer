<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>TRACER - 작업 관리</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="assets/css/portal.css">
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<style>
.nav-tabs {
    margin-bottom: 15px;
}

.nav-tabs .nav-link {
    padding: 10px 20px;
}

#searchInput {
    width: 200px;
    margin-left: 10px;
}

.table th, .table td {
    padding: 15px;
    text-align: center;
    vertical-align: middle;
}

.cell {
    width: auto;
    white-space: nowrap;
}

.status-select {
    min-width: 100px;
}
.custom-tabs {
    margin-bottom: 15px;
    border-bottom: 2px solid #e0e0e0;
}

.custom-tabs .nav-link {
    color: #007bff;
    border: none;
    background-color: transparent;
    padding: 10px 20px;
    font-weight: 500;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.custom-tabs .nav-link.active {
    color: #ffffff;
    background-color: #007bff;
    border-radius: 5px;
}

.custom-tabs .nav-link:hover {
    color: #0056b3;
    background-color: #e9ecef;
    border-radius: 5px;
}
</style>
</head>

<body class="app">
	<jsp:include page="/headerSidebar.jsp" />
	<div class="app-wrapper">
		<div class="app-content pt-3 p-md-3 p-lg-4">
			<div class="container-xl">
				<div class="row g-3 mb-4 align-items-center justify-content-between">
    <div class="col-auto">
        <h1 class="app-page-title mb-0">작업 관리</h1>
    </div>
    <div class="col-auto">
        <ul class="nav nav-tabs custom-tabs">
    <li class="nav-item">
        <a class="nav-link active" href="#" id="allTab">전체</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" id="inProgressTab">진행 중</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" id="completedTab">완료</a>
    </li>
</ul>
    </div>
    <div class="col-auto">
        <input type="text" id="searchInput" class="form-control" placeholder="TKID 검색">
    </div>
</div>
				<!-- 작업 추가 버튼 -->
				<button type="button" class="btn btn-success" data-bs-toggle="modal"
					data-bs-target="#addTaskModal">작업 추가</button>

				<!-- 작업 추가 모달 -->
				<div class="modal fade" id="addTaskModal" tabindex="-1"
					aria-labelledby="addTaskModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="addTaskModalLabel">작업 추가</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<form action="/newTask/add" method="post">
									<div class="form-group">
										<label for="taskName">작업 제목</label> <input type="text"
											class="form-control" id="taskName" name="name" required>
									</div>
									<div class="form-group">
										<label for="taskDescription">설명</label>
										<textarea class="form-control" id="taskDescription"
											name="description" required></textarea>
									</div>
									<div class="form-group">
										<label for="taskStartDate">시작 날짜</label> <input type="date"
											class="form-control" id="taskStartDate" name="startDate"
											required>
									</div>
									<div class="form-group">
										<label for="taskEndDate">종료 날짜</label> <input type="date"
											class="form-control" id="taskEndDate" name="endDate">
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal">닫기</button>
										<button type="submit" class="btn btn-primary">추가하기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>

				<!-- 작업 리스트 -->
				<div class="app-card app-card-orders-table shadow-sm mb-5">
					<div class="app-card-body">
						<div class="table-responsive">
							<table class="table app-table-hover mb-0 text-left">
								<thead>
									<tr>
										<th class="cell">Task ID</th>
										<th class="cell">제목</th>
										<th class="cell">시작 날짜</th>
										<th class="cell">종료 날짜</th>
										<th class="cell">상태</th>
										<th class="cell">수정/삭제</th>
										<th class="cell">결재 요청</th>
										<th class="cell">피드백 확인</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="task" items="${tasks}">
										<tr>
											<td class="cell task-row" data-taskid="${task.tkid}">${task.tkid}</td>
											<td class="cell task-row" data-taskid="${task.tkid}">${task.name}</td>
											<td class="cell task-row" data-taskid="${task.tkid}"><fmt:formatDate
													value="${task.startDate}" pattern="MM월 dd일" /></td>
											<td class="cell task-row" data-taskid="${task.tkid}"><fmt:formatDate
													value="${task.endDate}" pattern="MM월 dd일" /></td>
											<td class="cell"><select
												class="form-control status-select"
												data-taskid="${task.tkid}">
													<option value="0" ${!task.endYn ? 'selected' : ''}>진행
														중</option>
													<option value="1" ${task.endYn ? 'selected' : ''}>완료</option>
											</select></td>
											<td class="cell">
												<!-- 수정 버튼 -->
												<button type="button" class="btn btn-sm btn-secondary"
													data-bs-toggle="modal"
													data-bs-target="#editTaskModal-${task.tkid}">수정</button> <!-- 삭제 버튼 -->
												<!-- 삭제 버튼 -->
												<form action="/newTask/delete" method="post"
													style="display: inline;" onsubmit="return confirmDelete();">
													<input type="hidden" name="tkid" value="${task.tkid}" />
													<button type="submit" class="btn btn-sm btn-danger">삭제</button>
												</form>
											</td>
											<td class="cell">
												<!-- 결재 요청 버튼 -->
												<button type="button" class="btn btn-sm btn-primary"
													data-bs-toggle="modal"
													data-bs-target="#requestApprovalModal-${task.tkid}">결재
													요청</button>
											</td>
											<td class="cell">
												<!-- 피드백 확인 버튼 -->
												<button type="button" class="btn btn-sm btn-info"
													data-bs-toggle="modal"
													data-bs-target="#feedbackModal-${task.tkid}">피드백
													확인</button>
											</td>
										</tr>

										<!-- 작업 수정 모달 -->
										<div class="modal fade" id="editTaskModal-${task.tkid}"
											tabindex="-1"
											aria-labelledby="editTaskModalLabel-${task.tkid}"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title"
															id="editTaskModalLabel-${task.tkid}">작업 수정</h5>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														<form action="/newTask/update" method="post">
															<input type="hidden" name="tkid" value="${task.tkid}" />

															<div class="form-group">
																<label for="name-${task.tkid}">제목</label> <input
																	type="text" class="form-control" id="name-${task.tkid}"
																	name="name" value="${task.name}" required>
															</div>

															<div class="form-group">
																<label for="description-${task.tkid}">설명</label>
																<textarea class="form-control"
																	id="description-${task.tkid}" name="description"
																	required>${task.description}</textarea>
															</div>

															<div class="form-group">
																<label for="startDate-${task.tkid}">시작 날짜</label> <input
																	type="date" class="form-control"
																	id="startDate-${task.tkid}" name="startDate"
																	value="${task.formattedStartDate}" required>
															</div>

															<div class="form-group">
																<label for="endDate-${task.tkid}">종료 날짜</label> <input
																	type="date" class="form-control"
																	id="endDate-${task.tkid}" name="endDate"
																	value="${task.formattedEndDate}">
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-bs-dismiss="modal">닫기</button>
																<button type="submit" class="btn btn-primary">수정하기</button>
															</div>
														</form>
													</div>
												</div>
											</div>
										</div>

										<!-- 결재 요청 모달 -->
										<div class="modal fade" id="requestApprovalModal-${task.tkid}"
											tabindex="-1"
											aria-labelledby="requestApprovalModalLabel-${task.tkid}"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title"
															id="requestApprovalModalLabel-${task.tkid}">결재 요청</h5>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														<form action="/newTask/requestApproval" method="post"
															enctype="multipart/form-data">
															<input type="hidden" name="tkid" value="${task.tkid}" />

															<div class="form-group">
																<label for="approvalEmail-${task.tkid}">작성자 이메일</label>
																<input type="text" class="form-control"
																	id="approvalEmail-${task.tkid}" name="approvalEmail"
																	value="${user_info.email}" readonly> <input
																	type="hidden" name="email" value="${user_info.email}">
															</div>

															<div class="form-group">
																<label for="approvalTitle-${task.tkid}">결재 제목</label> <input
																	type="text" class="form-control"
																	id="approvalTitle-${task.tkid}" name="approvalTitle"
																	required>
															</div>

															<div class="form-group">
																<label for="approvalDescription-${task.tkid}">설명</label>
																<textarea class="form-control"
																	id="approvalDescription-${task.tkid}"
																	name="approvalDescription" required></textarea>
															</div>

															<div class="form-group">
																<label for="approvalFile-${task.tkid}">파일 첨부</label> <input
																	type="file" class="form-control"
																	id="approvalFile-${task.tkid}" name="approvalFile">
															</div>

															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-bs-dismiss="modal">닫기</button>
																<button type="submit" class="btn btn-primary">결재
																	요청</button>
															</div>
														</form>
													</div>
												</div>
											</div>
										</div>

										<!-- 피드백 확인 모달 -->
										<div class="modal fade" id="feedbackModal-${task.tkid}"
											tabindex="-1"
											aria-labelledby="feedbackModalLabel-${task.tkid}"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title"
															id="feedbackModalLabel-${task.tkid}">피드백 확인</h5>
														<button type="button" class="btn-close"
															data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														<c:if test="${not empty task.approvals}">
															<%-- <h4>결재 제목: ${task.approvals[0].approvalTitle}</h4>
															<p>
																<strong>결재 설명:</strong>
																${task.approvals[0].approvalDescription}
															</p>
															<p> --%>
															<strong>피드백:</strong> ${task.approvals[0].feedback}
															</p>
															<p>
																<strong>첨부 파일:</strong> <a
																	href="/downloadFile?apid=${task.approvals[0].apid}">다운로드</a>
															</p>

															<form action="/newTask/submitFeedback" method="post">
																<input type="hidden" name="apid"
																	value="${task.approvals[0].apid}" />
																<div class="form-group">
																	<label for="userFeedback-${task.tkid}">보완 피드백:</label>
																	<textarea class="form-control"
																		id="userFeedback-${task.tkid}" name="userFeedback"
																		required></textarea>
																</div>
																<button type="submit" class="btn btn-primary mt-3">피드백
																	제출</button>
															</form>
														</c:if>
													</div>
												</div>
											</div>
										</div>


									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<footer class="app-footer">
			<div class="container text-center py-3">
				<small class="copyright">Designed with by <a
					class="app-link" href="http://themes.3rdwavemedia.com"
					target="_blank">Xiaoying Riley</a> for developers
				</small>
			</div>
		</footer>
	</div>

	<script>
	$(document).ready(function() {
	    // 탭 필터링 기능
	    $('.nav-link').on('click', function(event) {
	        event.preventDefault();
	        $('.nav-link').removeClass('active');
	        $(this).addClass('active');
	        
	        var status = $(this).attr('id');
	        filterTasks(status);
	    });

	    // TKID 검색 기능
	    $('#searchInput').on('keyup', function() {
	        var value = $(this).val().toLowerCase();
	        filterTasks($('.nav-link.active').attr('id'), value);
	    });

	    // 필터링 함수
	    function filterTasks(status, searchValue = '') {
	        $('tbody tr').each(function() {
	            var taskRow = $(this);
	            var taskId = taskRow.find('.task-row').first().data('taskid').toString();
	            var isCompleted = taskRow.find('.status-select').val() === "1"; // 완료 상태 확인

	            var showRow = true;

	            // 상태 필터링
	            if (status === 'inProgressTab' && isCompleted) {
	                showRow = false; // 완료된 작업은 진행 중 탭에서 숨깁니다.
	            } else if (status === 'completedTab' && !isCompleted) {
	                showRow = false; // 완료되지 않은 작업은 완료 탭에서 숨깁니다.
	            }

	            // TKID 검색 필터링
	            if (searchValue && !taskId.includes(searchValue)) {
	                showRow = false;
	            }

	            // 필터링 결과에 따라 행을 보여주거나 숨깁니다.
	            if (showRow) {
	                taskRow.show();
	            } else {
	                taskRow.hide();
	            }
	        });
	    }

	    filterTasks('allTab');

	    // 작업 상세 정보를 보기 위해 테이블 셀을 클릭 시 모달을 띄움
	    $('tbody tr').on('click', '.task-row', function() {
	        var taskId = $(this).data('taskid');
	        var target = '#viewTaskModal-' + taskId;
	        $(target).modal('show');
	    });

	    // 상태 변경 시 AJAX 요청을 통해 상태 업데이트
	    $('.status-select').on('change', function() {
	        const taskId = $(this).data('taskid');
	        const newStatus = $(this).val() === "1";

	        fetch('/newTask/updateStatus', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                tkid: taskId,
	                endYn: newStatus
	            })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.success) {
	                alert('상태가 성공적으로 업데이트되었습니다.');
	            } else {
	                alert('상태 업데이트에 실패했습니다.');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	        });

	        // 상태 변경 후 필터링 다시 적용
	        var activeTab = $('.nav-link.active').attr('id');
	        filterTasks(activeTab, $('#searchInput').val().toLowerCase());
	    });
	});


	function confirmDelete() {
	    return confirm("정말로 이 작업을 삭제하시겠습니까?");
	}
    </script>

	<script src="assets/plugins/popper.min.js"></script>
	<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/app.js"></script>
</body>
</html>
