package vo;

public class Guestbook {
	public Guestbook() {}//생성자메서드 항상 입력
	//이 클래스 안에서만 사용
	private int guestbookNo;
	private String guestbookContent;
	private String writer;
	private String createDate;
	private String updateDate;
	private String guestbookPw;
	
	//public메서드를 제공
	public int getGuestbookNo() {
		return guestbookNo;
	}
	public String getGuestbookContent() {
		return guestbookContent;
	}
	public String getWriter() {
		return writer;
	}
	public String getCreateDate() {
		return createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public String getGuestbookPw() {
		return guestbookPw;
	}
	public void setGuestbookNo(int guestbookNo) {
		this.guestbookNo = guestbookNo;
	}
	public void setGuestbookContent(String guestbookContent) {
		this.guestbookContent = guestbookContent;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public void setGuestbookPw(String guestbookPw) {
		this.guestbookPw = guestbookPw;
	}

}
