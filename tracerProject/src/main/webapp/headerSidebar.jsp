
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setBundle basename="messages" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap JavaScript (Bootstrap 5 이상은 Popper.js 포함) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery UI (선택사항) -->
<script src="${path}/a00_com/jquery-ui.js"></script>

<!-- Vue.js (선택사항) -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<!-- 추가적인 스크립트들 -->
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<script type="text/javascript">
	var auth = '${user_info.auth}'
	var pid = '${user_info.pid}'
	var tid = '${user_info.tid}'
	$(document).ready(function() {

		if (auth == 'noauth' || auth == '') {
			alert('권한이 존재하지 않습니다')
			location.href = 'login'
		}
		if (auth != 'admin' && pid == '0') {
			$('.noAdminOrNoPrj').hide()
		}
		if (auth == 'manager') {
			$('.nomgr').hide()
		}
		if (auth == 'member') {
			$('.nomem').hide()
		}
		if (pid == '0') {
			$('.noprj').hide()
		}
		if (tid == '0') {
			$('.noteam').hide()
		}

		// 채팅 모달 초기화
		$('#chatModal').hide();

		// 채팅 버튼 클릭 이벤트
		$('.openChatBtn').click(function() {
			$('#chatModal').show();
		});

		// 모달 닫기 버튼 클릭 이벤트
		$('.closeChatModal').click(function() {
			$('#chatModal').hide();
		});

	})
