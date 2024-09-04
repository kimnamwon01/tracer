package com.web.tracerProject.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.tracerProject.mapper.G_Dao_Notice;
import com.web.tracerProject.vo.Notice;
import com.web.tracerProject.vo.NoticeSch;

@Service
public class G_Service_Notice {
	@Autowired(required=false)
    private G_Dao_Notice dao;
// 조회하는 코드
	public List<Notice> getNoticeList(NoticeSch sch) {
        if (sch.getSubject() == null) sch.setSubject("");
        if (sch.getWriter() == null) sch.setWriter("");

        // 총 데이터 수
        sch.setCount(dao.getNoticeCount(sch));

        // 현재 페이지 설정
        if (sch.getCurPage() == 0) {
            sch.setCurPage(1);
        }

        // 한 페이지에 보일 데이터 수 설정
        if (sch.getPageSize() == 0) {
            sch.setPageSize(9);
        }

        // 총 페이지 수 계산
        sch.setPageCount((int) Math.ceil(sch.getCount() / (double) sch.getPageSize()));

        // 현재 페이지가 총 페이지 수보다 큰 경우 처리
        if (sch.getCurPage() > sch.getPageCount()) {
            sch.setCurPage(sch.getPageCount());
        }

        // 시작번호와 마지막번호 설정
        sch.setStart((sch.getCurPage() - 1) * sch.getPageSize() + 1);
        int imEnd = sch.getPageSize() * sch.getCurPage();
        sch.setEnd(imEnd > sch.getCount() ? sch.getCount() : imEnd);

        // 페이지 블럭 처리
        sch.setBlockSize(5);
        int blockNum = (int) Math.ceil(sch.getCurPage() / (double) sch.getBlockSize());
        sch.setStartBlock((blockNum - 1) * sch.getBlockSize() + 1);
        int endBlock = blockNum * sch.getBlockSize();
        sch.setEndBlock(endBlock > sch.getPageCount() ? sch.getPageCount() : endBlock);

        return dao.getNoticeListWithPagination(sch);
    }
	// 총 공지사항 수 조회
    public int getTotalNoticeCount(NoticeSch sch) {
        return dao.getNoticeCount(sch);
    }

// 등록하는 코드
public int insertNotice(Notice ins) {
    if (ins.getContent() == null) {
        ins.setContent("");
    }
 // start_date와 end_date가 null인 경우 현재 날짜와 시간으로 설정
    if (ins.getStart_date() == null) {
        ins.setStart_date(new Date()); // 현재 날짜와 시간
    }

    if (ins.getEnd_date() == null) {
        ins.setEnd_date(new Date()); // 현재 날짜와 시간
    }
    
    if (ins.getDate_of_registration() == null) {
        ins.setDate_of_registration(new Date()); // 현재 날짜와 시간
    }
    if (ins.getLink() == null) {
        ins.setLink("");
    }
    
    return dao.insertNotice(ins);
}
  
  // 삭제하는 코드
  public int deleteNotice(String vid) {
	    return dao.deleteNotice(vid);
	}

  // 검색하는하는 코드
  public List<Notice> searchNotices(String searchText, String searchType) {
      return dao.search(searchText, searchType);
  }
  
  //공지사항 상세 조회
  public Notice getNoticeById(String vid) {
      return dao.getNoticeById(vid);
  }
  
  // 수정하는 코드
  public int updateNotice(Notice notice) {
      return dao.updateNotice(notice);
  }
  
 

}
