package kr.go.negga.bbs.service;

import java.util.List;

public interface BbsService {
	
	// 전체 보기
	public List<BbsVO> selectBbsList(BbsVO bbsVO) throws Exception;
	
	// 상세 보기 
	public BbsVO selectBbs(BbsVO bbsVO) throws Exception;

	// 글등록
	void insertBbs(BbsVO bbsVO) throws Exception;
	
	// 글삭제
	void deleteBbs(BbsVO bbsVO) throws Exception;
	
	// 글편집
	void modifyBbs(BbsVO bbsVO) throws Exception;
	
}
