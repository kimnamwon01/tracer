<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:setLocale
	value="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE']}" />
<fmt:setBundle basename="messages" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="ko">
<head>
<title><fmt:message key="user.management.title" /></title>
<!-- Meta -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
<meta name="author" content="Xiaoying Riley at 3rd Wave Media">
<link rel="shortcut icon" href="favicon.ico">
<!-- FontAwesome JS-->
<script defer src="assets/plugins/fontawesome/js/all.min.js"></script>
<!-- App CSS -->
<link id="theme-style" rel="stylesheet" href="assets/css/portal.css">
</head>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>
<body class="app">
	<jsp:include page="/headerSidebar.jsp" />
	<div class="app-wrapper">
		<div class="app-content pt-3 p-md-3 p-lg-4">
			<div class="container-xl">
				<h1 class="app-page-title">
					<fmt:message key="user.management.title" />
				</h1>
				<div class="row gy-4">
					<div class="col-12 col-lg-6">
						<div
							class="app-card app-card-account shadow-sm d-flex flex-column align-items-start">
							<div class="app-card-header p-3 border-bottom-0">
								<div class="row align-items-center gx-3">
									<div class="col-auto">
										<div class="app-icon-holder">
											<svg width="1em" height="1em" viewBox="0 0 16 16"
												class="bi bi-person" fill="currentColor"
												xmlns="http://www.w3.org/2000/svg">
                                                <path
													fill-rule="evenodd"
													d="M10 5a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6 5c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z" />
                                            </svg>
										</div>
										<!--//icon-holder-->
									</div>
									<!--//col-->
									<div class="col-auto">
										<h4 class="app-card-title">
											<fmt:message key="profile.title" />
										</h4>
									</div>
									<!--//col-->
								</div>
								<!--//row-->
							</div>
							<!--//app-card-header-->
							<div class="app-card-body px-4 w-100">
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="name" /></strong>
											</div>
											<div class="item-data">${user_info.name }</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<button class="btn-sm app-btn-secondary"
												data-bs-toggle="tooltip" data-bs-placement="left"
												title="<fmt:message key='cannot.change.name'/>" disabled>
												<fmt:message key="cannot.change" />
											</button>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="email" /></strong>
											</div>
											<div class="item-data">${user_info.email }</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<button class="btn-sm app-btn-secondary"
												data-bs-toggle="tooltip" data-bs-placement="left"
												title="<fmt:message key='cannot.change.email'/>" disabled>
												<fmt:message key="cannot.change" />
											</button>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="nickname" /></strong>
											</div>
											<div class="item-data">${user_info.nickname }</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary" href="#"
												id="changeNicknameBtn"><fmt:message
													key="nickname.change" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->

								<!-- 닉네임 변경 모달 -->
								<div class="modal" id="changeNicknameModal" tabindex="-1"
									role="dialog">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title">
													<fmt:message key="nickname.change" />
												</h5>
												<button type="button" class="close" data-bs-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<input type="text" class="form-control" id="newNickname"
													placeholder="<fmt:message key='nickname.new'/>">
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">
													<fmt:message key="close" />
												</button>
												<button type="button" class="btn btn-primary"
													id="saveNicknameBtn">
													<fmt:message key="save" />
												</button>
											</div>
										</div>
									</div>
								</div>

								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="phone" /></strong>
											</div>
											<div class="item-data">${user_info.phone }</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary" href="#"
												id="changePhoneBtn"><fmt:message key="phone.change" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="change.password" /></strong>
											</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary showChgPwd" href="#"
												id="changePhoneBtn"><fmt:message key="change.password" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->

								<!-- 전화번호 변경 모달 -->
								<div class="modal" id="changePhoneModal" tabindex="-1"
									role="dialog">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title">
													<fmt:message key="phone.change" />
												</h5>
												<button type="button" class="close" data-bs-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<input type="text" class="form-control" id="newPhone"
													placeholder="<fmt:message key='phone.new'/>">
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">
													<fmt:message key="close" />
												</button>
												<button type="button" class="btn btn-primary"
													id="savePhoneBtn">
													<fmt:message key="save" />
												</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--//app-card-body-->
						</div>
						<!--//app-card-->
					</div>
					<!--//col-->
					<div class="col-12 col-lg-6">
						<div
							class="app-card app-card-account shadow-sm d-flex flex-column align-items-start">
							<div class="app-card-header p-3 border-bottom-0">
								<div class="row align-items-center gx-3">
									<div class="col-auto">
										<div class="app-icon-holder">
											<svg width="1em" height="1em" viewBox="0 0 16 16"
												class="bi bi-sliders" fill="currentColor"
												xmlns="http://www.w3.org/2000/svg">
                                                <path
													fill-rule="evenodd"
													d="M11.5 2a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM9.05 3a2.5 2.5 0 0 1 4.9 0H16v1h-2.05a2.5 2.5 0 0 1-4.9 0H0V3h9.05zM4.5 7a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM2.05 8a2.5 2.5 0 0 1 4.9 0H16v1H6.95a2.5 2.5 0 0 1-4.9 0H0V8h2.05zm9.45 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zm-2.45 1a2.5 2.5 0 0 1 4.9 0H16v1h-2.05a2.5 2.5 0 0 1-4.9 0H0v-1h9.05z" />
                                            </svg>
										</div>
										<!--//icon-holder-->
									</div>
									<!--//col-->
									<div class="col-auto">
										<h4 class="app-card-title">
											<fmt:message key="settings.title" />
										</h4>
									</div>
									<!--//col-->
								</div>
								<!--//row-->
							</div>
							<!--//app-card-header-->
							<div class="app-card-body px-4 w-100">
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="language" /></strong>
											</div>
											<div class="item-data">
												<c:choose>
													<c:when
														test="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'].language == 'ko'}">
														한국어
													</c:when>
													<c:otherwise>
            											English
        											</c:otherwise>
												</c:choose>
											</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<c:choose>
												<c:when
													test="${sessionScope['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'].language == 'ko'}">
													<a class="btn-sm app-btn-secondary"
														href="/changeLanguage?lang=en"><fmt:message
															key="change.to.english" /></a>
												</c:when>
												<c:otherwise>
													<a class="btn-sm app-btn-secondary"
														href="/changeLanguage?lang=ko"><fmt:message
															key="change.to.korean" /></a>
												</c:otherwise>
											</c:choose>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="timezone" /></strong>
											</div>
											<div class="item-data">Central Standard Time (UTC-6)</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary" href="#"><fmt:message
													key="change" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="currency" /></strong>
											</div>
											<div class="item-data">$(US Dollars)</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary" href="#"><fmt:message
													key="change" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="email.notifications" /></strong>
											</div>
											<div class="item-data">Off</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary" href="#"><fmt:message
													key="change" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
								<div class="item border-bottom py-3">
									<div class="row justify-content-between align-items-center">
										<div class="col-auto">
											<div class="item-label">
												<strong><fmt:message key="sms.notifications" /></strong>
											</div>
											<div class="item-data">On</div>
										</div>
										<!--//col-->
										<div class="col text-end">
											<a class="btn-sm app-btn-secondary" href="#"><fmt:message
													key="change" /></a>
										</div>
										<!--//col-->
									</div>
									<!--//row-->
								</div>
								<!--//item-->
							</div>
							<!--//app-card-body-->
							<div class="app-card-footer p-4 mt-auto">
								<a class="btn app-btn-primary" href="#" id="deleteAccountBtn"><fmt:message
										key="delete.account" /></a>
							</div>
							<!--//app-card-footer-->

							<!-- 회원 탈퇴 모달 -->
							<div class="modal" id="deleteAccountModal" tabindex="-1"
								role="dialog">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">
												<fmt:message key="delete.account" />
											</h5>
											<button type="button" class="close" data-bs-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<p>
												<fmt:message key="delete.account.confirm"  />
											</p>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">
												<fmt:message key="close" />
											</button>
											<button type="button" class="btn btn-danger"
												id="confirmDeleteBtn">
												<fmt:message key="delete" />
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!--//app-card-->
					</div>
					<!--//col-->
				</div>
				<!--//row-->
			</div>
			<!--//container-fluid-->
		</div>
		<!--//app-content-->
		<footer class="app-footer">
			<div class="container text-center py-3">
				<!--/* This template is free as long as you keep the footer attribution link. If you'd like to use the template without the attribution link, you can buy the commercial license via our website: themes.3rdwavemedia.com Thank you for your support. :) */-->
				<small class="copyright">Designed with by <a
					class="app-link" href="http://themes.3rdwavemedia.com"
					target="_blank">Xiaoying Riley</a> for developers
				</small>
			</div>
		</footer>
		<!--//app-footer-->
	</div>
	<!--//app-wrapper-->

	<div class="modal chgPwd" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<fmt:message key="password.change" />
					</h5>
					<button type="button" class="btn-close clsBtn"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<form>
					<div class="modal-body">
						<label for="email"><fmt:message key="email" /></label> <input
							type="email" value="${user_info.email }" name="email"
							class="form-control mr-sm-2"
							placeholder="<fmt:message key='email.enter'/>" required readonly /><br>
						<label for="curPwd"><fmt:message key="current.password" /></label>
						<input type="password" name="curPwd" class="form-control mr-sm-2"
							placeholder="<fmt:message key='current.password.enter'/>"
							required /><br> <label for="password"><fmt:message
								key="new.password" /></label> <input type="password" name="password"
							class="form-control mr-sm-2"
							placeholder="<fmt:message key='new.password.enter'/>" required /><br>
						<label for="pwdChk"><fmt:message key="confirm.password" /></label>
						<input type="password" name="pwdChk" class="form-control mr-sm-2"
							placeholder="<fmt:message key='confirm.password.enter'/>"
							required /><br>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary clsBtn"
							data-bs-dismiss="modal">
							<fmt:message key="close" />
						</button>
						<button type="button" class="btn btn-primary chgPwdBtn">
							<fmt:message key="password.change" />
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Javascript -->
	<script src="assets/plugins/popper.min.js"></script>
	<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>

	<!-- Page Specific JS -->
	<script src="assets/js/app.js"></script>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							// 회원 탈퇴 모달 초기화
							$('#deleteAccountBtn').click(function() {
								$('#deleteAccountModal').modal('show');
							});

							$('#confirmDeleteBtn')
									.click(
											function() {
												$
														.ajax({
															url : '/deleteAccount',
															type : 'POST',
															success : function(
																	response) {
																alert(response);
																if (response === '회원 탈퇴 성공') {
																	location.href = '/login'; // 회원 탈퇴 후 로그인 페이지로 이동
																}
															},
															error : function(
																	xhr,
																	status,
																	error) {
																console
																		.error('Error: '
																				+ error);
																alert('회원 탈퇴 중 오류가 발생했습니다. 다시 시도해 주세요.');
															}
														});
											});

							// Enter 키로 인한 폼 제출 방지
							$('form').on('keydown', function(event) {
								if (event.key === 'Enter') {
									event.preventDefault();
								}
							});

							// 비밀번호 변경 모달 초기화
							$(".chgPwd").hide(400)
							$(".showChgPwd").click(function() {
								$(".chgPwd").show(400)
							})
							$(".clsBtn").click(function() {
								$(".chgPwd").hide(400)
							})
							$(".chgPwdBtn")
									.click(
											function() {
												if ($("[name=curPwd]").val() != '${user_info.password}')
													alert("현재 비밀번호가 일치하지 않습니다.")
												else if ($("[name=password]")
														.val() != $(
														"[name=pwdChk]").val())
													alert("변경 비밀번호와 비밀번호 확인이 일치하지 않습니다.")
												else {
													if (confirm('정말로 변경하시겠습니까?'))
														chgPwd()
												}
											});

							// 닉네임 변경 모달 초기화
							$('#changeNicknameBtn').click(function() {
								$('#changeNicknameModal').modal('show');
							});

							$('#saveNicknameBtn').click(function() {
							    var newNickname = $('#newNickname').val().trim();
							    
							    if (newNickname === '') {
							        alert('닉네임을 공백만으로 설정할 수 없습니다.');
							        return;
							    }
							    
							    $.ajax({
							        url: '/updateNickname',
							        type: 'POST',
							        data: { nickname: newNickname },
							        success: function(response) {
							            if (response === '이미 사용 중인 닉네임입니다.') {
							                alert(response);
							            } else if (response === '닉네임 변경 성공: 로그아웃 필요') {
							                alert('닉네임이 변경되었습니다. 다시 로그인해 주세요.');
							                
							                $.ajax({
							                    url: '/memberLogout',
							                    type: 'GET',
							                    success: function() {
							                        window.location.href = '/login'; // 로그인 페이지로 리디렉션
							                    },
							                    error: function(xhr, status, error) {
							                        console.error('Error: ' + error);
							                    }
							                });
							            } else {
							                alert(response);
							            }
							        },
							        error: function(xhr, status, error) {
							            console.error('Error: ' + error);
							        }
							    });
							});

							// 전화번호 변경 모달 초기화
							$('#changePhoneBtn').click(function() {
								$('#changePhoneModal').modal('show');
							});

							$('#savePhoneBtn').click(function() {
							    var newPhone = $('#newPhone').val().trim();
							    var phoneRegex = /^010-\d{4}-\d{4}$/;
							    
							    // 전화번호 형식 확인
							    if (!phoneRegex.test(newPhone)) {
							        alert('전화번호는 010-0000-0000 형태로 입력해야 합니다.');
							        return;
							    }
							    
							    $.ajax({
							        url: '/updatePhone',
							        type: 'POST',
							        data: { phone: newPhone },
							        success: function(response) {
							            alert(response);
							            if (response === '전화번호 변경 성공') {
							                location.reload();
							            }
							        },
							        error: function(xhr, status, error) {
							            console.error('Error: ' + error);
							        }
							    });
							});
						});

		function chgPwd() {
			$.ajax({
				data : $("form").serialize(),
				url : 'chgPwd',
				type : 'POST',
				success : function(data) {
					if (data == "비밀번호변경성공"){
						alert(data + ", 로그인 페이지로 이동합니다.")
						location.href = 'logout'
					}else alert(data)
				},
				error : function(err) {
					console.log(err)
					alert('비밀번호는 영어 대소문자, 숫자, 특수문자로 이루어진 8~20글자만 허용합니다')
				}
			})
		}
	</script>
	<script>
		$(document).ready(
				function() {
					// Initialize Bootstrap tooltips
					var tooltipTriggerList = [].slice.call(document
							.querySelectorAll('[data-bs-toggle="tooltip"]'));
					var tooltipList = tooltipTriggerList.map(function(
							tooltipTriggerEl) {
						return new bootstrap.Tooltip(tooltipTriggerEl);
					});
				});
	</script>

</body>
</html>
