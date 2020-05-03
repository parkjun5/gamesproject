package global.sesoc.personal.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.personal.util.FileService;
import global.sesoc.personal.dao.puserDao;
import global.sesoc.personal.vo.puser;

@Controller
public class puserController {
	@Autowired
	puserDao dao;
	final String uploadPath = "/personalUploadPath";

	@GetMapping("/userlogin")
	public String userlogin() {
		return "/puser/userlogin";
	}

	@GetMapping("/join")
	public String join() {

		return "/puser/puserJoinForm";
	}

	@RequestMapping(value = "/loginAct", method = RequestMethod.POST)
	public String loginAct(puser puser, Model model, HttpServletResponse response, HttpSession session) {

		Cookie cookie = new Cookie("saveId", null);
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		puser loginuser = dao.selectOne(puser);

		if (loginuser != null) {

			if (!loginuser.getUserkey().equals("Y")) {
				model.addAttribute("error", "이메일을 인증해주세요!");
				return "/puser/userlogin";
			}
			session.setAttribute("userimgs", loginuser.getSavedfilename());
			session.setAttribute("username", loginuser.getUsername());
			return "redirect:/";

		}
		model.addAttribute("error", "입력한 정보가 틀렸습니다..");
		return "/puser/userlogin";

	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {

		session.invalidate();
		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	public String idCheck(puser puser) {
		puser temppuser = dao.selectname(puser);

		if (temppuser == null) {
			return "success";
		}
		return "fail";
	}

	@ResponseBody
	@RequestMapping(value = "/useremailCheck", method = RequestMethod.GET)
	public String useremailCheck(puser puser) {
		puser temppuser = dao.selectemail(puser);

		if (temppuser == null) {
			return "success";
		}
		return "fail";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modify(puser username, Model model) {
		puser temppuser = dao.selectname(username);
		model.addAttribute("temppuser", temppuser);
		return "/puser/modifyForm";
	}

	@RequestMapping(value = "/modifyConfirmCustomer", method = RequestMethod.POST)
	public String modifyConfirmCustomer(String usernameConfirm, String userpwdConfirm, Model model) {
		puser puser = new puser();
		puser.setUsername(usernameConfirm);
		;
		puser.setUserpwd(userpwdConfirm);

		puser res = dao.confirmPwd(puser);
		System.out.println(puser);
		if (res == null) {
			model.addAttribute("result", 0);
			return "/puser/modifyConfirm";
		} else {
			model.addAttribute("temppuser", res);
			return "/puser/modifyForm";
		}

	}
	//댓글폼을 위해서 지우는 기능 제거
	@RequestMapping(value = "/modifyUser", method = RequestMethod.POST)
	public String modifyUser(puser puser, MultipartFile upload, Model model, HttpSession session) {

		puser oripuser = dao.selectname(puser);
		if (oripuser.getSavedfilename() != "") {
			puser.setOriginalfilename(oripuser.getOriginalfilename());
			puser.setSavedfilename(oripuser.getSavedfilename());
		}
		if (!upload.isEmpty()) {
			String savedFilename = FileService.saveFile(upload, uploadPath);
			String originalFilename = upload.getOriginalFilename();
			puser.setOriginalfilename(originalFilename);
			puser.setSavedfilename(savedFilename);
		}
		if (oripuser.getSavedfilename() == puser.getSavedfilename()) {
			dao.modifypuser(puser);
			session.setAttribute("userno", puser.getUserno());
			session.setAttribute("userimgs", puser.getSavedfilename());
			session.setAttribute("username", puser.getUsername());
			return "redirect:/";
		}

		dao.modifypuser(puser);
		session.setAttribute("userno", puser.getUserno());
		session.setAttribute("userimgs", puser.getSavedfilename());
		session.setAttribute("username", puser.getUsername());
		return "redirect:/";

	}
	@RequestMapping(value = "/modifypUser", method = RequestMethod.POST)
	public String modifyUser(puser puser, HttpSession session) {	
		dao.modifypuser(puser);
		session.setAttribute("username", puser.getUsername());
		return "redirect:/";

	}

}
