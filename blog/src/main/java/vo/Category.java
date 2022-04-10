package vo;
//category테이블 vo(도메인객체): vo, dto, Domain
public class Category {
	public Category() {}
	
	private String categoryName;
	private String createDate;
	private String updateDate;
	
	public String getCategoryName() {
		return categoryName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

}
