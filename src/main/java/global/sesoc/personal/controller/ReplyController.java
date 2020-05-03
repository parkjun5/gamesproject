package global.sesoc.personal.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import global.sesoc.personal.dao.ReplyDao;
import global.sesoc.personal.vo.preply;

@RestController
public class ReplyController {
	@Autowired
	ReplyDao dao;

	@PostMapping("/replyWrite")
	public String replyWrite(preply preply, HttpSession session) {
		String writer = (String) session.getAttribute("username");
		preply.setWriter(writer);
		
		System.out.println(preply);
		int result = dao.writeReply(preply);
		if (result == 1)
			return "success";
		return "fault";
	}

	@PostMapping("/replyUpdate")
	public String replyUpdate(preply preply, HttpSession session) {
		String writer = (String) session.getAttribute("username");
		preply.setWriter(writer);

		int result = dao.modifyReply(preply);

		if (result == 1)
			return "success";

		return "fault";
	}

	@RequestMapping(value = "/replyDelete", method = RequestMethod.GET)
	public String replyDelete(int replyno, int boardno) {

		int result = dao.deleteReply(replyno, boardno);
		if (result == 1) {
			return "success";
		}
		return "fault";
	}

	@RequestMapping(value = "/replyAll", method = RequestMethod.GET)
	public List<preply> replyList(int boardno) {
		List<preply> replyList = dao.replyList(boardno);

		return replyList;
	}

}
