package kr.go.negga.bbs.service.impl;

import java.util.List;

import kr.go.negga.bbs.service.BbsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


//count 조회 		selectOne
//상세 조회     		selectOne
//입력                         insert
//수정        		update
//삭제			delete

@Mapper("bbsMapper")
public class BbsMapper extends EgovAbstractMapper{
	
	// 전체보기
	public List<BbsVO> selectBbsList(BbsVO bbsVO) throws Exception{
		return selectList("selectBbsList", bbsVO);
	}
	
	// 상세보기
	public BbsVO selectBbs(BbsVO bbsVO) throws Exception{
		return selectOne("selectBbs", bbsVO);
	}
	
	// 글등록
	public void insertBbs(BbsVO bbsVO) throws Exception{
		insert("insertBbs", bbsVO);
	}
	
	// 글삭제
	public void deleteBbs(BbsVO bbsVO) throws Exception{
		delete("deleteBbs", bbsVO);
	}
	
	// 글편집
	public void modifyBbs(BbsVO bbsVO) throws Exception{
		update("modifyBbs", bbsVO);
	}
}
