package com.web.tracerProject.controller;

import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.tracerProject.service.G_Service_BOARD;
import com.web.tracerProject.vo.Board;
import com.web.tracerProject.vo.BoardSch;
import com.web.tracerProject.vo.User_info;

import jakarta.servlet.http.HttpSession;

@Controller
public class G_Controller_BOARD extends NContBase{
     
    @Autowired(required=false)
    private G_Service_BOARD service;
     
    // http://localhost:5656/riskBoard
    @GetMapping("/riskBoard")
    public String riskBoard(
            @RequestParam(value = "subject", defaultValue = "") String subject,
            @RequestParam(value = "writer", defaultValue = "") String writer,
            @RequestParam(value = "curPage", defaultValue = "1") int curPage,
            @RequestParam(value = "pageSize", defaultValue = "9") int pageSize,
            HttpSession session, // HttpSession을 메서드 매개변수로 주입
            Model model) {

        BoardSch sch = new BoardSch();
        sch.setSubject(subject);
        sch.setWriter(writer);
        sch.setCurPage(curPage);
        sch.setPageSize(pageSize);

        List<Board> boardList = service.getPagedBoardList(sch);

        model.addAttribute("boardList", boardList);
        model.addAttribute("currentPage", sch.getCurPage());
        model.addAttribute("totalPages", sch.getPageCount());
        model.addAttribute("pageSize", sch.getPageSize());
        model.addAttribute("totalCount", sch.getCount());
        model.addAttribute("startBlock", sch.getStartBlock());
        model.addAttribute("endBlock", sch.getEndBlock());

        User_info user_info = (User_info) session.getAttribute("user_info");
        if (user_info != null) {
            model.addAttribute("user_info", user_info);
            model.addAttribute("email", user_info.getEmail());
            model.addAttribute("nickname", user_info.getNickname());
     		}
        return "tracerPages/riskBoard";
    }
    // 등록하는 코드
    @PostMapping("/boardListInsert")
    @ResponseBody
    public String boardInsert(@RequestBody Board ins) {
        if (ins.getUpt_date() == null) {
            ins.setUpt_date(new Date()); // 현재 날짜로 기본값 설정
        }
        return service.insertBoard(ins) > 0 ? "등록성공" : "등록실패";
    }
    
    // 검색하는 코드
    @GetMapping("/search")
    public String search(@RequestParam(required = false, defaultValue = "") String searchText,
                         @RequestParam(required = false, defaultValue = "title") String searchType,
                         Model model) {
        List<Board> results = service.search(searchText, searchType);

        // 검색 결과를 모델에 추가
        model.addAttribute("boardList", results);
        model.addAttribute("searchText", searchText);
        model.addAttribute("searchType", searchType);

        // 결과를 보여줄 JSP 파일 경로 반환
        return "tracerPages/riskBoard"; // JSP 파일 경로를 반환합니다.
    }
    
    @PostMapping("/boardUpdate")
    @ResponseBody
    public ResponseEntity<String> updateBoard(@RequestBody Board updatedBoard) {
        try {
            int result = service.updateBoard(updatedBoard);
            if (result > 0) {
                return ResponseEntity.ok("수정 성공");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정 실패");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류: " + e.getMessage());
        }
    }

  

    @PostMapping("/deleteBoard")
    @ResponseBody
    public ResponseEntity<String> deleteBoard(@RequestParam("bid") String bid) {
        try {
            int result = service.deleteBoard(bid);

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

    
    @PostMapping("/updateBoardStatus")
    public ResponseEntity<String> updateBoardStatus(@RequestBody Map<String, Object> payload) {
        String bid = (String) payload.get("bid");
        boolean endYN = (Boolean) payload.get("endYN");
        
        int result = service.updateBoardStatus(bid, endYN);
        
        if (result > 0) {
            return ResponseEntity.ok("Status updated successfully");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to update status");
        }
    }
       
    
    @GetMapping("/boardDetail")
    public String boardDetail(@RequestParam("vid") String vid, Model model) {
        try {
            Board board = service.getBoardById(vid); // 서비스에서 게시물 ID로 조회
            if (board != null) {
                model.addAttribute("board", board); // Model에 게시물 추가
                return "tracerPages/boardDetail"; // 게시물 상세 페이지 JSP
            } else {
                model.addAttribute("error", "게시물을 찾을 수 없습니다.");
                return "error"; // 오류 페이지
            }
        } catch (Exception e) {
            model.addAttribute("error", "서버 오류: " + e.getMessage());
            return "error"; // 오류 페이지
        }
    }
}
    
