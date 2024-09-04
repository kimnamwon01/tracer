package com.web.tracerProject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.tracerProject.service.NSerUserMgmt;
import com.web.tracerProject.vo.User_info;

@Controller
public class NContUserMgmt {

    @Autowired
    private NSerUserMgmt service;

    // 사용자 관리 페이지를 불러오는 메서드
    @GetMapping("userManagement")
    public String prjList(@RequestParam(value = "page", defaultValue = "0") int page,
                          @RequestParam(value = "size", defaultValue = "10") int size, 
                          Model model) {
        // 사용자 정보를 페이징 처리하여 가져옵니다.
        Page<User_info> users = service.getUser_info(page, size);
        model.addAttribute("users", users);
        return "tracerPages/user-management";
    }

    // 사용자 목록을 검색하는 메서드
    @PostMapping("userList")
    public ResponseEntity<Page<User_info>> schPrjList( @RequestParam(value = "nickname", defaultValue = "") String nickname, 
    												   @RequestParam(value = "name", defaultValue = "") String name, 
                                                       @RequestParam(value = "auth", defaultValue = "") String auth,
                                                       @RequestParam(value = "page", defaultValue = "0") int page,
                                                       @RequestParam(value = "size", defaultValue = "10") int size) {
        // 이름과 권한으로 필터링된 사용자 정보를 페이징 처리하여 가져옵니다.
        Page<User_info> users = service.schUserInfo(nickname, name, auth, page, size);
        return ResponseEntity.ok(users);
    }

    // 사용자 삭제 메서드
    @PostMapping("delUser")
    public ResponseEntity<Page<User_info>> delUser(@RequestParam(value = "nickname", defaultValue = "") String nickname, 
    												@RequestParam(value = "name", defaultValue = "") String name, 
                                                    @RequestParam(value = "auth", defaultValue = "") String auth,
                                                    @RequestParam("email") String email,
                                                    @RequestParam(value = "page", defaultValue = "0") int page,
                                                    @RequestParam(value = "size", defaultValue = "10") int size) {
        // 사용자를 삭제하고, 삭제 후 필터링된 사용자 목록을 페이징 처리하여 가져옵니다.
        Page<User_info> users = service.delUser(nickname, name, auth, email, page, size);
        return ResponseEntity.ok(users);
    }

    // 사용자 권한 업데이트 메서드
    @PostMapping("uptUser")
    public ResponseEntity<String> uptUser(@RequestParam("auth") String auth,
                                           @RequestParam("email") String email) {
        // 사용자의 권한을 업데이트합니다.
        String result = service.uptUser(auth, email);
        return ResponseEntity.ok(result);
    }
}
