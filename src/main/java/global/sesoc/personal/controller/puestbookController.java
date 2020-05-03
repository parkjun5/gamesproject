package global.sesoc.personal.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.SessionScope;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.personal.dao.puestbookDAO;
import global.sesoc.personal.vo.preply;
import global.sesoc.personal.vo.puestbook;

@Controller

public class puestbookController {

	@Autowired
	puestbookDAO dao;

	@RequestMapping(value = "/guestbook", method = RequestMethod.GET)
	public String guestbook(Model model) {
		return "/puestbook/puestbook";
	}
	@ResponseBody
	@RequestMapping(value = "/getAll", method = RequestMethod.GET)
	public List<puestbook> replyList() {
		List<puestbook> list = dao.findAll();

		return list;
	}

	@RequestMapping(value = "/registGuestbook", method = RequestMethod.POST)
	public String registGuestbook(puestbook puestbook) {
		System.out.println(puestbook);
		dao.insertpuestbook(puestbook);

		return "redirect:guestbook";
	}

	@RequestMapping(value = "/deletequest", method = RequestMethod.GET)
	public String deleteGuestbook(puestbook puestbook) {
		int result = dao.deletepuestbook(puestbook);
		return "redirect:guestbook";
	}

}
