package kr.go.negga.bbs.service.impl;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.go.negga.bbs.service.UserVO;

//count 조회 		selectOne
//상세 조회     		selectOne
//입력                    insert
//수정        		update
//삭제			delete

@Mapper("userMapper")
public class UserMapper extends EgovAbstractMapper {

	// 회원가입
	public int userInsert(UserVO userVO) throws Exception {
		return insert("userInsert", userVO);
	}

	// 아이디체크&로그인
	public UserVO idCheck(UserVO userVO) throws Exception {
		return selectOne("idCheck", userVO);
	}

}
