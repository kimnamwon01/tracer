package com.web.tracerProject.service;

import java.util.List;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class G_Noticemail {
    private final JavaMailSender mailSender;

    public void sendNoticeEmail(List<String> recipients, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("gimnamwon3131@gmail.com");
        message.setSubject(subject);
        message.setText(text);

        for (String recipient : recipients) {
            message.setTo(recipient);
            mailSender.send(message);
        }
    }
}