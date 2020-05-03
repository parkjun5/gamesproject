package global.sesoc.personal.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.personal.vo.mainboard;

@Repository
public class BoardDao {

	@Autowired
	SqlSession session;

	public List<mainboard> boardList(String searchItem, String searchWord, int startRecord, int countPerPage) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		List<mainboard> boardList; // rowbounds 자동으로 페이징해주는 객체
		RowBounds rb = new RowBounds(startRecord, countPerPage);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		boardList = mapper.searchAll(map, rb);

		return boardList;
	}

	public int insertBoard(mainboard board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int result = mapper.insertBoard(board);
		return result;
	}

	public int boardCount(String searchItem, String searchWord) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchWord", searchWord);
		int totalRecordCount = mapper.getBoardCount(map);
		return totalRecordCount;
	}

	public void incrementHitCount(int boardno) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		mapper.incrementHitCount(boardno);
	}

	/*
	 * public ArrayList<mainboard> selectBoard() { BoardMapper mapper =
	 * session.getMapper(BoardMapper.class); return mapper.searchAll(); }
	 */

	public mainboard boardDetail(int boardno) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		mainboard board = mapper.selectOne(boardno);
		return board;
	}

	public List<mainboard> boardList() {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		List<mainboard> boardList = mapper.rankList();
		return boardList;
	}

	public void delteBoard(int boardno) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		mapper.deleteBoard(boardno);
	}

	public int boardUpdate(mainboard board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		int res = mapper.updateBoard(board);

		return res;

	}

}
