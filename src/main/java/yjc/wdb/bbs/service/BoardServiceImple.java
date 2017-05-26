package yjc.wdb.bbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import yjc.wdb.bbs.bean.Board;
import yjc.wdb.bbs.bean.BoardReply;
import yjc.wdb.bbs.bean.Criteria;
import yjc.wdb.bbs.dao.BoardDAO;

@Service
public class BoardServiceImple implements BoardService {
	
	@Inject
	private BoardDAO dao;
	@Override
	public void regist(Board b) throws Exception {
		// TODO Auto-generated method stub
		dao.create(b);
		if(b.getFileNames()==null) return;
		String[] files = b.getFileNames();
		
		for(String fileName : files){
			dao.addAttach(fileName);
		}
	}

	@Override
	public Board read(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.read(bno);
	}

	@Override
	public void modify(Board b) throws Exception {
		// TODO Auto-generated method stub
		dao.update(b);
	}

	@Override
	public void remove(int bno) throws Exception {
		// TODO Auto-generated method stub
		dao.delete(bno);
	}

	@Override
	public List<Board> listAll() throws Exception {
		// TODO Auto-generated method stub
		return dao.listAll();
	}

	@Override
	public List<Board> listPage(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return dao.listPage(criteria);
	}

	@Override
	public int getTotalCount() throws Exception {
		// TODO Auto-generated method stub
		return dao.getTotalCount();
	}

	@Override
	public List<Board> listSearch(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return dao.listSearch(criteria);
	}

	@Override
	public int getSearchTotalCount(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return dao.getSearchTotalCount(criteria);
	}

	

}
