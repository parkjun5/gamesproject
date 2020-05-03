package global.sesoc.personal.dao;

import java.util.ArrayList;
import java.util.List;

import global.sesoc.personal.vo.puestbook;

public interface puestbookMapper {

	public int insert(puestbook puestbook);

	public int delete(puestbook puestbook);

	public ArrayList<puestbook> selectAll();


}
