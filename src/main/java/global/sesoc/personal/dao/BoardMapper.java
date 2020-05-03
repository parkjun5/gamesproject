package global.sesoc.personal.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.personal.vo.mainboard;


public interface BoardMapper {

	// 2. 하나의 글 조회
	public mainboard selectOne(int boardno);
//	// 2.5 글하나 삽입
	public int insertBoard(mainboard board);
//	// 3. 삭제
	public int deleteBoard(int boardno);
//	// 4. 수정
	public int updateBoard(mainboard board);
//	// 5. 조회수
	public int getHitcount();
//	//  6.   게시물 글 갯수 조회
	public int getBoardCount(Map<String,Object> map);
//	// 7. 전체조회 새버전 
	public List<mainboard> searchAll(Map<String, Object> map, RowBounds rb);
	public void incrementHitCount(int boardno);
	public List<mainboard> rankList();
	

}
