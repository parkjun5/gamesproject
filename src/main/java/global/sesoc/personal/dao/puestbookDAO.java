package global.sesoc.personal.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.personal.vo.puestbook;

@Repository
public class puestbookDAO {

	@Autowired
	SqlSession session;

	public void insertpuestbook(puestbook puestbook) {
		puestbookMapper mapper = session.getMapper(puestbookMapper.class);
		mapper.insert(puestbook);
	}

	public int deletepuestbook(puestbook puestbook) {

		puestbookMapper mapper = session.getMapper(puestbookMapper.class);
		return mapper.delete(puestbook);

	}

	public ArrayList<puestbook> findAll() {
		puestbookMapper mapper = session.getMapper(puestbookMapper.class);
		return mapper.selectAll();

	}


}
