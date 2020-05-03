package global.sesoc.personal.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class WebExceptionHandler {
	//모든 종류의 익셉션 처리
	@ExceptionHandler(NoHandlerFoundException.class)
	public String errerHandler(Exception e, Model model) {
		model.addAttribute("errmsg",e.getMessage());
		return "/error";
	}
}

// DI 디펜던스 인젝션 다른곳에서 객체 가져옴
// AOP 에스펙트 오리엔트 고객들이 요구하는 것이외의 전체 소스코드를 빠르게 하는것 개발 로그 고객들에게 안보이는 것들