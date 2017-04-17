package yjc.wdb.bbs;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import yjc.wdb.bbs.bean.Board;
import yjc.wdb.bbs.bean.Criteria;
import yjc.wdb.bbs.bean.Member;
import yjc.wdb.bbs.dao.BoardDAO;
import yjc.wdb.bbs.service.BoardService;


@Controller
public class BBSController {
	@Inject
	private BoardService service;
	
	@RequestMapping(value="create", method = RequestMethod.GET)
	public String getBoardForm(@ModelAttribute Criteria criteria){
		return "boardForm";
	}
	
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String create(Board board, RedirectAttributes rttr) throws Exception{
		service.regist(board);
		rttr.addFlashAttribute("result","SUCCESS");
		return "redirect:listPage";
	}
	@RequestMapping(value = "result")
	public @ResponseBody String regResult(){
		return "result";
	}

	
	
	@RequestMapping(value="member")
	public @ResponseBody Member getMember(){
		Member m = new Member();
		return m;
	}
	
	
	
	
	
	
	
	@RequestMapping(value="listAll", method = RequestMethod.GET)
	public void listAll(Model model) throws Exception{
		List<Board> list = service.listAll();
		model.addAttribute("list",list);
	}
	
	@RequestMapping(value="listPage", method=RequestMethod.GET)
	public String listPage(Criteria criteria, Model model) throws Exception{
		// service에게 요청하면 List<Board> 객체 반환하기
		//그럼 그 객체를 model에 넣어 주면 되겠지.
		//그러면 view에서 그 객체를 이용해 글목록 보여주면 되겠지..
		System.out.println(criteria);
		//List<Board> list = service.listPage(criteria);
		List<Board> list = service.listSearch(criteria);
		model.addAttribute("list",list);
		model.addAttribute("criteria",criteria);
		//startPage, endPage, previous, next
		
		int totalCount = service.getSearchTotalCount(criteria);
		criteria.setTotalCount(totalCount);
		return "listPage";
	}
	@RequestMapping(value="read", method = RequestMethod.GET)
	public void read(@RequestParam(value="bno",defaultValue="-1")int bno, @ModelAttribute Criteria criteria, Model model) throws Exception{
		Board board = service.read(bno);
		model.addAttribute("board",board);
	}
	@RequestMapping(value="remove", method = RequestMethod.POST)
	public String remove(@RequestParam(value="bno",defaultValue="-1")int bno, Criteria criteria, RedirectAttributes rttr) throws Exception{
		service.remove(bno);
		rttr.addAttribute("page",criteria.getPage());
		rttr.addAttribute("recordsPerPage",criteria.getRecordsPerPage());
		rttr.addAttribute("searchType",criteria.getSearchType());
		rttr.addAttribute("keyword",criteria.getKeyword());
		rttr.addFlashAttribute("msg", "true");
		return "redirect:listPage";
	}
	@RequestMapping(value="modify", method = RequestMethod.POST)
	public String modify(Board board, Criteria criteria, RedirectAttributes rttr) throws Exception{
		service.modify(board);
		rttr.addAttribute("bno",board.getBno());
		rttr.addAttribute("page", criteria.getPage());
		rttr.addAttribute("recordsPerPage",criteria.getRecordsPerPage());
		rttr.addAttribute("searchType",criteria.getSearchType());
		rttr.addAttribute("keyword",criteria.getKeyword());
		
		return "redirect:read";
	}
	@RequestMapping(value = "listSearch", method = RequestMethod.GET)
	public String listSearch(@ModelAttribute Criteria criteria, Model model) throws Exception{
		List<Board> list = service.listSearch(criteria);
		model.addAttribute("list",list);
		int totalCount = service.getSearchTotalCount(criteria);
		criteria.setTotalCount(totalCount);
		return "listPage";
	}
	
}
