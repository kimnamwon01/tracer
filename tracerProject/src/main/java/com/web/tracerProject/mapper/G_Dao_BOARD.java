package com.web.tracerProject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.web.tracerProject.vo.Board;
import com.web.tracerProject.vo.BoardSch;

@Mapper
public interface G_Dao_BOARD {
	// 조회하는 코드
    @Select("SELECT * FROM BOARD ORDER BY bid")
    List<Board> getBoardList();
    
    // 단일 게시판 조회하는 코드 
    @Select("SELECT * FROM BOARD WHERE bid = #{bid}")
    Board getBoardById(@Param("bid") String bid);
    
    // 업데이트하는 코드
    @Update("UPDATE BOARD SET title=#{title}, content=#{content}, uf=#{uf} WHERE bid=#{bid}")
    int updateBoard(Board upt);
    
    // 실시간으로 진행중 / 완료 하는코드
    @Update("UPDATE BOARD SET endYN = #{endYN} WHERE bid = #{bid}")
    int updateBoardStatus(@Param("bid") String bid, @Param("endYN") boolean endYN);
   
    // 등록하는 코드
    @Insert("INSERT INTO BOARD (bid, title, content, upt_date, email, endYN, uf, nickname) " +
            "VALUES ('B'||LPAD(BID_SEQ.NEXTVAL, 5, '0'), #{title}, #{content}, #{upt_date}," +
            "#{email}, #{endYN}, #{uf}, #{nickname})")
    int insertBoard(Board board);
    
    // 검색하는 코드 <select> 사용해서 제목 작성자 나누어서 검색하는 코드
    @Select("<script>" +
            "SELECT * FROM BOARD " +
            "<where>" +
            "  <if test='searchText != null and searchText != \"\"'>" +
            "    <choose>" +
            "      <when test='searchType == \"title\"'>" +
            "        title LIKE '%' || #{searchText} || '%'" +
            "      </when>" +
            "      <when test='searchType == \"nickname\"'>" +
            "        nickname LIKE '%' || #{searchText} || '%'" +
            "      </when>" +
            "    </choose>" +
            "  </if>" +
            "</where>" +
            "ORDER BY bid DESC" +
            "</script>")
    List<Board> search(@Param("searchText") String searchText, @Param("searchType") String searchType);
   
    // 삭제 하는 코드
    @Delete("DELETE FROM board WHERE bid = #{bid}")
    int deleteBoard(@Param("bid") String bid);
    
 // 검색 및 페이지네이션을 포함한 게시글 목록 조회
    @Select("SELECT COUNT(*) FROM BOARD "
            + "WHERE title LIKE '%' || #{subject} || '%' "
            + "AND email LIKE '%' || #{writer} || '%'")
    int countTotalBoards(BoardSch sch);
    @Select("SELECT * FROM ( "
            + "  SELECT b.*, ROW_NUMBER() OVER (ORDER BY bid DESC) AS rn "
            + "  FROM BOARD b "
            + "  WHERE b.title LIKE '%' || #{subject} || '%' "
            + "  AND b.email LIKE '%' || #{writer} || '%' "
            + ") tmp "
            + "WHERE rn BETWEEN #{start} AND #{end}")
    List<Board> findBoardsWithPagination(BoardSch sch);
    
    
    
    
}