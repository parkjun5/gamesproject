package global.sesoc.personal.dao;

import java.util.HashMap;
import java.util.List;

import global.sesoc.personal.vo.preply;

public interface ReplyMapper {
	public int replyWrite(preply preply);

	public List<preply> replylist(int boardno); // 댓글 삭제 
	public int deleteReply(HashMap map);

	public int modifyReply(preply preply);

	public int getReplyAmmout(int i);

}
