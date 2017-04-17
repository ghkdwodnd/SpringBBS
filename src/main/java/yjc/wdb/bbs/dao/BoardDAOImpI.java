package yjc.wdb.bbs.dao;

import java.util.List;


import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import yjc.wdb.bbs.bean.Board;
import yjc.wdb.bbs.bean.Criteria;


@Repository
public class BoardDAOImpI implements BoardDAO {
	private static final String namespace = "yjc.wdb.bbsMapper";
	
	@Inject
	private SqlSession sqlSession;
	@Override
	public void create(Board vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".create", vo);
	}

	@Override
	public Board read(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".read",bno);
	}

	@Override
	public void update(Board vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+ ".update",vo);
	}

	@Override
	public void delete(int bno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(namespace+".delete",bno);
	}

	@Override
	public List<Board> listAll() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".listAll");
	}

	@Override
	public List<Board> listPage(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".listPage",criteria);
	}

	@Override
	public int getTotalCount() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".totalCount");
	}

	@Override
	public List<Board> listSearch(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".listSearch",criteria);
	}

	@Override
	public int getSearchTotalCount(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".searchTotalCount",criteria);
	}

}
