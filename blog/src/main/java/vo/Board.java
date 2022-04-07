package vo;

public class Board {
	public Board() {}
	//정보은닉
	private int boardNo; //필드의 정보은닉
	private String categoryName;
	private String boardTitle;
	private String boardContent;
	private String boardPw;
	private String createDate; 
	private String updateDate;
	
	@Override
	public String toString() {
		return "Board [boardNo=" + this.boardNo + ", this.categoryName=" + categoryName + ", this.boardTitle=" + boardTitle
				+ ", this.boardContent=" + boardContent + ", this.boardPw=" + boardPw + ", this.createDate=" + createDate
				+ ", this.updateDate=" + updateDate + "]";
	}
	//getters
	public int getBoardNo() {
		return boardNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public String getBoardPw() {
		return boardPw;
	}
	public String getCreateDate() {
		return createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	//setters
	public void setBoardNo(int boardNo) { //메서드 정보은닉
		this.boardNo = boardNo;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public void setBoardPw(String boardPw) {
		this.boardPw = boardPw;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
}	