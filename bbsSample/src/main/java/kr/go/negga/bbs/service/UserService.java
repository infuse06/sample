package kr.go.negga.bbs.service;

public interface UserService {
	
	// 회원가입
	public int userInsert(UserVO userVO) throws Exception;
	
	// 아이디체크&로그인
	public UserVO idCkeck_Login(UserVO userVO) throws Exception;
}
