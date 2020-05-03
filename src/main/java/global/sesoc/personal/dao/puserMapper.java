package global.sesoc.personal.dao;

import global.sesoc.personal.vo.puser;

public interface puserMapper {

	int insertUser(puser vo);
//
//	//가입
//	public int signupCustomer(pp customer);
//	//로그인 + 중복체크
//	public Customer selectOne(Customer customer);
//	//탈퇴
//	public int deleteCustomer(Customer customer);
//	//tnwjd
//	public int modifyCustomer(Customer customer);
//	public Customer confirmPwd(Customer customer);
//
//	

	public void GetKey(String user_id, String key);

	public int alter_userKey(String user_id, String key);

	public puser selectOne(puser puser);

	puser selectname(puser puser);

	puser confirmPwd(puser puser);

	int modifyCustomer(puser puser);

	puser selectemail(puser puser);
	
}
