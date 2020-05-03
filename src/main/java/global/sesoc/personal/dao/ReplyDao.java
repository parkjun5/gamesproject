package global.sesoc.personal.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.personal.vo.mainboard;
import global.sesoc.personal.vo.preply;

@Repository
public class ReplyDao {
	@Autowired
	SqlSession session;

	public int writeReply(preply preply) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		return mapper.replyWrite(preply);

	}

	public List<preply> replyList(int boardno) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		return mapper.replylist(boardno);
	}

	public int deleteReply(int replyno, int boardno) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		HashMap<String, Integer> map = new HashMap<>();
		map.put("replyno", replyno);
		map.put("boardno", boardno);
		int result = mapper.deleteReply(map);
		return result;
	}

	public int modifyReply(preply preply) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);

		return mapper.modifyReply(preply);

	}

	public HashMap<Integer, Integer> getReplyAmmout(List<mainboard> boardList) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		HashMap<Integer, Integer> map = new HashMap<>();
		for (mainboard board : boardList) {
			int temp = 0;
			int boardno = board.getBoardno();
			temp = mapper.getReplyAmmout(boardno);
			map.put(board.getBoardno(), temp);
		}

		return map;
	}

}
