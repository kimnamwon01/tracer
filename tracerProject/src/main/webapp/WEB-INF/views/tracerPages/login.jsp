<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="ko"> 
<head>
    
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <meta name="description" content="Portal - Bootstrap 5 Admin Dashboard Template For Developers">
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
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	if(${loginFailed==null?0:1}>0)
		alert("아이디와 비밀번호가 유효하지 않습니다.")
		$('#login-form').on('submit', function(event){
	        event.preventDefault(); // 폼 제출 막기

	        var email = $('#signin-email').val();
	        var password = $('#signin-password').val();

	        $.ajax({
				data: $("form").serialize(),
				url: 'chkAuth',
				type: 'POST',
				success: function(data){
					if(data=="권한인정성공"){
						$('#login-form').off('submit').submit();
					} else {
						alert('권한이 없습니다.')
					}
				},
				error: function(err){
					console.log(err)
				}
			})
	    });
})
</script>
<body class="app app-login p-0">    	
    <div class="row g-0 app-auth-wrapper">
	    <div class="col-12 col-md-7 col-lg-6 auth-main-col text-center p-5">
		    <div class="d-flex flex-column align-content-end">
			    <div class="app-auth-body mx-auto">	
				    <div class="app-auth-branding mb-4"><a class="app-logo" href="logout"><img class="logo-icon me-2" src="image/logo.png" alt="logo"></a></div>
					<h2 class="auth-heading text-center mb-5">TRACER 로그인</h2>
			        <div class="auth-form-container text-start">
						<form id="login-form" action="${pageContext.request.contextPath}/login" method="post">
							<div class="email mb-3">
								<input id="signin-email" name="email" type="email" class="form-control signin-email" placeholder="이메일 입력" required="required">
							</div><!--//form-group-->
							<div class="password mb-3">
								<input id="signin-password" name="password" type="password" class="form-control signin-password" placeholder="비밀번호 입력" required="required">
								<div class="extra mt-3 row justify-content-between">
									<div class="col-6">
										
									</div><!--//col-6-->
									<div class="col-6">
										<div class="forgot-password text-end">
											<a href="reset_password">비밀번호를 잊으셨나요?</a>
										</div>
									</div><!--//col-6-->
								</div><!--//extra-->
							</div><!--//form-group-->
							<div class="text-center">
								<button type="submit" class="btn app-btn-primary w-100 theme-btn mx-auto">로그인</button>
							</div>
						</form>
						
						<div class="auth-option text-center pt-5">계정이 없으신가요? 회원가입은 <a class="text-link" href="signup" >여기에서</a>.</div>
					</div><!--//auth-form-container-->	

			    </div><!--//auth-body-->
		    
			    <footer class="app-auth-footer">
				    <div class="container text-center py-3">
				         <!--/* This template is free as long as you keep the footer attribution link. If you'd like to use the template without the attribution link, you can buy the commercial license via our website: themes.3rdwavemedia.com Thank you for your support. :) */-->
			        <small class="copyright">Designed with by <a class="app-link" href="http://themes.3rdwavemedia.com" target="_blank">Xiaoying Riley</a> for developers</small>
				       
				    </div>
			    </footer><!--//app-auth-footer-->	
		    </div><!--//flex-column-->   
	    </div><!--//auth-main-col-->
	    <div class="col-12 col-md-5 col-lg-6 h-100 auth-background-col">
		    <div class="auth-background-holder">
		    </div>
		    <div class="auth-background-mask"></div>
		    <div class="auth-background-overlay p-3 p-lg-5">
			    <div class="d-flex flex-column align-content-end h-100">
				    <div class="h-100"></div>
				</div>
		    </div><!--//auth-background-overlay-->
	    </div><!--//auth-background-col-->
    
    </div><!--//row-->


</body>
</html> 

