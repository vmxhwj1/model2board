package kr.co.pk.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.pk.domain.Board;
import kr.co.pk.domain.SearchCriteria;

public interface BoardService {
	//매개변수를 HttpServletRequest를 이용해서 만들면 가장 수월하게 메소드 모양을 만들 수 있습니다.
	//게시물 저장을 위한 메소드
	public void register(HttpServletRequest request);
	
	//게시물 전체를 가져오는 메소드
	//게시물 목록 과 현재 페이지 번호를 같이 넘겨주어야 합니다.
	//게시물 상세보기를 하거나 수정 및 삭제를 했을 때 현재 페이지
	//번호를 같이 넘겨서 목록보기를 하거나 작업이 완료되면
	//현재 페이지로 이동하는게 UI가 좋기 때문입니다.
	//출력할 페이지 번호 관련 데이터도 같이 넘겨주어야 합니다.
	public Map<String,Object> list(SearchCriteria criteria);
	
	//게시물 상세보기를 위한 메소드
	public Board detail(HttpServletRequest request);
	
	//게시물 수정 보기를 위한 메소드
	public Board updateView(HttpServletRequest request);
	
	//게시글 수정을 처리해 줄 메소드를 선언
	public void update(HttpServletRequest request);
	
	//게시글 삭제를 처리해 줄 메소드를 선언
	public void delete(HttpServletRequest request);
}






