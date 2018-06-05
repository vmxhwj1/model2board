package kr.co.pk.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.co.pk.domain.Reply;

public interface ReplyService {
	//댓글 저장을 위한 메소드
	public boolean register(HttpServletRequest request);
	
	//댓글목록을 가져오기 위한 메소드
	public List<Reply> list(HttpServletRequest request);
	
	//댓글을 삭제하기 위한 메소드
	public boolean delete(HttpServletRequest request);
	
	//댓글을 수정하기 위한 메소드
	public boolean update(HttpServletRequest request);
}











