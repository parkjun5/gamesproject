package global.sesoc.personal.controller;

import java.util.HashMap;
import java.util.List;

import javax.jws.Oneway;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.personal.dao.BoardDao;
import global.sesoc.personal.dao.ReplyDao;
import global.sesoc.personal.util.PageNavigator;
import global.sesoc.personal.vo.mainboard;

@Controller
public class boardController {

	@Autowired
	BoardDao dao;
	@Autowired
	ReplyDao replydao;
	@RequestMapping(value = "/mainBoard", method = RequestMethod.GET)
	public String board(@RequestParam(value = "searchItem", defaultValue = "title") String searchItem,
			@RequestParam(value = "searchWord", defaultValue = "") String searchWord,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, Model model) {

		int totalRecordCount = dao.boardCount(searchItem, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
		List<mainboard> boardList = dao.boardList(searchItem, searchWord, navi.getStartRecord(),
				navi.getCountPerPage());
		 HashMap<Integer,Integer> map = replydao.getReplyAmmout(boardList);
		model.addAttribute("map",map);
		model.addAttribute("boardList", boardList);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);

		return "board/boardList";
	}

	@RequestMapping(value = "/boardWrite", method = RequestMethod.GET)
	public String boardWrite() {

		return "/board/boardWrite";
	}
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String news() {

		return "new";
	}
	

	@PostMapping("write")
	public String write(mainboard board) {
		dao.insertBoard(board);
		return "redirect:/";
	}

	@RequestMapping(value = "/boardDetail", method = RequestMethod.GET)
	public String boardDetail(int boardno,

			@RequestParam(value = "searchItem", defaultValue = "title") String searchItem,
			@RequestParam(value = "searchWord", defaultValue = "") String searchWord,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, Model model) { // DB boardno번에대한
																										// 자세한 내용 가져온다.
		dao.incrementHitCount(boardno);
		mainboard board = dao.boardDetail(boardno);

		model.addAttribute("board", board);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("currentPage", currentPage);
		return "board/boardDetail";
	}

	@RequestMapping(value = "deleteBoard", method = RequestMethod.GET)
	public String deleteBoard(int boardno) {

		dao.delteBoard(boardno);

		return "redirect:/";
	}

	@GetMapping("/boardUpdate")
	public String modify(@RequestParam("boardno") int boardno, Model model) {
		mainboard board = dao.boardDetail(boardno);
		model.addAttribute("board", board);
		return "board/boardUpdate";
	}

	@PostMapping("/modify")
	public String modify(mainboard board,RedirectAttributes rttr) {
		System.out.println(board);
		rttr.addAttribute("boardno", board.getBoardno());
		dao.boardUpdate(board);
		return "redirect:boardDetail";
	
	}
}
