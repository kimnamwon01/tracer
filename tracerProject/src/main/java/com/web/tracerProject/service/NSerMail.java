package com.web.tracerProject.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;


@AllArgsConstructor
@Service
public class NSerMail {
	private JavaMailSender mailSender;
	// 이메일 인증번호 전송
	public String sendEmailChk(@Param("email") String email) {
		String chkNum = random();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("gimnamwon3131@gmail.com");
		message.setTo(email);
		message.setSubject("TRACER::인증번호 전송");
		message.setText(
				" -------------------------------- \n"
				+ "인증번호\n\n"
				+ chkNum
				+ "\n\n------------------------------- \n"
				+ "바로가기 : http://192.168.0.10:5656/login"
		);
		try {
			mailSender.send(message);
		} catch (MailException e) {
			return "메일전송실패";
		}	
		return chkNum;
	}
	
	// 비밀번호 초기화 시 메일로 랜덤 비밀번호 전송
	public String sendResetPwd(@Param("email") String email) {
		String newPwd = random();
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("gimnamwon3131@gmail.com");
		message.setTo(email);
		message.setSubject("TRACER::비밀번호 초기화");
		message.setText(
				" -------------------------------- \n"
				+ "임시 비밀번호\n\n"
				+ newPwd+"\n"
				+ "빠른 시일 내에 비밀번호 변경을 권장드립니다."
				+ "\n\n------------------------------- \n"
				+ "바로가기 : http://192.168.0.10:5656/login"
		);
			mailSender.send(message);
			System.out.println(email);
			
	return newPwd;
	}
	// 회원가입 완료 환영메일
	public String sendSingupSuccess(@Param("email") String email
										, @Param("nickname") String nickname ) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("gimnamwon3131@gmail.com");
		message.setTo(email);
		message.setSubject("TRACER::" + nickname + "님의 회원가입을 진심으로 축하합니다.");
		message.setText(
				" -------------------------------- \n"
				+ "회원가입을 환영합니다\n\n"
				+ "TRACER PMS 서비스\n\n"
				+ "회원가입 절차가 완료되었습니다.\n"
				+ "로그인 후 서비스를 이용해 주시기 바랍니다.\n"
				+ "------------------------------- \n"
				+ "바로가기 : http://192.168.0.10:5656/login"
				);
		try {
			mailSender.send(message);
		} catch (MailException e) {
			return "메일전송실패";
		}
		
		return "메일전송완료";
	}
	// 인증번호 / 비밀번호 초기화 랜덤 값 생성
	String random() {
		StringBuilder sb = new StringBuilder();
		for(int i=0;i<8;i++) {
			int ran = (int)(Math.random()*102);
			if(ran<50) {
				sb.append(ran%10);
			}else if(ran<76) {
				ran = ran + 'A' - 50;
				sb.append((char)ran);
			}else {
				ran = ran + 'a' - 76;
				sb.append((char)ran);
			}
		}
		return sb.toString();
	}
}
