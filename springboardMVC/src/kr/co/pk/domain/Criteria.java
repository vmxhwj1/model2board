package kr.co.pk.domain;
//현재 페이지 번호, 페이지 당 출력할 데이터 개수, 
//페이지에 출력될 데이터의 시작 번호를 저장하는 VO 클래스
public class Criteria {
	//현재 출력 중 인 페이지 번호를 저장할 변수
	private int page;
	//페이지에 출력할 데이터 개수
	private int perPageNum;
	//현재 페이지에 출력될 데이터의 시작 번호
	//이 데이터는 page 와 perPageNum이 결정되면 자동으로 결정되는 항목
	private int pageStart;
	
	//생성자 - 객체를 만들 때 처음 호출되는 메소드
	//보통은 인스턴스 변수의 초기화를 위해서 재정의합니다.
	public Criteria() {
		page = 1;
		perPageNum = 10;
	}

	//접근자 메소드
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}

	public int getPageStart() {
		//자동으로 계산
		//page-현재 페이지 번호
		//perPageNum-페이지 당 출력 개수
		pageStart = (page-1)*perPageNum + 1;
		return pageStart;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", pageStart=" + pageStart + "]";
	}

	/*
	//현재 페이지의 데이터 시작 번호는 입력받는 항목이 아니므로
	//setter를 제거해서 만약의 경우를 대비합니다.
	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}
	*/

	
}







