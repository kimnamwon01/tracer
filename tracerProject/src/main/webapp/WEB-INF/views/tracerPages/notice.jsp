<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.web.tracerProject.vo.User_info"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>게시판 검색</title>
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
<!-- <link rel="stylesheet" href="${path}/a00_com/project/board.css"> -->

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
</head>
<style>
.title-cell {
	max-width: 150px; /* 대략 10글자에 해당하는 너비 */
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.custom-link {
	color: black; /* 검은색 텍스트 */
	text-decoration: none; /* 밑줄 제거 */
}

.custom-link:hover {
	text-decoration: underline; /* 호버 시 밑줄 추가 (선택 사항) */
}
.pagination-container {
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
    margin-top: 20px; /* 원하는 상단 여백 추가 */
}
</style>

<body>
	<jsp:include page="/headerSidebar.jsp" />
	<br>
	<br>
	<div class="app-wrapper">
		<div class="app-content pt-3 p-md-3 p-lg-4">
			<div class="container-xl">
				<br> <br>

				<!-- 페이지 헤더 및 유틸리티 -->
				<div class="row g-3 mb-4 align-items-center justify-content-between">
					<div class="col-auto">
						<h1>
							<a class="app-page-title mb-0 custom-link" href="#"
								onclick="redirectToNotice()">공지사항</a>
						</h1>
					</div>
					<div class="col-auto">
        <span>총 ${count}개 항목</span>
    </div>
					<div class="col-auto">
						<div class="page-utilities">
							<div
								class="row g-2 justify-content-start justify-content-md-end align-items-center">
								<!-- 검색 폼 -->
								<div class="col-auto">
									<form action="/searchNotices" method="get">
										<input type="text" name="searchText" value="${searchText}"
											placeholder="검색어"> <select name="searchType">
											<option value="title"
												${searchType == 'title' ? 'selected' : ''}>제목</option>
											<option value="nickname"
												${searchType == 'nickname' ? 'selected' : ''}>작성자</option>
										</select>
										<button type="submit">검색</button>
									</form>
								</div>
								<!-- 등록 버튼 -->
								<div class="col-auto">
									<a class="btn app-btn-secondary nomem" id="openModalButton"
										data-bs-toggle="modal" data-bs-target="#noticeModal">등록</a> <a
										class="btn app-btn-secondary nomem" id="openMailModalButton"
										data-bs-toggle="modal" data-bs-target="#mailModal">메일 발송</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<nav id="orders-table-tab"
					class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
					<a class="flex-sm-fill text-sm-center nav-link active"
						id="orders-all-tab" data-bs-toggle="tab" href="#orders-all"
						role="tab" aria-controls="orders-all" aria-selected="true">공지사항
						게시판</a>
				</nav>

				<div class="tab-content" id="orders-table-tab-content">
					<div class="tab-pane fade show active" id="orders-all"
						role="tabpanel" aria-labelledby="orders-all-tab">
						<div class="app-card app-card-orders-table shadow-sm mb-5">
							<div class="app-card-body">
								<div class="table-responsive">
									<table class="table app-table-hover mb-0 text-left">
										<thead>
											<tr>
												<th class="cell">작성자</th>
												<th class="cell">이메일</th>
												<th class="cell">제목</th>
												<th class="cell">등록날짜</th>
												<th class="cell">기타</th>

											</tr>
										</thead>
										<tbody>
											<c:forEach var="no" items="${NoticeList}">
												<tr>
													<td class="cell">${no.nickname}</td>
													<td class="cell">${no.email}</td>
													<td class="cell title-cell"><a
														href="${pageContext.request.contextPath}/noticeDetail?vid=${no.vid}">${no.title}</a>
													</td>
													<td class="cell"><fmt:formatDate
															value="${no.date_of_registration}"
															pattern="yyyy-MM-dd HH:mm" /></td>
													<td class="cell nomem"><a href="#"
														class="btn-sm app-btn-primary"
														onclick="openEditModal('${no.vid}'); return false;">수정</a>
														<a href="#" class="btn-sm app-btn-secondary delete-btn"
														onclick="deleteNotice('${no.vid}'); return false;">삭제</a>
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
			</div>
		</div>
<!-- 페이지 네이션 -->
 <div class="pagination-container">
    <div class="d-flex justify-content-between align-items-center">
        <nav>
            <ul class="pagination">
                <!-- 이전 페이지 버튼 -->
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="?subject=${param.subject}&writer=${param.writer}&curPage=${currentPage - 1}&pageSize=${pageSize}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>

                <!-- 페이지 번호 버튼 -->
                <c:forEach var="pageNum" begin="1" end="${totalPages}">
                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?subject=${param.subject}&writer=${param.writer}&curPage=${pageNum}&pageSize=${pageSize}">${pageNum}</a>
                    </li>
                </c:forEach>

                <!-- 다음 페이지 버튼 -->
                <c:if test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="?subject=${param.subject}&writer=${param.writer}&curPage=${currentPage + 1}&pageSize=${pageSize}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>

		<!-- 모달 창 -->
		<div class="modal fade" id="noticeModal" tabindex="-1"
			aria-labelledby="noticeModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="noticeModalLabel">공지사항 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="noticeForm">
							<div class="mb-3">
								<label for="title" class="form-label">제목</label> <input
									type="text" class="form-control" id="title" name="title"
									required>
							</div>
							<div class="mb-3">
								<label for="content" class="form-label">내용</label>
								<textarea class="form-control" id="content" name="content"
									rows="3" required></textarea>
							</div>
							<div class="mb-3">
								<label for=nickname class="form-label">작성자</label> <input
									type="text" class="form-control" id="nickname" name="nickname"
									value="${userNickname}" required>
							</div>
							<div class="mb-3">
								<label for="email" class="form-label">이메일</label> <input
									type="email" class="form-control" id="email" name="email"
									required>
							</div>
							<div class="mb-3">
								<label for="start_dateStr" class="form-label">시작 날짜</label> <input
									type="date" class="form-control" id="start_dateStr"
									name="start_dateStr">
							</div>
							<div class="mb-3">
								<label for="end_dateStr" class="form-label">종료 날짜</label> <input
									type="date" class="form-control" id="end_dateStr"
									name="end_dateStr">
							</div>
							<div class="mb-3">
								<label for="link" class="form-label">Link</label> <input
									type="text" class="form-control" id="link" name="link" required>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary nomem" id="submitNotice"
							style="background-color: #17A663; border-color: #17A663;">등록</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 수정하는 모달 -->
		<div class="modal fade" id="editNoticeModal" tabindex="-1"
			aria-labelledby="editNoticeModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="editNoticeModalLabel">공지사항 수정</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="editNoticeForm">
							<div class="mb-3">
								<label for="editTitle" class="form-label">제목</label> <input
									type="text" class="form-control" id="editTitle" name="title"
									required>
							</div>
							<div class="mb-3">
								<label for="editContent" class="form-label">내용</label>
								<textarea class="form-control" id="editContent" name="content"
									rows="3" required></textarea>
							</div>
							<div class="mb-3">
								<label for="editLink" class="form-label">Link</label> <input
									type="text" class="form-control" id="editLink" name="link"
									required>
							</div>
							<input type="hidden" id="editVid" name="vid">
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary"
							id="submitEditNotice"
							style="background-color: #17A663; border-color: #17A663;">수정</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 메일 발송 모달 -->
		<div class="modal fade" id="mailModal" tabindex="-1"
			aria-labelledby="mailModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="mailModalLabel">메일 발송</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="mailForm">
							<div class="mb-3">
								<label for="mailTitle" class="form-label">제목</label> <input
									type="text" class="form-control" id="mailTitle"
									name="mailTitle" required>
							</div>
							<div class="mb-3">
								<label for="mailRecipients" class="form-label">수신자 이메일
									(각 이메일을 ,으로 구분)</label>
								<textarea class="form-control" id="mailRecipients"
									name="mailRecipients" rows="5" required></textarea>
							</div>
							<div class="mb-3">
								<label for="mailContent" class="form-label">내용</label>
								<textarea class="form-control" id="mailContent"
									name="mailContent" rows="3" required></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="sendMail"
							style="background-color: #17A663; border-color: #17A663;">발송</button>
					</div>
				</div>
			</div>
		</div>
		<footer class="app-footer">
			<div class="container text-center py-3">
				<small class="copyright">Designed with <span class="sr-only">love</span><i
					class="fas fa-heart" style="color: #fb866a;"></i> by <a
					class="app-link" href="http://themes.3rdwavemedia.com"
					target="_blank">Xiaoying Riley</a> for developers
				</small>
			</div>
		</footer>
	</div>

	<!-- Javascript -->
	<script src="assets/plugins/popper.min.js"></script>
	<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/app.js"></script>


	<script>
	$(document).ready(function(){
		$('nomem').hide()
	})
	document.getElementById('sendMail').addEventListener('click', function () {
	    const mailTitle = document.getElementById('mailTitle').value;
	    const mailRecipients = document.getElementById('mailRecipients').value.split(',').map(email => email.trim()).filter(email => email !== ''); // 쉼표로 이메일 분리
	    const mailContent = document.getElementById('mailContent').value;

	    if (mailTitle && mailRecipients.length > 0 && mailContent) {
	        fetch('/sendMail', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                mailTitle: mailTitle,
	                mailRecipients: mailRecipients,
	                mailContent: mailContent
	            })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.status === 'success') {
	                alert('메일이 성공적으로 발송되었습니다.');
	                // 폼 리셋
	                document.getElementById('mailForm').reset();
	                // 모달 창은 여전히 열려 있습니다.
	            } else {
	                alert(`메일 발송에 실패했습니다: ${data.message}`);
	            }
	        })
	        .catch(error => {
	            console.error('메일 발송 실패:', error);
	            alert('메일 발송에 실패했습니다.');
	        });
	    } else {
	        alert('모든 필드를 채워주세요.');
	    }
	});
	 // 등록하는코드
	document.getElementById('submitNotice').addEventListener('click', function() {
    var form = document.getElementById('noticeForm');
    var formData = new FormData(form);

    var data = {};
    formData.forEach((value, key) => {
        data[key] = value;
    });

    // 제목이 10글자를 초과하면 자릅니다.
    if (data.title && data.title.length > 10) {
        data.title = data.title.slice(0, 10) + '...';
    }

    if (data.start_dateStr) {
        data.start_dateStr = new Date(data.start_dateStr).toISOString().split('T')[0];
    }
    if (data.end_dateStr) {
        data.end_dateStr = new Date(data.end_dateStr).toISOString().split('T')[0];
    }

    console.log('Form data:', data); // 디버깅: 데이터 내용 확인

    fetch('/noticeListInsert', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        } else {
            throw new Error('Network response was not ok.');
        }
    })
    .then(data => {
        alert(data);
        if (data === '등록성공') {
            window.location.reload();
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('등록 실패: ' + error.message);
    });
});
	
	document.addEventListener("DOMContentLoaded", function() {
        var userNickname = "${user_info.nickname}"; // JSP에서 사용자 닉네임을 가져옵니다.
        var userEmail = "${user_info.email}"; // JSP에서 사용자 이메일을 가져옵니다.

        if (userNickname) {
            document.getElementById('nickname').value = userNickname; // 닉네임 필드를 자동으로 채웁니다.
        }

        if (userEmail) {
            document.getElementById('email').value = userEmail; // 이메일 필드를 자동으로 채웁니다.
        }
    });

    
    
    // 삭제하는 코드
   function deleteNotice(vid) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        console.log(`Deleting notice with vid: ${vid}`); // 디버깅: vid 값 확인
        fetch('/delete', { // URL을 '/delete'로 변경
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({ 'vid': vid })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok.');
            }
            return response.text();
        })
        .then(result => {
            console.log('Delete response:', result); // 디버깅: 응답 내용 확인
            alert(result);
            if (result.includes('삭제 성공')) {
                window.location.reload(); // 성공 시 페이지 새로고침
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('삭제 실패: ' + error.message);
        });
    }
}
    // 수정하는 코드
   document.addEventListener("DOMContentLoaded", function() {
       document.getElementById('submitEditNotice').addEventListener('click', function() {
           const formData = new FormData(document.getElementById('editNoticeForm'));

           const data = {
               vid: formData.get('vid'),
               title: formData.get('title'),
               content: formData.get('content'),
               start_date: formData.get('start_date'),
               end_date: formData.get('end_date'),
               link: formData.get('link')
           };

           fetch('/updateNotice', {
               method: 'POST',
               headers: {
                   'Content-Type': 'application/json'
               },
               body: JSON.stringify(data)
           })
           .then(response => response.text())
           .then(result => {
               alert(result);
               if (result.includes('수정 성공')) {
                   window.location.reload(); // 수정 성공 시 페이지 새로고침
               }
           })
           .catch(error => {
               console.error('Error:', error);
               alert('수정 실패: ' + error.message);
           });
       });
   });

   function openEditModal(vid) {

       $.ajax({
           url: "getNotice2",
           method: "GET",
           data: { vid: vid },
           dataType: "json",
           success: function(notice) {
               $('#editNoticeModal').modal('show');
               $("#editNoticeForm #editTitle").val(notice.title);
               $("#editNoticeForm #editContent").val(notice.content);
               $("#editNoticeForm #editLink").val(notice.link); // link 필드 값 설정
               $("#editNoticeForm #editVid").val(notice.vid);
           },
           error: function(err) {
               console.log(err);
           }
       });
   }
   
   function redirectToNotice() {
       window.location.href = "http://localhost:5656/Notice";
   }
    </script>
</body>
</html>