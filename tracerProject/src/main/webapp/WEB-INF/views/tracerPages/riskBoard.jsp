<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>Risks게시판</title>

<!-- Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="게시판 검색">
<meta name="author" content="작성자">
<link rel="shortcut icon" href="favicon.ico">

<!-- FontAwesome JS -->
<script defer src="assets/plugins/fontawesome/js/all.min.js"></script>

<!-- App CSS -->
<link id="theme-style" rel="stylesheet" href="assets/css/portal.css">
<link rel="stylesheet" href="${path}/a00_com/project/board.css">
</head>
<style>
.app-pagination .page-item.active .page-link {
	background-color: #007bff;
	border-color: #007bff;
	color: #fff;
}

.app-pagination .page-link {
	color: #007bff;
	border: 1px solid #dee2e6;
}

.app-pagination .page-link:hover {
	background-color: #e9ecef;
}
</style>
<body>
	<jsp:include page="/headerSidebar.jsp" />

	<div class="app-wrapper">
		<div class="app-content pt-3 p-md-3 p-lg-4">
			<div class="container-xl">
				<br> <br>

				<!-- 페이지 헤더 및 유틸리티 -->
				<div class="row g-3 mb-4 align-items-center justify-content-between">
					<div class="col-auto">
						<h1 class="app-page-title mb-0">Risks게시판</h1>
					</div>
					<div class="col-auto">
						<div class="page-utilities">
							<div
								class="row g-2 justify-content-start justify-content-md-end align-items-center">
								<!-- 검색 폼 -->
								<div class="col-auto">
									<form action="/search" method="get">
										<input type="text" name="searchText" value="${searchText}"
											placeholder="검색어"> <select name="searchType">
											<option value="title"
												${searchType == 'title' ? 'selected' : ''}>제목</option>
											<option value="name"
												${searchType == 'nickname' ? 'selected' : ''}>작성자</option>
										</select>
										<button type="submit">검색</button>
									</form>
								</div>
								<!-- 등록 버튼 -->
								<div class="col-auto">
									<a class="btn app-btn-secondary" id="openModalButton"
										data-bs-toggle="modal" data-bs-target="#registerModal">등록</a>
								</div>
							</div>
						</div>
					</div>

					<!-- 게시판 탭 -->
					<nav id="orders-table-tab"
						class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
						<a class="flex-sm-fill text-sm-center nav-link active"
							id="orders-all-tab" data-bs-toggle="tab" href="#orders-all"
							role="tab" aria-controls="orders-all" aria-selected="true">리스트
							게시판</a>
					</nav>

					<!-- 게시판 테이블 내용 -->
					<div class="tab-content" id="orders-table-tab-content">
						<div class="tab-pane fade show active" id="orders-all"
							role="tabpanel" aria-labelledby="orders-all-tab">
							<div class="app-card app-card-orders-table shadow-sm mb-5">
								<div class="app-card-body">
									<div class="table-responsive">
										<table class="table app-table-hover mb-0 text-left">
											<thead class="table-header">
												<tr>
													<th class="cell">제목</th>
													<th class="cell">게시일</th>
													<th class="cell">링크</th>
													<th class="cell">작성자</th>
													<th class="cell">이메일</th>
													<th class="cell">진행사항</th>
													<th class="cell"></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="boa" items="${boardList}">
													<tr>
														<td class="cell"><a
															href="${pageContext.request.contextPath}/boardDetail?vid=${boa.bid}"
															class="text-decoration-none"> ${boa.title} </a></td>
														<td class="cell"><fmt:formatDate
																value="${boa.upt_date}" pattern="yyyy-MM-dd HH:mm" /></td>
														<td class="cell"><c:if test="${not empty boa.uf}">
																<a href="${boa.uf}" target="_blank">${boa.uf}</a>
															</c:if></td>
														<td class="cell"
															onclick="openEditModal('${boa.bid}', '${boa.title}', '${boa.content}', '${boa.uf}')">${boa.nickname}</td>
														<td class="cell"
															onclick="openEditModal('${boa.bid}', '${boa.title}', '${boa.content}', '${boa.uf}')">${boa.email}</td>
														<td class="cell"><select class="form-select"
															id="modal-endYN-${boa.bid}" name="endYN"
															onchange="updateStatus('${boa.bid}', this.value)">
																<option value="0" ${boa.endYN == '0' ? 'selected' : ''}>진행중</option>
																<option value="1" ${boa.endYN == '1' ? 'selected' : ''}>완료</option>
														</select></td>
														<td class="cell"><a href="#"
															class="btn-sm app-btn-primary"
															onclick="openEditModal('${boa.bid}', '${boa.title}', '${boa.content}', '${boa.uf}'); return false;">수정</a>
															<a href="#" class="btn-sm app-btn-secondary"
															onclick="deleteBoard('${boa.bid}'); return false;">삭제</a>

														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 게시글 개수 표시 -->
					<div class="mb-3">
						<span>총 게시글 수: ${totalCount}개</span>
					</div>

					<!-- 페이지네이션 -->
					<div class="pagination-container">
						<nav>
							<ul class="pagination">
								<!-- 이전 페이지 버튼 -->
								<li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
									<a class="page-link" href="#"
									onclick="navigatePage(${currentPage - 1})"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a>
								</li>

								<!-- 페이지 번호 버튼 -->
								<c:forEach var="pageNum" begin="${startBlock}" end="${endBlock}">
									<li class="page-item ${pageNum == currentPage ? 'active' : ''}">
										<a class="page-link" href="#"
										onclick="navigatePage(${pageNum})">${pageNum}</a>
									</li>
								</c:forEach>

								<!-- 다음 페이지 버튼 -->
								<li
									class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
									<a class="page-link" href="#"
									onclick="navigatePage(${currentPage + 1})" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
								</a>
								</li>
							</ul>
						</nav>
					</div>

					<!-- 등록 모달 -->
					<div class="modal fade" id="registerModal" tabindex="-1"
						aria-labelledby="registerModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="registerModalLabel">게시판 등록</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="닫기"></button>
								</div>
								<div class="modal-body">
									<form id="orderDetailsForm">
										<div class="mb-3">
											<label for="register-title" class="form-label">제목</label> <input
												type="text" class="form-control" id="register-title"
												name="title" required>
										</div>
										<div class="mb-3">
											<label for="register-content" class="form-label">내용</label>
											<textarea class="form-control" id="register-content"
												name="content" rows="5" required></textarea>
										</div>
										<div class="mb-3">
											<label for="register-email" class="form-label">이메일</label> <input
												type="email" class="form-control" id="register-email"
												name="email" value="${email}" readonly>
										</div>
										<div class="mb-3">
											<label for="register-nickname" class="form-label">작성자</label>
											<input type="text" class="form-control"
												id="register-nickname" name="nickname" value="${nickname}"
												readonly>
										</div>
										<div class="mb-3">
											<label for="register-uf" class="form-label">URL</label> <input
												type="text" class="form-control" id="register-uf" name="uf">
										</div>
										<button type="submit" class="btn app-btn-primary">등록</button>
									</form>
								</div>
							</div>
						</div>
					</div>

					<!-- 수정하는 모달창 -->
					<div class="modal fade" id="editDetailsModal" tabindex="-1"
						aria-labelledby="editDetailsModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="editDetailsModalLabel">게시판 수정</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="닫기"></button>
								</div>
								<div class="modal-body">
									<form id="editDetailsForm">
										<input type="hidden" id="edit-bid" name="bid">

										<!-- 제목 입력 필드 -->
										<div class="mb-3">
											<label for="edit-title" class="form-label">제목</label> <input
												type="text" class="form-control" id="edit-title"
												name="title" required>
										</div>

										<!-- 내용 입력 필드 -->
										<div class="mb-3">
											<label for="edit-content" class="form-label">내용</label>
											<textarea class="form-control" id="edit-content"
												name="content" rows="5" required></textarea>
										</div>

										<!-- URL 입력 필드 -->
										<div class="mb-3">
											<label for="edit-uf" class="form-label">URL</label> <input
												type="text" class="form-control" id="edit-uf" name="uf">
										</div>

										<!-- 상태 입력 필드 -->
										<div class="mb-3">
											<label for="edit-endYN" class="form-label">상태</label> <select
												class="form-select" id="edit-endYN" name="endYN">
												<option value="0">진행중</option>
												<option value="1">완료</option>
											</select>
										</div>
										<!-- 모달 푸터 -->
										<div class="modal-footer">
											<button type="submit" class="btn btn-primary">수정</button>
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">닫기</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- Javascript -->
					<script src="assets/plugins/popper.min.js"></script>
					<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
					<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
					<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
					<script type="text/javascript">
					$(document).ready(function() {
					    // 페이지 이동을 처리하는 함수
					    function navigatePage(pageNumber) {
					        var currentPage = parseInt('${currentPage}');
					        var totalPages = parseInt('${totalPages}');

					        if (pageNumber < 1 || pageNumber > totalPages) {
					            return;
					        }

					        var url = new URL(window.location.href);
					        url.searchParams.set('curPage', pageNumber);

					        window.location.href = url.toString();
					    }

					    // 게시판 등록 폼 제출 처리
					    $("#orderDetailsForm").on("submit", function(event) {
					        event.preventDefault(); // 기본 폼 제출 동작 방지

					        var formData = {
					            title: $("#register-title").val(),
					            content: $("#register-content").val(),
					            email: $("#register-email").val(),
					            nickname: $("#register-nickname").val(),
					            uf: $("#register-uf").val(),
					            upt_date: new Date().toISOString() // 현재 날짜와 시간
					        };

					        $.ajax({
					            url: '/boardListInsert',
					            type: 'POST',
					            contentType: 'application/json',
					            data: JSON.stringify(formData),
					            success: function(response) {
					                alert("등록 성공");
					                $('#registerModal').modal('hide'); // 모달 닫기
					                location.reload(); // 페이지 새로 고침
					            },
					            error: function(xhr, status, error) {
					                alert("등록 실패하였습니다.");
					            }
					        });
					    });

					    // 게시판 수정 모달 열기 함수
					    window.openEditModal = function(bid, title, content, uf, endYN) {
					        $('#edit-bid').val(bid);
					        $('#edit-title').val(title);
					        $('#edit-content').val(content);
					        $('#edit-uf').val(uf);
					        $('#edit-endYN').val(endYN === '1' ? '1' : '0');
					        $('#editDetailsModal').modal('show');
					    };

					    // 게시판 수정 폼 제출 처리
					    $("#editDetailsForm").on("submit", function(event) {
					        event.preventDefault();

					        var formData = {
					            bid: $("#edit-bid").val(),
					            title: $("#edit-title").val(),
					            content: $("#edit-content").val(),
					            uf: $("#edit-uf").val(),
					            endYN: $("#edit-endYN").val() === '1'
					        };

					        $.ajax({
					            url: '/boardUpdate',
					            type: 'POST',
					            contentType: 'application/json',
					            data: JSON.stringify(formData),
					            success: function(response) {
					                alert("수정 성공");
					                $('#editDetailsModal').modal('hide');
					                location.reload();
					            },
					            error: function(xhr, status, error) {
					                alert("수정 실패하였습니다.");
					            }
					        });
					    });

					    // 상태 업데이트 처리 함수
					    function updateStatus(bid, newStatus) {
					        $.ajax({
					            url: '/updateBoardStatus',
					            type: 'POST',
					            contentType: 'application/json',
					            data: JSON.stringify({
					                bid: bid,
					                endYN: newStatus === '1'
					            }),
					            success: function(response) {
					                alert('상태 업데이트 성공');
					            },
					            error: function(xhr, status, error) {
					                alert('상태 업데이트 중 오류 발생');
					            }
					        });
					    }

					    // 상태 변경 시 업데이트 호출
					    $('select[name="endYN"]').on('change', function() {
					        var bid = $(this).attr('id').split('-').pop();
					        var newStatus = $(this).val();
					        updateStatus(bid, newStatus);
					    });

					    // 게시글 삭제 요청을 처리하는 함수
					    function deleteBoard(bid) {
					        if (confirm('정말 삭제하시겠습니까?')) {
					            $.ajax({
					                url: '/deleteBoard',
					                type: 'POST',
					                data: { bid: bid },
					                success: function(response) {
					                    alert(response);
					                    location.reload();
					                },
					                error: function(xhr, status, error) {
					                    alert('삭제 중 오류 발생: ' + xhr.responseText);
					                }
					            });
					        }
					    }

					    // 전역에서 접근 가능한 함수들을 window 객체에 추가
					    window.navigatePage = navigatePage;
					    window.deleteBoard = deleteBoard;
					});

	</script>
					<!-- Page Specific JS -->
					<script src="assets/js/app.js"></script>
</body>
</html>
