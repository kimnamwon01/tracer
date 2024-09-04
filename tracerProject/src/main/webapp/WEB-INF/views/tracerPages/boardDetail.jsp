<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>게시물 보기</title>
    <link rel="stylesheet" href="${path}/a00_com/project/board.css">
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">
    <style>
        /* 중앙 정렬을 위한 스타일 */
        .container {
            width: 80%;
            margin: 80px auto;
            padding: 20px;
            text-align: center;
        }

        /* 제목 1 스타일 */
        h1 {
            margin-bottom: 50px; /* 아래 여백을 조정하여 간격 조절 */
            border-bottom: 4px solid #00796B; /* 하단에 굵은 선 추가 및 색상 변경 */
            padding-bottom: 10px; /* 선과 텍스트 사이의 여백 */
            width: 100%; /* 너비를 100%로 설정하여 선이 가로폭 전체를 차지하도록 설정 */
            box-sizing: border-box; /* 패딩과 테두리를 포함하여 전체 너비 조정 */
            text-align: center; /* 텍스트 중앙 정렬 */
            font-size: 40px; /* 제목 글씨 크기 */
        }

        /* 제목 2 스타일 */
        h2 {
            display: inline-block; /* 인라인 블록으로 설정하여 너비 조정 가능 */
            text-align: left; /* 텍스트 왼쪽 정렬 */
            max-width: 60%; /* 최대 너비 설정 */
            margin-left: auto; /* 왼쪽 여백 자동 조정 */
            margin-right: 0; /* 오른쪽 여백 0으로 설정 */
            border: none; /* 테두리 제거 */
            border-radius: 0; /* 모서리 둥글기 제거 */
            padding: 0; /* 내부 여백 제거 */
            background-color: transparent; /* 배경색 투명으로 설정 */
            margin-bottom: 15px; /* 아래 여백 */
            font-size: 28px; /* 제목 글씨 크기 */
        }

        /* 내용 박스 스타일 */
        .content-box {
            border: 1px solid #ddd; /* 연한 회색 테두리 */
            border-radius: 8px; /* 둥근 모서리 */
            padding: 15px; /* 내부 여백 */
            background-color: #fff; /* 흰색 배경 */
            margin: 15px 0; /* 위아래 여백 */
            text-align: left; /* 텍스트 왼쪽 정렬 */
            max-width: 60%; /* 박스 최대 너비를 설정 */
            margin-left: 250px; /* 오른쪽 정렬을 위한 여백 자동 조정 */
            margin-right: 0; /* 오른쪽 여백을 0으로 설정 */
        }

        /* 버튼과 타이틀 스타일 */
        .back-button {
            font-size: 24px; /* 이모티콘 크기 조정 */
            cursor: pointer; /* 클릭 가능한 커서 표시 */
            margin-right: 10px; /* 타이틀과 이모티콘 사이 여백 */
        }

        .notice-title {
            font-size: 28px; /* 타이틀 글씨 크기 */
            font-weight: bold; /* 타이틀 글씨 굵게 */
        }
    </style>
   
</head>
<body>
    <jsp:include page="/headerSidebar.jsp" />
    
    <div class="container">
        <h1> 상세보기</h1>
        
        <c:choose>
            <c:when test="${not empty board}">
                <p>
				<span class="back-button" onclick="goBack()">⬅️</span> <span
					class="notice-title">${board.title}</span>
			</p>
                <div class="content-box">
                    <p>${board.content}</p>
                </div>
                <p>작성자: ${board.nickname}</p>
                <p>이메일: ${board.email}</p>
                <p>게시일: <fmt:formatDate value="${board.upt_date}" pattern="yyyy-MM-dd HH:mm"/></p>
                <c:if test="${not empty board.uf}">
                    <p>링크: <a href="${board.uf}" target="_blank">${board.uf}</a></p>
                </c:if>
            </c:when>
            <c:otherwise>
                <p>잘못된 접근입니다.</p>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="assets/plugins/popper.min.js"></script>
		<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
		<script>
			function goBack() {
				window.location.href = 'http://localhost:5656/riskBoard';
			}
		</script>
</body>
</html>