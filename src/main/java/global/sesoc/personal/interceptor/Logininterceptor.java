package global.sesoc.personal.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Logininterceptor extends HandlerInterceptorAdapter {

				
	//alt shift s 해서 오버라이드 된 prehandle method를 불러와야함
	// logger 은 4j어쩌구의 로거
	private static final Logger logger = LoggerFactory.getLogger(Logininterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.info("LoginInterceptor==========>");
		
		//세션의 로그인 정보를 알아냄
		HttpSession session = request.getSession();
		String loginid =(String) session.getAttribute("username"); 
		//login이 널이면 로그인 x 아니면 o
		if(loginid==null) {
			//로그인 화면으로 이동함
			//context path가 필요해진다 하지만 contextpath는 가장 기본값 board 나 copy처럼
			//그래서 보낼 값을 더해서 보재주면 된다
			String contextPath= request.getContextPath();
			response.sendRedirect(contextPath+"/userlogin");
			
			return false;
		}
		return true;
	}

	
	
}
