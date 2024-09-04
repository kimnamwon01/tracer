<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>TRACER - 결재 페이지</title>
    
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- App CSS -->
    <link id="theme-style" rel="stylesheet" href="assets/css/portal.css">
    
    <!-- Custom CSS for status colors -->
    <style>
        .status-pending {
            color: #ffc107; /* 노랑색 */
            font-weight: bold;
        }

        .status-rejected {
            color: #dc3545; /* 빨강색 */
            font-weight: bold;
        }

        .status-completed {
            color: #28a745; /* 초록색 */
            font-weight: bold;
        }
        
         .modal {
        display: none; /* 모달 기본적으로 숨김 */
        position: fixed; /* 화면에 고정 */
        z-index: 1000; /* 다른 요소 위에 표시 */
        left: 0;
        top: 0;
        width: 100%; /* 전체 화면 너비 */
        height: 100%; /* 전체 화면 높이 */
        overflow: auto; /* 내용이 넘칠 경우 스크롤 */
        background-color: rgba(0,0,0,0.5); /* 반투명 배경 */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 화면 중앙에 위치 (위쪽 여백 15%) */
        padding: 20px;
        border: 1px solid #888;
        width: 50%; /* 모달 넓이 (원하는 크기로 조정) */
        max-width: 500px; /* 최대 넓이 */
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        border-radius: 8px; /* 모서리 둥글게 */
    }

    .close-btn {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close-btn:hover,
    .close-btn:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    textarea {
        width: 100%;
        height: 100px; /* 높이 조정 */
        padding: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }

    .btn-primary {
        background-color: #007bff;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin-top: 10px;
        cursor: pointer;
        border-radius: 4px;
    }

    .btn-primary:hover {
        background-color: #0056b3;
    }
    </style>
</head>
<jsp:include page="/headerSidebar.jsp"/> 
<body>
    <div class="app-wrapper">
        <div class="app-content pt-3 p-md-3 p-lg-4">
            <div class="container-xl">
            <br><br>
                <!-- Title and Utilities -->
                <div class="row g-3 mb-4 align-items-center justify-content-between">
                    <div class="col-auto">
                        <h1 class="app-page-title mb-0">결재</h1>
                    </div>
                    <div class="col-auto">
                        <div class="page-utilities">
                            <div class="row g-2 justify-content-start justify-content-md-end align-items-center">
                                <div class="col-auto">
                                    <form class="table-search-form row gx-1 align-items-center">
                                        <div class="col-auto">
                                            <input type="text" id="search-orders" name="searchorders" class="form-control search-orders" placeholder="Search">
                                        </div>
                                        <div class="col-auto">
                                            <button type="submit" class="btn app-btn-secondary">Search</button>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-auto">
                                    <select class="form-select w-auto">
                                        <option selected value="option-1">All</option>
                                        <option value="option-2">This week</option>
                                        <option value="option-3">This month</option>
                                        <option value="option-4">Last 3 months</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tab Navigation -->
                <nav id="orders-table-tab" class="orders-table-tab app-nav-tabs nav shadow-sm flex-column flex-sm-row mb-4">
                    <a class="flex-sm-fill text-sm-center nav-link active" id="orders-all-tab" data-bs-toggle="tab" href="#orders-all" role="tab" aria-controls="orders-all" aria-selected="true">전체</a>
                    <a class="flex-sm-fill text-sm-center nav-link" id="orders-pending-tab" data-bs-toggle="tab" href="#orders-pending" role="tab" aria-controls="orders-pending" aria-selected="false">결재 대기</a>
                    <a class="flex-sm-fill text-sm-center nav-link" id="orders-rejected-tab" data-bs-toggle="tab" href="#orders-rejected" role="tab" aria-controls="orders-rejected" aria-selected="false">보류</a>
                    <a class="flex-sm-fill text-sm-center nav-link" id="orders-completed-tab" data-bs-toggle="tab" href="#orders-completed" role="tab" aria-controls="orders-completed" aria-selected="false">결재 완료</a>
                </nav>

                <!-- Tab Content -->
                <div class="tab-content" id="orders-table-tab-content">
                    <!-- 전체 탭 -->
                    <div class="tab-pane fade show active" id="orders-all" role="tabpanel" aria-labelledby="orders-all-tab">
                        <div class="app-card app-card-orders-table shadow-sm mb-5">
                            <div class="app-card-body">
                                <div class="table-responsive">
                                    <table class="table app-table-hover mb-0 text-left">
                                        <thead>
                                            <tr>
                                                <th class="cell">결재번호</th>
                                                <th class="cell">제목</th> <!-- 제목으로 변경 -->
                                                <th class="cell">요청자</th>
                                                <th class="cell">결재 요청 시간</th>
                                                <th class="cell">이메일</th>
                                                <th class="cell">상태</th>
                                                <th class="cell">상태 변경</th>
                                                <th class="cell">상태 변경 시간</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="approval" items="${allApprovals}">
                                                <tr>
                                                    <td class="cell">${approval.apid}</td>
                                                    <td class="cell"><span class="truncate">${approval.name}</span></td> <!-- name으로 변경 -->
                                                    <td class="cell">${approval.nickname}</td>
                                                    <td class="cell">${approval.formattedRequestDateTime}</td> <!-- 결재 요청 시간 -->
                                                    <td class="cell"><span>${approval.email}</span></td>
                                                    <td class="cell">
                                                        <span class="<c:choose>
                                                            <c:when test="${approval.approvalStatus == '결재 대기'}">status-pending</c:when>
                                                            <c:when test="${approval.approvalStatus == '보류'}">status-rejected</c:when>
                                                            <c:when test="${approval.approvalStatus == '결재 완료'}">status-completed</c:when>
                                                        </c:choose>">
                                                            ${approval.approvalStatus}
                                                        </span>
                                                    </td>
                                                    <td class="cell">
                                                        <button class="btn-sm app-btn-secondary" onclick="updateApprovalStatus('${approval.apid}', '결재 완료')">승인</button>
                                                        <button class="btn-sm app-btn-secondary" onclick="updateApprovalStatus('${approval.apid}', '보류')">보류</button>
                                                    </td>
                                                    <td class="cell">${approval.formattedStatusUpdateDateTime}</td> <!-- 상태 변경 시간 -->
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 결재 대기 탭 -->
                    <div class="tab-pane fade" id="orders-pending" role="tabpanel" aria-labelledby="orders-pending-tab">
                        <div class="app-card app-card-orders-table mb-5">
                            <div class="app-card-body">
                                <div class="table-responsive">
                                    <table class="table mb-0 text-left">
                                        <thead>
                                            <tr>
                                                <th class="cell">결재번호</th>
                                                <th class="cell">제목</th> <!-- 제목으로 변경 -->
                                                <th class="cell">요청자</th>
                                                <th class="cell">결재 요청 시간</th>
                                                <th class="cell">이메일</th>
                                                <th class="cell">상태</th>
                                                <th class="cell">상태 변경</th>
                                                <th class="cell">상태 변경 시간</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="approval" items="${pendingApprovals}">
                                                <tr>
                                                    <td class="cell">${approval.apid}</td>
                                                    <td class="cell"><span class="truncate">${approval.name}</span></td> <!-- name으로 변경 -->
                                                    <td class="cell">${approval.nickname}</td>
                                                    <td class="cell">${approval.formattedRequestDateTime}</td> <!-- 결재 요청 시간 -->
                                                    <td class="cell"><span>${approval.email}</span></td>
                                                    <td class="cell">
                                                        <span class="status-pending">${approval.approvalStatus}</span>
                                                    </td>
                                                    <td class="cell">
                                                        <button class="btn-sm app-btn-secondary" onclick="updateApprovalStatus('${approval.apid}', '결재 완료')">승인</button>
                                                        <button class="btn-sm app-btn-secondary" onclick="updateApprovalStatus('${approval.apid}', '보류')">보류</button>
                                                    </td>
                                                    <td class="cell">${approval.formattedStatusUpdateDateTime}</td> <!-- 상태 변경 시간 -->
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 보류 탭 -->
                    <div class="tab-pane fade" id="orders-rejected" role="tabpanel" aria-labelledby="orders-rejected-tab">
                        <div class="app-card app-card-orders-table mb-5">
                            <div class="app-card-body">
                                <div class="table-responsive">
                                    <table class="table mb-0 text-left">
                                        <thead>
                                            <tr>
                                                <th class="cell">결재번호</th>
                                                <th class="cell">제목</th> <!-- 제목으로 변경 -->
                                                <th class="cell">요청자</th>
                                                <th class="cell">결재 요청 시간</th>
                                                <th class="cell">이메일</th>
                                                <th class="cell">상태</th>
                                                <th class="cell">상태 변경</th>
                                                <th class="cell">상태 변경 시간</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="approval" items="${rejectedApprovals}">
                                                <tr>
                                                    <td class="cell">${approval.apid}</td>
                                                    <td class="cell"><span class="truncate">${approval.name}</span></td> <!-- name으로 변경 -->
                                                    <td class="cell">${approval.nickname}</td>
                                                    <td class="cell">${approval.formattedRequestDateTime}</td> <!-- 결재 요청 시간 -->
                                                    <td class="cell"><span>${approval.email}</span></td>
                                                    <td class="cell">
                                                        <span class="status-rejected">${approval.approvalStatus}</span>
                                                    </td>
                                                    <td class="cell">
                                                        <button class="btn-sm app-btn-secondary" onclick="updateApprovalStatus('${approval.apid}', '결재 완료')">승인</button>
                                                        <button class="btn-sm app-btn-secondary" onclick="updateApprovalStatus('${approval.apid}', '보류')">보류</button>
                                                    </td>
                                                    <td class="cell">${approval.formattedStatusUpdateDateTime}</td> <!-- 상태 변경 시간 -->
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 결재 완료 탭 -->
                    <div class="tab-pane fade" id="orders-completed" role="tabpanel" aria-labelledby="orders-completed-tab">
                        <div class="app-card app-card-orders-table mb-5">
                            <div class="app-card-body">
                                <div class="table-responsive">
                                    <table class="table mb-0 text-left">
                                        <thead>
                                            <tr>
                                                <th class="cell">결재번호</th>
                                                <th class="cell">제목</th> <!-- 제목으로 변경 -->
                                                <th class="cell">요청자</th>
                                                <th class="cell">결재 요청 시간</th>
                                                <th class="cell">이메일</th>
                                                <th class="cell">상태</th>
                                                <th class="cell">상태 변경 시간</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="approval" items="${completedApprovals}">
                                                <tr>
                                                    <td class="cell">${approval.apid}</td>
                                                    <td class="cell"><span class="truncate">${approval.name}</span></td> <!-- name으로 변경 -->
                                                    <td class="cell">${approval.nickname}</td>
                                                    <td class="cell">${approval.formattedRequestDateTime}</td> <!-- 결재 요청 시간 -->
                                                    <td class="cell"><span>${approval.email}</span></td>
                                                    <td class="cell">
                                                        <span class="status-completed">${approval.approvalStatus}</span>
                                                    </td>
                                                    <td class="cell">${approval.formattedStatusUpdateDateTime}</td> <!-- 상태 변경 시간 -->
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--//tab-content-->
            </div><!--//container-fluid-->
        </div><!--//app-content-->

        <footer class="app-footer">
            <div class="container text-center py-3">
                <small class="copyright">Designed with by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
            </div>
        </footer><!--//app-footer-->
    </div><!--//app-wrapper-->
    
    <!-- 보류 사유 입력 모달 -->
<div id="reject-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeRejectModal()">&times;</span>
        <h2>보류 사유 입력</h2>
        <textarea id="reject-reason" placeholder="보류 사유를 입력하세요..."></textarea>
        <button type="button" class="btn btn-primary" onclick="submitRejectReason()">보류</button>
    </div>
</div>
    

    <!-- Javascript -->
    <script src="assets/plugins/popper.min.js"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="assets/js/app.js"></script>

    <!-- 상태 업데이트를 위한 스크립트 -->
    <script>
    let currentApid = null; // 현재 보류 처리 중인 결재 번호

    function updateApprovalStatus(apid, status) {
        if (!apid || !status) {
            console.error("APID 또는 Status가 누락되었습니다.");
            return;
        }

        if (status === '보류') {
            currentApid = apid;
            document.getElementById('reject-modal').style.display = 'block';
        } else {
            console.log(`Sending approval update request for APID: ${apid} with Status: ${status}`);
            $.ajax({
                type: "POST",
                url: "/updateApprovalStatus",
                data: { apid: apid, status: status },
                success: function(response) {
                    console.log("Response:", response);
                    alert(response);
                    location.reload(); // 페이지 새로고침으로 상태 반영
                },
                error: function(xhr, status, error) {
                    console.error("Status: ", status);
                    console.error("Error: ", error);
                    console.error("Response: ", xhr.responseText);
                    alert("서버와의 통신 중 오류가 발생했습니다.");
                }
            });
        }
    }


    function submitRejectReason() {
        const reason = document.getElementById('reject-reason').value;
        if (!reason) {
            alert("보류 사유를 입력하세요.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "/updateApprovalStatus",
            data: { apid: currentApid, status: '보류', reason: reason },
            success: function(response) {
                console.log("Response:", response);
                alert(response);
                closeRejectModal();
                location.reload(); // 페이지 새로고침으로 상태 반영
            },
            error: function(xhr, status, error) {
                console.error("Status: ", status);
                console.error("Error: ", error);
                console.error("Response: ", xhr.responseText);
                alert("서버와의 통신 중 오류가 발생했습니다.");
            }
        });
    }
    function closeRejectModal() {
        document.getElementById('reject-modal').style.display = 'none';
        document.getElementById('reject-reason').value = '';
    }

    </script>
</body>
</html>
