package global.sesoc.personal;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.personal.dao.BoardDao;
import global.sesoc.personal.dao.ReplyDao;
import global.sesoc.personal.vo.mainboard;

@Controller
public class HomeController {
	@Autowired
	BoardDao dao;
	@Autowired
	ReplyDao replydao;
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<mainboard> tempList = dao.boardList();
		List<mainboard> boardList =new ArrayList<>();
		int ranking =9;
		if(ranking>tempList.size()) {
			ranking =tempList.size();
		}
		for(int i=0;i<ranking;i++) {
			
		boardList.add(tempList.get(i));
		}
		 HashMap<Integer,Integer> map = replydao.getReplyAmmout(boardList);
			model.addAttribute("map",map);
			model.addAttribute("boardList", boardList);
		return "index";
	}


}
