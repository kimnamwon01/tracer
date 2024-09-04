package com.web.tracerProject.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.G_Dao_BOARD;
import com.web.tracerProject.vo.Board;
import com.web.tracerProject.vo.BoardSch;

@Service
public class G_Service_BOARD {
     
    @Autowired(required=false)
    private G_Dao_BOARD dao;

    public List<Board> getPagedBoardList(BoardSch sch) {
        // subject와 writer에 대해 null 체크 및 빈 문자열로 초기화
        if (sch.getSubject() == null) sch.setSubject("");
        if (sch.getWriter() == null) sch.setWriter(""); // writer 유지

        // 총 데이터 수를 가져옴
        sch.setCount(dao.countTotalBoards(sch));

        // 현재 페이지 설정 (기본값은 1)
        if (sch.getCurPage() == 0) {
            sch.setCurPage(1);
        }

        // 한 페이지에 보일 데이터 수 설정 (기본값은 9)
        if (sch.getPageSize() == 0) {
            sch.setPageSize(9);
        }

        // 총 페이지 수 계산
        sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));

        // 현재 페이지가 총 페이지 수보다 큰 경우 처리
        if (sch.getCurPage() > sch.getPageCount()) {
            sch.setCurPage(sch.getPageCount());
        }

        // 시작 번호와 마지막 번호 설정
        sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);
        int imEnd = sch.getPageSize() * sch.getCurPage();
        sch.setEnd(imEnd > sch.getCount() ? sch.getCount() : imEnd);

        // 페이지 블럭 처리
        sch.setBlockSize(5);
        int blockNum = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());
        sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);
        int endBlock = blockNum * sch.getBlockSize();
        sch.setEndBlock(endBlock > sch.getPageCount() ? sch.getPageCount() : endBlock);

        // 페이지네이션된 데이터 목록을 반환
        return dao.findBoardsWithPagination(sch);
    }
    // 총 게시글 수 조회
    public int getTotalBoardCount(BoardSch sch) {
        return dao.countTotalBoards(sch);
    }
    
    // 검색 메서드
    public List<Board> search(String searchText, String searchType) {
        return dao.search(searchText, searchType);
    }
 // 단일 게시판 조회
    public Board getBoardById(String bid) {
        return dao.getBoardById(bid);
    }

    // 게시판 수정
    public int updateBoard(Board updatedBoard) {
        // 기존 데이터 가져오기
        Board existingBoard = dao.getBoardById(updatedBoard.getBid());

        if (existingBoard != null) {
            // 기존 데이터 유지
            if (updatedBoard.getTitle() != null) {
                existingBoard.setTitle(updatedBoard.getTitle());
            }
            if (updatedBoard.getContent() != null) {
                existingBoard.setContent(updatedBoard.getContent());
            }
            if (updatedBoard.getUf() != null) {
                existingBoard.setUf(updatedBoard.getUf());
            }
            // 상태를 업데이트
            existingBoard.setEndYN(updatedBoard.isEndYN());

            // 업데이트
            return dao.updateBoard(existingBoard);
        }
        return 0; // 수정 실패
    }
    // boolean 실시간으로 값 이동
    public int updateBoardStatus(String bid, boolean endYN) {
        return dao.updateBoardStatus(bid, endYN);
    }
    
    // 삭제하는 코드
    public int deleteBoard(String bid) {
        return dao.deleteBoard(bid);
    }

    // 등록할때 null 처리
    public int insertBoard(Board ins) {
        if (ins.getUpt_date() == null) {
            ins.setUpt_date(new Date()); // 현재 날짜로 기본값 설정
        }
        if (ins.getContent() == null) {
            ins.setContent("");
        }
        if (!ins.isEndYN()) {
            ins.setEndYN(false); // 기본값 설정
        }
        if (ins.getUf() == null) {
            ins.setUf("");
        }
        if (ins.getNickname() == null) {
            ins.setNickname("");
        }
        return dao.insertBoard(ins);
    }
}
