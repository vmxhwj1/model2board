package kr.co.pk.domain;

//목록보기의 하단에 출력되는 페이지 번호와 관련된 VO 클래스
public class PageMaker {

	//전체 데이터 개수
	private int totalCount;
	//시작하는 페이지 번호와 끝나는 페이지 번호
	private int startPage;
	private int endPage;
	
	//이전 과 다음 링크 여부
	private boolean prev;
	private boolean next;
	
	//페이지 번호 출력 개수
	private int displayPageNum = 10;
	
	//이전에 설정된 옵션 값을 저장하기 위한 변수
	private SearchCriteria criteria;

	//접근자 메소드
	public int getTotalCount() {
		return totalCount;
	}

	//전체 데이터 개수를 알고 현재 페이지번호(criteria.page)와 
	//출력할 페이지 개수(displayPageNum)를 알면 나머지를 전부 계산 할 수 있습니다.
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		//Math.ceil 함수는 올림을 해주는 함수 입니다.
		endPage =
		(int)(Math.ceil(criteria.getPage()/(double)displayPageNum))
		* displayPageNum;
		//시작 페이지 번호
		startPage = endPage - displayPageNum + 1;
		//이전 페이지 링크 여부
		prev = startPage==1 ? false : true;
		//끝 페이지 번호는 한 가지를 더 확인
		//끝 나는 페이지 번호가 전체 데이터의 페이지 개수보다 크면
		//전체 데이터의 페이지 개수로 설정
		int pagesu = 
			(int)(Math.ceil(
				totalCount/(double)criteria.getPerPageNum()));
		if(endPage > pagesu) {
			endPage = pagesu;
		}
		//마지막 페이지 번호와 페이지 개수가 같으면 다음은 나올 필요 없음
		next = endPage == pagesu ? false : true;
		
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDiaplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public SearchCriteria getCriteria() {
		return criteria;
	}

	public void setCriteria(SearchCriteria criteria) {
		this.criteria = criteria;
	}

	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", diaplayPageNum=" + displayPageNum + ", criteria=" + criteria + "]";
	}
		
}










