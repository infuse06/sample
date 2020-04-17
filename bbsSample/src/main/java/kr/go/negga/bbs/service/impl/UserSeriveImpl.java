package kr.go.negga.bbs.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.go.negga.bbs.service.UserService;
import kr.go.negga.bbs.service.UserVO;

@Service("userService")
public class UserSeriveImpl implements UserService{
	
	@Resource(name="userMapper")
	private UserMapper userMapper;

	// 회원가입
	public int userInsert(UserVO userVO) throws Exception{
		return userMapper.userInsert(userVO);
	}
	
	// 아이디체크&로그인
	public UserVO idCkeck_Login(UserVO userVO) throws Exception {
		return userMapper.idCheck(userVO);
	}
	
}

