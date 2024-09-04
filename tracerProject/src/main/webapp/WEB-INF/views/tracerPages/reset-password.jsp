<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko"> 
<head>
    <title>Portal - Bootstrap 5 Admin Dashboard Template For Developers</title>
    
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
	if(${msg!=null})
		alert("${msg}")
	$('form').on('keydown', 'input', function(event) {
         if (event.keyCode === 13) { 
               event.preventDefault();
               return false;
         }
    });
	$('.resetBtn').click(function(){
		$.ajax({
			data: $("form").serialize(),
			url: 'emailDupChk',
			type: 'POST',
			success: function(data){
				if(data=="이미 가입된 이메일입니다"){
					$.ajax({
						data: $("form").serialize(),
						url: 'mail/sendResetPwd',
						type: 'POST',
						success: function(data){
							$("input[type=hidden]").val(data)
							$.ajax({
								data: $("form").serialize(),
								url: 'chgPwd',
								type: 'POST',
								success: function(){
									alert('임시비밀번호가 전송되었습니다.')
									location.href = 'login'
								},
								error: function(err){
									console.log(err)
								}
							})
						},
						error: function(err){
							console.log(err)
						}
					})
				}else	alert('해당하는 이메일이 존재하지 않습니다.')
			},
			error: function(err){
				console.log(err)
			}
		})
	})
})
</script>
<body class="app app-reset-password p-0">    	
    <div class="row g-0 app-auth-wrapper">
	    <div class="col-12 col-md-7 col-lg-6 auth-main-col text-center p-5">
		    <div class="d-flex flex-column align-content-end">
			    <div class="app-auth-body mx-auto">	
				    <div class="app-auth-branding mb-4"><a class="app-logo" href="reset_password"><img class="logo-icon me-2" src="image/logo.png" alt="logo"></a></div>
					<h2 class="auth-heading text-center mb-4">비밀번호 초기화</h2>

					<div class="auth-intro mb-4 text-center">이메일 주소를 입력하세요. <br>입력한 이메일으로 새 비밀번호를 보내드립니다.</div>
	
					<div class="auth-form-container text-left">
						
						<form class="auth-form resetpass-form">
							<input type="hidden" name="password"/>                
							<div class="email mb-3">
								<input id="reg-email" name="email" type="email" class="form-control login-email" placeholder="이메일 입력" required="required">
							</div><!--//form-group-->
							<div class="text-center">
								<button type="button" class="resetBtn btn app-btn-primary btn-block theme-btn mx-auto">초기화하기</button>
							</div>
						</form>
						
						<div class="auth-option text-center pt-5"><a class="app-link" href="login" >로그인 페이지로</a> <span class="px-2">|</span> <a class="app-link" href="signup" >회원가입 페이지로</a></div>
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
		    </div>
	    </div>
    
    </div>


</body>
</html> 

