package yjc.wdb.bbs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import yjc.wdb.bbs.bean.BoardReply;
import yjc.wdb.bbs.bean.Criteria;

@Repository
public class BoardReplyDAOImpl implements BoardReplyDAO {
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "yjc.wdb.ReplyMapper";
	
	@Override
	public List<BoardReply> list(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".list",bno);
	}

	@Override
	public void create(BoardReply reply) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".create",reply);
	}

	@Override
	public void update(BoardReply reply) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".update",reply);
	}

	@Override
	public void delete(int rno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".delete",rno);
	}

	@Override
	public List<BoardReply> listPage(int bno, Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> paraMap = new HashMap<String,Object>();
		paraMap.put("bno", bno);
		paraMap.put("criteria", criteria);
		return sqlSession.selectList(namespace+".listPage",paraMap);
	}

	@Override
	public int replyCount(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".replyCount",bno);
	}

}
