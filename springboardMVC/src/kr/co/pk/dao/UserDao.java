package kr.co.pk.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.pk.domain.User;

@Repository
public class UserDao {
	//XML Mapper를 이용하는 MyBatis 클래스의 객체를 주입
	@Autowired
	private SqlSession sqlSession;
	
	//email 중복 체크를 위한 메소드
	public String emailCheck(String email) {
		//데이터 1개를 받아오는 sql 실행
		return sqlSession.selectOne("user.emailcheck",email);
	}
	
	//회원 가입을 위한 메소드
	public void register(User user) {
		sqlSession.insert("user.register", user);
	}
	
	//로그인 처리를 위한 메소드
	public User login(String email) {
		return sqlSession.selectOne("user.login", email);
	}
}













