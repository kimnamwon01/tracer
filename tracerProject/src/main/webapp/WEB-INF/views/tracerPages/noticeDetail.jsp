<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<link rel="stylesheet"
	href="assets/plugins/bootstrap/css/bootstrap.min.css">
<link id="theme-style" rel="stylesheet" href="assets/css/portal.css">

<style>
body {
	padding-top: 20px;
	padding-bottom: 20px;
}

.container {
	max-width: 900px;
	margin-left: 300px; /* 오른쪽으로 이동 */
	margin-top: 50px; /* 아래로 이동 */
}

.page-header {
	margin-bottom: 20px;
	border-bottom: 2px solid navy; /* 남색 선 추가 */
	padding-bottom: 10px; /* 선과 콘텐츠 사이에 여백 추가 */
}

.notice-detail {
	border: 1px solid #ddd;
	padding: 30px; /* 내부 여백 */
	border-radius: 5px;
	background-color: #ffffff;
	width: 100%; /* 너비를 부모 요소에 맞추기 */
	max-width: 1000px; /* 최대 너비 설정 */
	margin: 0 auto; /* 중앙 정렬 */
	height: 600px; /* 고정 높이 설정 */
	overflow-y: auto; /* 내용이 넘칠 경우 스크롤 표시 */
	box-sizing: border-box; /* 패딩과 테두리를 너비와 높이에 포함 */
}

.notice-detail h2 {
	margin-top: 0;
	margin-bottom: 10px;
}

.notice-detail p {
	margin: 5px 0;
}

.page-header p {
	margin: 0;
	display: flex;
	align-items: center;
}

.back-button {
	cursor: pointer;
	font-size: 24px; /* 이모티콘 크기 */
	color: red; /* 이모티콘 색상 */
	background: transparent; /* 배경을 투명하게 설정 */
	border: none; /* 테두리 없애기 */
	margin-right: 10px; /* 제목과 이모티콘 사이에 여백 추가 */
}

.notice-title {
	font-size: 24px; /* 제목 크기, 이모티콘과 동일하게 설정 */
}

.comment-section {
	margin-top: 30px;
}

.comment-box {
	border: 1px solid #ddd;
	padding: 15px;
	border-radius: 5px;
	background-color: #f9f9f9;
}

.comment {
	border-bottom: 1px solid #ddd;
	padding: 10px 0;
}

.registration {
	text-align: right; /* 텍스트를 오른쪽으로 정렬 */
	margin-top: 20px; /* 상단 여백을 추가 */
	font-size: 20px;
}
.notice-link {
        color: blue; /* 링크 색상 */
        text-decoration: underline; /* 링크 밑줄 */
        margin-right: 20px; /* 오른쪽 여백 추가 */
    }
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
</style>
</head>
<body>
	<jsp:include page="/headerSidebar.jsp" />
	<div class="container">
		<div class="page-header">
			<p>
				<span class="back-button" onclick="goBack()">⬅️</span> <span
					class="notice-title">${notice.title}</span>
			</p>
		</div>
		<p>
			<strong>작성자:</strong> ${notice.nickname}
		</p>
		<p>
			<strong>이메일:</strong> ${notice.email}
		</p>
		<div class="notice-detail">
			<c:if test="${not empty notice}">
				<p>${notice.content}</p>
			</c:if>
		</div>
		<div class="page-header">
			<a href="${notice.link}" class="notice-link"> ${notice.link}</a>
			<div class="registration">
				<p>
					<strong>등록 날짜:</strong>
					<fmt:formatDate value="${notice.date_of_registration}"
						pattern="yyyy-MM-dd HH:mm" />
				</p>
			</div>
		</div>

		<!-- 댓글 작성 폼 -->

		<script src="assets/plugins/popper.min.js"></script>
		<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
		<script>
			function goBack() {
				window.location.href = 'http://localhost:5656/Notice#';
			}
		</script>
</body>
</html>
