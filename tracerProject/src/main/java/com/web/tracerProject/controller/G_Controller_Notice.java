package com.web.tracerProject.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.web.tracerProject.service.G_Noticemail;
import com.web.tracerProject.service.G_Service_Notice;
import com.web.tracerProject.vo.Notice;
import com.web.tracerProject.vo.NoticeSch;
import com.web.tracerProject.vo.User_info;

import jakarta.servlet.http.HttpSession;

@Controller
public class G_Controller_Notice extends NContBase{
	@Autowired(required=false)
	private G_Service_Notice service;
	 
	@Autowired
    private G_Noticemail gNoticemail; // 이메일 발송 서비스
	
	@Autowired
    private ObjectMapper objectMapper; // ObjectMapper 추가
	
	// http://localhost:5656/Notice
	@GetMapping("/Notice")
	public String notice(@RequestParam(value = "subject", defaultValue = "") String subject,
			@RequestParam(value = "writer", defaultValue = "") String writer,
			@RequestParam(value = "curPage", defaultValue = "1") int curPage,
			@RequestParam(value = "pageSize", defaultValue = "9") int pageSize, HttpSession session, Model d) {

      // NoticeSch 객체 생성 및 초기화
		NoticeSch sch = new NoticeSch();
		sch.setSubject(subject);
		sch.setWriter(writer);
		sch.setCurPage(curPage);
		sch.setPageSize(pageSize);

      // 페이지네이션을 적용한 공지사항 목록을 가져오기
		List<Notice> noticeList = service.getNoticeList(sch);
		d.addAttribute("NoticeList", noticeList);

      // 페이지네이션 관련 정보 설정
		d.addAttribute("currentPage", sch.getCurPage());
		d.addAttribute("totalPages", sch.getPageCount());
		d.addAttribute("pageSize", sch.getPageSize());
		d.addAttribute("count", sch.getCount());  // 총 개수 추가

      // 세션에서 User_info 객체 가져오기
		User_info user_info = (User_info) session.getAttribute("user_info");
		if (user_info != null) {
			d.addAttribute("user_info", user_info);
		}

		return "tracerPages/notice";
	}
	
	 // 공지사항 상세 페이지
	@GetMapping("/noticeDetail")
	public String getNoticeDetail(@RequestParam("vid") String vid, Model model) {
	    Notice notice = service.getNoticeById(vid);
	    model.addAttribute("notice", notice);
	    return "tracerPages/noticeDetail"; // JSP 파일 이름
	}
	 
	// 등록할때 코드
	@PostMapping("/noticeListInsert")
	public ResponseEntity<String> noticeInsert(@RequestBody Notice ins, HttpSession session) {
	    try {
	        User_info user_info = (User_info) session.getAttribute("user_info");
	        if (user_info != null) {
	            ins.setEmail(user_info.getEmail()); // 이메일 설정
	            ins.setNickname(user_info.getNickname()); // 닉네임 설정
	        }

	        if (ins.getDate_of_registration() == null) {
	            ins.setDate_of_registration(new Date()); // 현재 날짜로 기본값 설정
	        }

	        int result = service.insertNotice(ins);
	        if (result > 0) {
	            return ResponseEntity.ok("등록성공");
	        } else {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("등록실패");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("등록 실패: " + e.getMessage());
	    }
	}
    
	
	@PostMapping("/delete")
	@ResponseBody
	public ResponseEntity<String> deleteNotice(@RequestParam("vid") String vid) {
	    try {
	        int result = service.deleteNotice(vid);
	        if (result > 0) {
	            return ResponseEntity.ok("삭제 성공");
	        } else {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("삭제 실패: 게시물이 없습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패: " + e.getMessage());
	    }
	}
	
	@GetMapping("getNotice2")
	public ResponseEntity<Notice>  getNotice2(@RequestParam("vid") String vid) {
		return ResponseEntity.ok(service.getNoticeById(vid));
	}

    // 공지사항 정보 조회
    @GetMapping("/getNotice")
    @ResponseBody
    public Notice getNotice(@RequestParam("vid") String vid) {
        return service.getNoticeById(vid);
    }
	// 검색 요청 처리
    @RequestMapping("/searchNotices")
    public String searchNotices(@RequestParam("searchText") String searchText, @RequestParam("searchType") String searchType, Model model) {
        List<Notice> notices = service.searchNotices(searchText, searchType);
        model.addAttribute("NoticeList", notices);
        return "tracerPages/notice";
    }
    
    // 메일 보내는 코드
    @PostMapping("/sendMail")
    public ResponseEntity<Map<String, String>> sendMail(@RequestBody Map<String, Object> mailData) {
        List<String> recipients = (List<String>) mailData.get("mailRecipients");
        String subject = (String) mailData.get("mailTitle");
        String text = (String) mailData.get("mailContent");

        Map<String, String> response = new HashMap<>();
        try {
            gNoticemail.sendNoticeEmail(recipients, subject, text);
            response.put("status", "success");
            response.put("message", "메일 발송 성공");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "failure");
            response.put("message", "메일 발송 실패");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
 
}

