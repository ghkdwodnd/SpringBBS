package yjc.wdb.bbs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import yjc.wdb.bbs.bean.BoardReply;
import yjc.wdb.bbs.bean.Criteria;
import yjc.wdb.bbs.bean.Member;
import yjc.wdb.bbs.service.BoardReplyService;

@RestController
@RequestMapping("replies")
public class BBSReplyController {
	@Inject
	private BoardReplyService service;
	
	@RequestMapping(value="/{bno}/{page}",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listPage(@PathVariable("bno")int bno, @PathVariable("page")int page){
		ResponseEntity<Map<String,Object>> entity = null;
		try{
			Criteria criteria = new Criteria();
			criteria.setPage(page);
			int replyCount = service.replyCount(bno);
			criteria.setTotalCount(replyCount);
			
			List<BoardReply> list = service.listPage(bno, criteria);
			Map<String, Object> map = new HashMap<>();
			map.put("criteria", criteria);
			map.put("list", list);
			entity = new ResponseEntity<>(map,HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{rno}",method=RequestMethod.DELETE)
	public ResponseEntity<String> removeReply(@PathVariable("rno") int rno){
		ResponseEntity<String> entity = null;
		try{
			service.delete(rno);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/{rno}",method={RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> updateReply(@PathVariable("rno")int rno, @RequestBody BoardReply reply){
		ResponseEntity<String> entity = null;
		try{
			reply.setRno(rno);
			service.update(reply);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="/all/{bno}",method=RequestMethod.GET)
	public ResponseEntity<List<BoardReply>> getReplyList(@PathVariable("bno") int bno){
		ResponseEntity<List<BoardReply>> entity = null;
		try{
			List<BoardReply> list = service.list(bno);
			entity = new ResponseEntity<>(list,HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="",method=RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody BoardReply reply){
		ResponseEntity<String> entity = null;
		try {
			service.create(reply);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			System.out.println("´ñ±Û µî·Ï Á¤»óÀûÀ¸·Î µÇ¾úÁö·Õ");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
	@RequestMapping("getErrorNot")
	public ResponseEntity<List<Member>> getErrorNot(){
		ResponseEntity<List<Member>> entity = null;
		List<Member> list = new ArrayList<Member>();
		
		list.add(new Member("end",34));
		list.add(new Member("start",35));
		entity = new ResponseEntity<List<Member>>(list,HttpStatus.NOT_FOUND);
		return entity;
	}
	
	@RequestMapping("getErrorAuth")
	public ResponseEntity<Void> getErrorAuth(){
		ResponseEntity<Void> re = new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		
		return re;
	}
	
	
	@RequestMapping(value="getMap")
	public Map<Integer, Member> getMap(){
		Map<Integer, Member> map = new HashMap<>();
		map.put(1, new Member("È«",17));
		map.put(2, new Member("±è",12));
		map.put(3, new Member("¹Ú",41));
		map.put(4, new Member("2",75));
		map.put(5, new Member("Á¤",19));
		return map;
	}
	@RequestMapping(value="getMList")
	public List<Member> getMList(){
		ArrayList<Member> list = new ArrayList<Member>();
		list.add(new Member("mbc",28));
		list.add(new Member("efe",21));
		list.add(new Member("qw",23));
		list.add(new Member("er",45));
		list.add(new Member("drip",69));
		return list;
	}
	

}
