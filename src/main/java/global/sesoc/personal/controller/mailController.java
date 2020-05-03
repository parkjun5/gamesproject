package global.sesoc.personal.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.personal.dao.puserDao;
import global.sesoc.personal.mailutil.MailSendService;
import global.sesoc.personal.util.FileService;
import global.sesoc.personal.vo.puser;

@Controller
public class mailController {
	 @Autowired
		private MailSendService mailsender;
	 @Autowired
		puserDao dao;
	 final String uploadPath = "/personalUploadPath";
	    // 회원가입 컨트롤러
		@RequestMapping(value = "/puserjoin", method = RequestMethod.POST)
		public String userRegPass(puser puser , Model model, HttpServletRequest request) {
			// 회원가입 메서드
			dao.usersign(puser);
			// 인증 메일 보내기 메서드
			mailsender.mailSendWithUserKey(puser.getUseremail(), puser.getUsername(), request);

			return "redirect:/";
		}
		@RequestMapping(value = "/user/key_alter", method = RequestMethod.GET)
		public String key_alterConfirm(@RequestParam("user_id") String user_id, @RequestParam("user_key") String key) {

			mailsender.alter_userKey_service(user_id, key); // mailsender의 경우 @Autowired

			return "/emails/regSuccess";
		}
}
