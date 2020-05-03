package global.sesoc.personal.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.personal.vo.puser;

@Repository
public class puserDao {

	@Autowired
	SqlSession session;

	// 1. 회원가입
	public int usersign(puser puser) {
		puserMapper mapper = session.getMapper(puserMapper.class);
		int res = 0;
		res = mapper.insertUser(puser);
		return res;
	}
	public puser selectOne(puser puser) {
		puser result = new puser();
		puserMapper mapper = session.getMapper(puserMapper.class);
		result = mapper.selectOne(puser);
		 return result;
	}
	public puser selectname(puser puser) {
		puser result = new puser();
		puserMapper mapper = session.getMapper(puserMapper.class);
		result = mapper.selectname(puser);
		 return result;
	}
	public puser confirmPwd(puser puser) {
		puserMapper mapper = session.getMapper(puserMapper.class);
		puser temp = mapper.confirmPwd(puser);
		return temp;
	}


//	// 5. 탈퇴
//	public int deleteCustomer(Customer customer) {
//		return 0;
//	}

	
	public int modifypuser(puser puser) {
		puserMapper mapper = session.getMapper(puserMapper.class);
			int result = mapper.modifyCustomer(puser);
			return result;
		
		}
	public puser selectemail(puser puser) {
		puser result = new puser();
		puserMapper mapper = session.getMapper(puserMapper.class);
		result = mapper.selectemail(puser);
		 return result;
	}
	

}
