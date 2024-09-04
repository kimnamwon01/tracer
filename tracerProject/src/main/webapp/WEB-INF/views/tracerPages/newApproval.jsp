<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>TRACER - 결재 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/portal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/plugins/bootstrap/css/bootstrap.min.css">
</head>
<body class="app">
	<jsp:include page="/headerSidebar.jsp" />
	<div class="app-wrapper">
		<div class="app-content pt-3 p-md-3 p-lg-4">
			<div class="container-xl">
				<h1>결재 관리</h1>

				<nav id="orders-table-tab"
					class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
					<a class="flex-sm-fill text-sm-center nav-link active"
						id="orders-all-tab" data-bs-toggle="tab" href="#orders-all"
						role="tab" aria-controls="orders-all" aria-selected="true">전체</a>
					<a class="flex-sm-fill text-sm-center nav-link"
						id="orders-waiting-tab" data-bs-toggle="tab"
						href="#orders-waiting" role="tab" aria-controls="orders-waiting"
						aria-selected="false">결재 대기</a> <a
						class="flex-sm-fill text-sm-center nav-link" id="orders-hold-tab"
						data-bs-toggle="tab" href="#orders-hold" role="tab"
						aria-controls="orders-hold" aria-selected="false">보류</a> <a
						class="flex-sm-fill text-sm-center nav-link"
						id="orders-completed-tab" data-bs-toggle="tab"
						href="#orders-completed" role="tab"
						aria-controls="orders-completed" aria-selected="false">결재 완료</a>
				</nav>

				<div class="tab-content" id="orders-table-tab-content">
					<!-- 전체 탭 -->
					<div class="tab-pane fade show active" id="orders-all"
						role="tabpanel" aria-labelledby="orders-all-tab">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>APID</th>
									<th>결재 상태</th>
									<th>요청 일시</th>
									<th>상태 변경 일시</th>
									<th>작업 ID</th>
									<th>상세 보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="approval" items="${approvals}">
									<tr>
										<td>${approval.apid}</td>
										<td>${approval.approvalStatus}</td>
										<td>${approval.formattedRequestDateTime}</td>
										<td>${approval.formattedUpdateDateTime}</td>
										<td>${approval.tkid}</td>
										<td>
											<button type="button" class="btn btn-info"
												data-bs-toggle="modal"
												data-bs-target="#approvalModal-${approval.apid}">상세
												보기</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 결재 대기 탭 -->
					<div class="tab-pane fade" id="orders-waiting" role="tabpanel"
						aria-labelledby="orders-waiting-tab">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>APID</th>
									<th>결재 상태</th>
									<th>요청 일시</th>
									<th>상태 변경 일시</th>
									<th>작업 ID</th>
									<th>상세 보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="approval" items="${approvals}">
									<c:if test="${approval.approvalStatus == '결재 대기'}">
										<tr>
											<td>${approval.apid}</td>
											<td>${approval.approvalStatus}</td>
											<td>${approval.formattedRequestDateTime}</td>
											<td>${approval.formattedUpdateDateTime}</td>
											<td>${approval.tkid}</td>
											<td>
												<button type="button" class="btn btn-info"
													data-bs-toggle="modal"
													data-bs-target="#approvalModal-${approval.apid}">상세
													보기</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 보류 탭 -->
					<div class="tab-pane fade" id="orders-hold" role="tabpanel"
						aria-labelledby="orders-hold-tab">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>APID</th>
									<th>결재 상태</th>
									<th>요청 일시</th>
									<th>상태 변경 일시</th>
									<th>작업 ID</th>
									<th>상세 보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="approval" items="${approvals}">
									<c:if test="${approval.approvalStatus == '보류'}">
										<tr>
											<td>${approval.apid}</td>
											<td>${approval.approvalStatus}</td>
											<td>${approval.formattedRequestDateTime}</td>
											<td>${approval.formattedUpdateDateTime}</td>
											<td>${approval.tkid}</td>
											<td>
												<button type="button" class="btn btn-info"
													data-bs-toggle="modal"
													data-bs-target="#approvalModal-${approval.apid}">상세
													보기</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 결재 완료 탭 -->
					<div class="tab-pane fade" id="orders-completed" role="tabpanel"
						aria-labelledby="orders-completed-tab">
						<table class="table table-hover">
							<thead>
								<tr>
									<th>APID</th>
									<th>결재 상태</th>
									<th>요청 일시</th>
									<th>상태 변경 일시</th>
									<th>작업 ID</th>
									<th>상세 보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="approval" items="${approvals}">
									<c:if test="${approval.approvalStatus == '결재 완료'}">
										<tr>
											<td>${approval.apid}</td>
											<td>${approval.approvalStatus}</td>
											<td>${approval.formattedRequestDateTime}</td>
											<td>${approval.formattedUpdateDateTime}</td>
											<td>${approval.tkid}</td>
											<td>
												<button type="button" class="btn btn-info"
													data-bs-toggle="modal"
													data-bs-target="#approvalModal-${approval.apid}">상세
													보기</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal -->
		<c:forEach var="approval" items="${approvals}">
			<div class="modal fade" id="approvalModal-${approval.apid}"
				tabindex="-1" aria-labelledby="approvalModalLabel-${approval.apid}"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="approvalModalLabel-${approval.apid}">결재
								상세 정보</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form action="/approval/updateStatus" method="post">
								<input type="hidden" name="apid" value="${approval.apid}" />
								<div class="mb-3">
									<label class="form-label">결재 상태</label> <select
										class="form-control" name="approvalStatus">
										<option value="결재 대기"
											${approval.approvalStatus == '결재 대기' ? 'selected' : ''}>결재
											대기</option>
										<option value="결재 완료"
											${approval.approvalStatus == '결재 완료' ? 'selected' : ''}>결재
											완료</option>
										<option value="보류"
											${approval.approvalStatus == '보류' ? 'selected' : ''}>보류</option>
									</select>
								</div>
								<div class="mb-3">
									<label class="form-label">요청 일시</label>
									<p class="form-control-plaintext">${approval.formattedRequestDateTime}</p>
								</div>
								<div class="mb-3">
									<label class="form-label">상태 업데이트 일시</label>
									<p class="form-control-plaintext">${approval.formattedUpdateDateTime}</p>
								</div>
								<div class="mb-3">
									<label class="form-label">작업 ID</label>
									<p class="form-control-plaintext">${approval.tkid}</p>
								</div>
								<div class="mb-3">
									<label class="form-label">업로드 파일</label>
									<p class="form-control-plaintext">
										<a href="/downloadFile?apid=${approval.apid}">다운로드</a>
									</p>
								</div>
								<div class="mb-3">
									<label class="form-label">피드백</label>
									<textarea class="form-control" name="feedback">${approval.feedback}</textarea>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
									<button type="submit" class="btn btn-primary">상태 업데이트</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- Bootstrap JS 로드 -->
	<script
		src="${pageContext.request.contextPath}/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