</script>
<header class="app-header fixed-top">
	<div class="app-header-inner">
		<div class="container-fluid py-2">
			<div class="app-header-content">
				<div class="row justify-content-between align-items-center">
					<div class="col-auto">
						<a id="sidepanel-toggler"
							class="sidepanel-toggler d-inline-block d-xl-none" href="#">
							<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
								viewBox="0 0 30 30" role="img">
								<title>Menu</title><path stroke="currentColor"
									stroke-linecap="round" stroke-miterlimit="10" stroke-width="2"
									d="M4 7h22M4 15h22M4 23h22"></path></svg>
						</a>
					</div>
					<!--//col-->
					<div class="search-mobile-trigger d-sm-none col">
						<i class="search-mobile-trigger-icon fa-solid fa-magnifying-glass"></i>
					</div>
					<!--//col-->
					<div class="app-search-box col">
						<form class="app-search-form">
							<input type="text"
								placeholder="<fmt:message key='search.placeholder'/>"
								name="search" class="form-control search-input">
							<button type="submit" class="btn search-btn btn-primary"
								value="Search">
								<i class="fa-solid fa-magnifying-glass"></i>
							</button>
						</form>
					</div>
					<!--//app-search-box-->
					<div class="app-utilities col-auto">
						<div class="app-utility-item">
							<a href="account" title="내 정보 관리"> <!--//Bootstrap Icons: https://icons.getbootstrap.com/ -->
								<svg width="1em" height="1em" viewBox="0 0 16 16"
									class="bi bi-gear icon" fill="currentColor"
									xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
										d="M8.837 1.626c-.246-.835-1.428-.835-1.674 0l-.094.319A1.873 1.873 0 0 1 4.377 3.06l-.292-.16c-.764-.415-1.6.42-1.184 1.185l.159.292a1.873 1.873 0 0 1-1.115 2.692l-.319.094c-.835.246-.835 1.428 0 1.674l.319.094a1.873 1.873 0 0 1 1.115 2.693l-.16.291c-.415.764.42 1.6 1.185 1.184l.292-.159a1.873 1.873 0 0 1 2.692 1.116l.094.318c.246.835 1.428.835 1.674 0l.094-.319a1.873 1.873 0 0 1 2.693-1.115l.291.16c.764.415 1.6-.42 1.184-1.185l-.159-.291a1.873 1.873 0 0 1 1.116-2.693l.318-.094c.835-.246.835-1.428 0-1.674l-.319-.094a1.873 1.873 0 0 1-1.115-2.692l.16-.292c.415-.764-.42-1.6-1.185-1.184l-.291.159A1.873 1.873 0 0 1 8.93 1.945l-.094-.319zm-2.633-.283c.527-1.79 3.065-1.79 3.592 0l.094.319a.873.873 0 0 0 1.255.52l.292-.16c1.64-.892 3.434.901 2.54 2.541l-.159.292a.873.873 0 0 0 .52 1.255l.319.094c1.79.527 1.79 3.065 0 3.592l-.319.094a.873.873 0 0 0-.52 1.255l.16.292c.893 1.64-.902 3.434-2.541 2.54l-.292-.159a.873.873 0 0 0-1.255.52l-.094.319c-.527 1.79-3.065 1.79-3.592 0l-.094-.319a.873.873 0 0 0-1.255-.52l-.292.16c-1.64.893-3.433-.902-2.54-2.541l.159-.292a.873.873 0 0 0-.52-1.255l-.319-.094c-1.79-.527-1.79-3.065 0-3.592l.319-.094a.873.873 0 0 0 .52-1.255l-.16-.292c-.892-1.64.902-3.433 2.541-2.54l.292.159a.873.873 0 0 0 1.255-.52l.094-.319z" />
                                    <path fill-rule="evenodd"
										d="M8 5.754a2.246 2.246 0 1 0 0 4.492 2.246 2.246 0 0 0 0-4.492zM4.754 8a3.246 3.246 0 1 1 6.492 0 3.246 3.246 0 0 1-6.492 0z" />
                                </svg>
							</a>
						</div>
						<!--//app-utility-item-->
						<%-- <div class="app-utility-item app-user-dropdown dropdown">
                            <ul class="dropdown-menu" aria-labelledby="user-dropdown-toggle">
                                <li><a class="dropdown-item" href="account"><fmt:message key='user.management'/></a></li>
                                <li><a class="dropdown-item" href="settings.jsp"><fmt:message key='settings'/></a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="logout"><fmt:message key='logout'/></a></li>
                            </ul>
                        </div><!--//app-user-dropdown-->  --%>
						<div class="app-utility-item app-user-dropdown">
							<a class="btn" href="logout" role="button" aria-expanded="false">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none"
									viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
									class="size-6" style="width: 24px; height: 24px;">
            <path stroke-linecap="round" stroke-linejoin="round"
										d="M5.636 5.636a9 9 0 1 0 12.728 0M12 3v9" />
        </svg> <fmt:message key='logout' />
							</a>
						</div>
						<!--//app-user-dropdown-->
					</div>
					<!--//app-utilities-->
				</div>
				<!--//row-->
			</div>
			<!--//app-header-content-->
		</div>
		<!--//container-fluid-->
	</div>
	<!--//app-header-inner-->
	<div id="app-sidepanel" class="app-sidepanel">
		<div id="sidepanel-drop" class="sidepanel-drop"></div>
		<div class="sidepanel-inner d-flex flex-column">
			<a href="#" id="sidepanel-close" class="sidepanel-close d-xl-none">&times;</a>
			<div class="app-branding">
				<a class="app-logo"
					href="index${user_info.auth == 'member' ? 'U' : 'M'}"><img
					class="logo-icon me-2" src="image/logo.png" alt="logo"><span
					class="logo-text">TRACER</span></a>
			</div>
			<!--//app-branding-->
			<nav id="app-nav-main" class="app-nav app-nav-main flex-grow-1">
				<ul class="app-menu list-unstyled accordion" id="menu-accordion">
					<li class="nav-item"><a class="nav-link"
						href="index${user_info.auth == 'member' ? 'U' : 'M'}"> <span
							class="nav-icon"> <svg width="1em" height="1em"
									viewBox="0 0 16 16" class="bi bi-house-door"
									fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
										d="M7.646 1.146a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 .146.354v7a.5.5 0 0 1-.5.5H9.5a.5.5 0 0 1-.5-.5v-4H7v4a.5.5 0 0 1-.5.5H2a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .146-.354l6-6zM2.5 7.707V14H6v-4a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5v4h3.5V7.707L8 2.207l-5.5 5.5z" />
                                    <path fill-rule="evenodd"
										d="M13 2.5V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z" />
                                </svg>
						</span> <span>대시보드 [통합 관리]</span>
					</a> <!--//nav-link--></li>
					<!--//nav-item-->
					<li class="nav-item dropdown"><a
						class="nav-link submenu-toggle" href="#" data-bs-toggle="collapse"
						data-bs-target="#project-submenu" aria-expanded="false"
						aria-controls="project-submenu"> <span class="nav-icon">
								<svg width="1em" height="1em" viewBox="0 0 24 24" fill="none"
									stroke-width="1.5" stroke="currentColor" class="bi bi-folder">
                <path stroke-linecap="round" stroke-linejoin="round"
										d="M3.75 3v11.25A2.25 2.25 0 0 0 6 16.5h2.25M3.75 3h-1.5m1.5 0h16.5m0 0h1.5m-1.5 0v11.25A2.25 2.25 0 0 1 18 16.5h-2.25m-7.5 0h7.5m-7.5 0-1 3m8.5-3 1 3m0 0 .5 1.5m-.5-1.5h-9.5m0 0-.5 1.5M9 11.25v1.5M12 9v3.75m3-6v6" />
            </svg>
						</span> <span class="nav-link-text">프로젝트 관리 [범위 관리]</span> <span
							class="submenu-arrow"> <svg width="1em" height="1em"
									viewBox="0 0 16 16" class="bi bi-chevron-down"
									fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
										d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z" />
            </svg>
						</span>
					</a>
						<div id="project-submenu" class="collapse submenu">
							<ul class="submenu-list list-unstyled">
								<li class="submenu-item"><a class="submenu-link nomem"
									href="newPrj"><span class="nav-link-text">새 프로젝트 생성</span></a></li>
								<li class="submenu-item"><a
									class="submenu-link nomem nomgr" href="prjList"><span
										class="nav-link-text">프로젝트 목록</span></a></li>
								<li class="submenu-item"><a class="submenu-link noprj"
									href="${user_info.auth == 'member' ? 'prjInfo' : 'prjDetail'}?pid=${user_info.pid}"><span
										class="nav-link-text">프로젝트정보</span></a></li>
								<li class="submenu-item"><a class="submenu-link noprj"
									href="teamList?pid=${user_info.pid}"><span
										class="nav-link-text">팀 목록</span></a></li>
								<li class="submenu-item"><a
									class="submenu-link nomem noprj" href="newTeam"><span
										class="nav-link-text"> 팀 생성하기</span></a></li>
								<li class="submenu-item"><a class="submenu-link noteam"
									href="${user_info.auth == 'member' ? 'teamInfo' : 'teamDetail'}?tid=${user_info.tid}"><span
										class="nav-link-text">팀 정보</span></a></li>
							</ul>
						</div></li>
					<!--//nav-item-->
					<li class="nav-item noAdminOrNoPrj"><a class="nav-link"
						href="timeline"> <span class="nav-icon"> <svg
									width="1em" height="1em" viewBox="0 0 24 24" fill="none"
									stroke-width="1.5" stroke="currentColor" class="bi bi-folder">
  							<path stroke-linecap="round" stroke-linejoin="round"
										d="M3.75 6.75h16.5M3.75 12H12m-8.25 5.25h16.5" />
                                </svg>
						</span> <span>간트 차트[일정 관리]</span>
					</a> <!--//nav-link--></li>
					<!--//nav-item-->
					<li class="nav-item noAdminOrNoPrj"><a class="nav-link"
						href="calendar"> <span class="nav-icon"> <svg
									width="1em" height="1em" viewBox="0 0 24 24" fill="none"
									stroke-width="1.5" stroke="currentColor"
									class="bi bi-house-door">
							  <path stroke-linecap="round" stroke-linejoin="round"
										d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5m-9-6h.008v.008H12v-.008ZM12 15h.008v.008H12V15Zm0 2.25h.008v.008H12v-.008ZM9.75 15h.008v.008H9.75V15Zm0 2.25h.008v.008H9.75v-.008ZM7.5 15h.008v.008H7.5V15Zm0 2.25h.008v.008H7.5v-.008Zm6.75-4.5h.008v.008h-.008v-.008Zm0 2.25h.008v.008h-.008V15Zm0 2.25h.008v.008h-.008v-.008Zm2.25-4.5h.008v.008H16.5v-.008Zm0 2.25h.008v.008H16.5V15Z" />
							</svg>

						</span> <span>캘린더[일정 관리]</span>
					</a> <!--//nav-link--></li>
					<!--//nav-item-->
					<li class="nav-item has-submenu"><a
						class="nav-link submenu-toggle" href="#" data-bs-toggle="collapse"
						data-bs-target="#submenu-1" aria-expanded="false"
						aria-controls="submenu-1"> <span class="nav-icon"> <svg
									width="1em" height="1em" viewBox="0 0 16 16"
									class="bi bi-files" fill="currentColor"
									xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
										d="M4 2h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2zm0 1a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h7a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H4z" />
                                    <path
										d="M6 0h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2v-1a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H6a1 1 0 0 0-1 1H4a2 2 0 0 1 2-2z" />
                                </svg>
						</span> <span class="nav-link-text"><fmt:message key='boards' /></span>
							<span class="submenu-arrow"> <svg width="1em" height="1em"
									viewBox="0 0 16 16" class="bi bi-chevron-down"
									fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
										d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z" />
                                </svg>
						</span> <!--//submenu-arrow-->
					</a> <!--//nav-link-->
						<div id="submenu-1" class="collapse submenu submenu-1"
							data-bs-parent="#menu-accordion">
							<ul class="submenu-list list-unstyled">
								<li class="submenu-item"><a class="submenu-link" href="riskBoard"><fmt:message
											key='risk.management.board' /></a></li>
								<li class="submenu-item"><a class="submenu-link"
									href="newTask"><fmt:message key='schedule.board' /></a></li>
								<li class="submenu-item nomem"><a class="submenu-link"
									href="newApproval"><fmt:message key='approval.board' /></a></li>
								<li class="submenu-item"><a class="submenu-link"
									href="Notice"><fmt:message key='notice.board' /></a></li>
							</ul>
						</div></li>
					<!--//nav-item-->
					<li class="nav-item has-submenu"><a
						class="nav-link submenu-toggle" href="#" data-bs-toggle="collapse"
						data-bs-target="#chat-submenu" aria-expanded="false"
						aria-controls="chat-submenu"> <span class="nav-icon"> <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6" style="width: 24px; height: 24px;">
            <path stroke-linecap="round" stroke-linejoin="round" d="M21.25 8.25V15a2.25 2.25 0 0 1-2.25 2.25h-4.5L12 20.25V17.25H5.75A2.25 2.25 0 0 1 3.5 15V8.25A2.25 2.25 0 0 1 5.75 6h13A2.25 2.25 0 0 1 21.25 8.25Z"/>
        </svg>
						</span> <span class="nav-link-text">채팅[의사소통 관리]</span> <span
							class="submenu-arrow"> <svg width="1em" height="1em"
									viewBox="0 0 16 16" class="bi bi-chevron-down"
									fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
										d="M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z" />
            </svg>
						</span>
					</a>
						<div id="chat-submenu" class="collapse submenu">
							<ul class="submenu-list list-unstyled">
								<li class="submenu-item"><a class="submenu-link" href="#"
									onclick="openChat('group')">단체 채팅</a></li>
								<li class="submenu-item"><a class="submenu-link" href="#"
									onclick="openChat('private')">개인 채팅</a></li>
							</ul>
						</div></li>

					<!--//nav-item-->
					<script>
						function openChatWindow(url) {
							window.open(url, "ChatWindow",
									"width=1000,height=800");
						}
						function openChat(chatType) {
							var chatUrl = chatType === 'group' ? '/chatting'
									: '/private-chat';
							document.getElementById('chatIframe').src = chatUrl;
							$('#chatModal').show();
						}
					</script>
					<!-- 채팅 모달 -->
					<div id="chatModal" class="modal" tabindex="-1">

						<div class="modal-dialog" style="max-width: 80%; width: 1200px;">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">채팅</h5>
									<button type="button" class="btn-close closeChatModal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" style="height: 700px;">
									<iframe id="chatIframe" src="/chatting" width="100%"
										height="100%" frameborder="0"></iframe>
								</div>
							</div>
						</div>
					</div>
					<!-- 프로젝트 관련 드롭다운 메뉴 -->


					<li class="nav-item nomem nomgr"><a class="nav-link"
						href="userManagement"> <span class="nav-icon"> <svg
									width="1em" height="1em" viewBox="0 0 24 24" fill="none"
									stroke-width="1.5" stroke="currentColor"
									class="bi bi-house-door">
					  <path stroke-linecap="round" stroke-linejoin="round"
										d="M10.5 6h9.75M10.5 6a1.5 1.5 0 1 1-3 0m3 0a1.5 1.5 0 1 0-3 0M3.75 6H7.5m3 12h9.75m-9.75 0a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m-3.75 0H7.5m9-6h3.75m-3.75 0a1.5 1.5 0 0 1-3 0m3 0a1.5 1.5 0 0 0-3 0m-9.75 0h9.75" />
					</svg>
						</span> <span>사용자 관리[자원 관리]</span>
					</a></li>

					<li class="nav-item nomem nomgr"><a class="nav-link"
						href="resource"> <span class="nav-icon"> <svg
									xmlns="http://www.w3.org/2000/svg" fill="none"
									viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
									class="size-6" style="width: 24px; height: 24px;">
                <path stroke-linecap="round" stroke-linejoin="round"
										d="M3 7a2 2 0 0 1 2-2h4l2 2h7a2 2 0 0 1 2 2v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7z" />
            </svg>
						</span> <span>자원 관리</span>
					</a></li>
				</ul>
				<!--//app-menu-->
			</nav>
			<!--//app-nav-->
			<div class="app-sidepanel-footer">
				<nav class="app-nav app-nav-footer">
					<ul class="app-menu footer-menu list-unstyled">
						<li class="nav-item">&nbsp; TRACER<br> <br>
						</li>
						<!--//nav-item-->
					</ul>
					<!--//footer-menu-->
				</nav>
			</div>
			<!--//app-sidepanel-footer-->
		</div>
		<!--//sidepanel-inner-->
	</div>
	<!--//app-sidepanel-->
</header>
<!--//app-header-->
