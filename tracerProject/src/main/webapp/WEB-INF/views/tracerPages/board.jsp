<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>스프린트 관리</title>
<link rel="stylesheet" href="${path}/assets/css/portal.css">
<!-- FontAwesome JS -->
<script defer src="${path}/assets/plugins/fontawesome/js/all.min.js"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
   href="${path}/assets/plugins/bootstrap/css/bootstrap.min.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="${path}/a00_com/project/board.css">
<style>
.edit-container {
   display: none;
   position: fixed;
   top: 0;
   right: 0;
   width: 50%;
   height: 100%;
   background-color: white;
   box-shadow: -2px 0 5px rgba(0, 0, 0, 0.5);
   padding: 20px;
   z-index: 1000;
}

.edit-header {
   display: flex;
   justify-content: space-between;
   align-items: center;
   border-bottom: 1px solid #ccc;
   padding-bottom: 80px;
}

.edit-content {
   margin-top: 20px;
}

.issue-summary {
   cursor: pointer;
}

.issue-summary:hover {
   text-decoration: underline;
}

.textarea-container {
   display: none;
   margin-top: 20px;
}
</style>
</head>
<body>
   <div class="sprint-container">
      <div class="sprint-header">
         <h2>
            <input type="checkbox" id="select-all" onclick="toggleAll(this)">
         </h2>
         <h2 class="title">HUM 1 스프린트</h2>
         <button class="add-date">날짜 추가</button>
         <span class="issue-count">3개 이슈 <select
            onchange="handleSelectChange(this.value)">
               <option value="">선택</option>
               <option value="edit">편집</option>
               <option value="delete">삭제</option>
         </select>
         </span>
      </div>
      <ul class="issue-list">
         <c:forEach var="boa" items="${boardList}">
            <li class="issue-item"><input type="checkbox"
               class="issue-checkbox" id="issue-${boa.title}" value="${boa.title}">
               <label for="issue-${boa.title}" class="issue-key">${boa.bid}</label>
               <span class="issue-summary"
               onclick="openEditContainer('${boa.bid}', '${boa.title}', '${boa.content}', '${boa.email}')">${boa.title}</span>
               <span class="issue-status"> <select class="form-select"
                  name="status-${boa.bid}" id="status-${boa.bid}"
                  onchange="updateStatus('${boa.bid}', this.value)">
                     <option value="0" ${boa.endYN ? '' : 'selected'}>진행중</option>
                     <option value="1" ${boa.endYN ? 'selected' : ''}>완료</option>
               </select>
            </span></li>
         </c:forEach>
      </ul>
      <button class="add-issue" onclick="openTextarea()">+ 이슈 만들기</button>
      <div class="textarea-container" id="textarea-container">
         <textarea id="issue-title" placeholder="이슈 제목을 입력하세요..."></textarea>
         <!-- 저장 버튼 추가 -->
      </div>
   </div>
   <!-- 숨은 div박스 -->
   <div class="edit-container" id="edit-container">
      <div class="edit-header">
         <h2>이슈 수정</h2>
         <button onclick="closeEditContainer()">닫기</button>
      </div>
      <div class="edit-content">
         <form id="edit-form">
            <input type="hidden" id="edit-bid">
            <div class="form-group">
               <label for="edit-title">제목</label> <input type="text"
                  id="edit-title" class="form-control">
            </div>
            <div class="form-group">
               <label for="edit-content">내용</label>
               <textarea id="edit-content" class="form-control"></textarea>
            </div>
            <div class="form-group">
               <label for="edit-email">이메일</label> <input type="text"
                  id="edit-email" class="form-control">
            </div>



   <jsp:include page="/headerSidebar.jsp" />

   <script src="${path}/assets/plugins/popper.min.js"></script>
   <script src="${path}/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
   <script src="${path}/assets/js/app.js"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

   <script>
      function toggleAll(source) {
         var checkboxes = document.querySelectorAll('.issue-checkbox');
         checkboxes.forEach(function(checkbox) {
            checkbox.checked = source.checked;
         });
      }

      function handleSelectChange(action) {
         var checkboxes = document.querySelectorAll('.issue-checkbox');
         var selectedTitles = [];
         checkboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
               selectedTitles.push(checkbox.value);
            }
         });

         if (action === "edit") {
            openEditContainer();
         } else if (action === "delete") {
            deleteSelected(selectedTitles);
         }
      }

      function openEditContainer(bid, title, content, email) {
         document.getElementById("edit-bid").value = bid;
         document.getElementById("edit-title").value = title;
         document.getElementById("edit-content").value = content;
         document.getElementById("edit-email").value = email;
         document.getElementById("edit-container").style.display = "block";
      }

      function closeEditContainer() {
         document.getElementById("edit-container").style.display = "none";
      }

      function openTextarea() {
         document.getElementById("textarea-container").style.display = "block";
      }

      function closeTextarea() {
         document.getElementById("textarea-container").style.display = "none";
      }

      function deleteSelected(titles) {
         if (titles.length === 0) {
            alert("삭제할 항목을 선택해 주세요.");
            return;
         }

         if (confirm("선택한 항목을 삭제하시겠습니까?")) {
            $.ajax({
               url : '/boardDelete',
               type : 'POST',
               contentType : 'application/json',
               data : JSON.stringify({
                  ids : titles
               }),
               success : function(response) {
                  
                  console.log('Response:', response);
                  location.reload(); // 페이지 새로고침하여 삭제된 항목이 반영되도록 합니다.
               },
               error : function(xhr, status, error) {
                  console.error('Error:', error);
                  alert('삭제 요청 중 오류가 발생했습니다.');
               }
            });
         }
      }

      function updateStatus(bid, newStatus) {
         $.ajax({
            url : '/updateBoardStatus',
            type : 'POST',
            contentType : 'application/json',
            data : JSON.stringify({
               bid : bid,
               endYN : newStatus === '1'
            }),
            success : function(response) {
               console.log('Status updated successfully:', response);
            },
            error : function(xhr, status, error) {
               console.error('Error updating status:', error);
               alert('상태 업데이트 중 오류가 발생했습니다.');
            }
         });
      }

      function openTextarea() {
           document.getElementById("textarea-container").style.display = "block";
       }

       function closeTextarea() {
           document.getElementById("textarea-container").style.display = "none";
       }

       function saveIssue() {
           var issueTitle = document.getElementById("issue-title").value;
           if (issueTitle.trim() === "") {
               alert("제목을 입력해 주세요.");
               return;
           }

           $.ajax({
               url: '/boardListInsert',
               type: 'POST',
               contentType: 'application/json',
               data: JSON.stringify({
                   
                   title: issueTitle,
                   content: " ", // 내용은 비어있음
                   upt_date: " ", // 현재 날짜로 처리됨
                   views: 0, // 기본값
                   btype: "General", // 기본값
                   cid: null, // 댓글 ID는 필요없음
                   email: "", // 이메일은 빈 문자열
                   sid: "", // SID는 빈 문자열
                   endYN: false // 기본값: 진행중
               }),
               dataType:"text",
               success: function(response) {
                   alert(response)
                   console.log('Response:', response);
                   location.reload(); // 페이지 새로고침
               },
               error: function(xhr, status, error) {
            
                   console.error('Error:', error);
                   console.error('Error:', xhr);
                   console.error('Error:', status);
                   alert('이슈 저장 중 오류가 발생했습니다.'+error);
               }
           });
       }

       document.addEventListener('keydown', function(event) {
           if (event.key === 'Enter') {
               event.preventDefault();
               saveIssue();
           }
       });
   </script>
</body>
</html>
