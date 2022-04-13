package vo;

public class Photo {
	public Photo() {}
	
	private int photoNo;
	private String photoName;
	private String photoOriginalName;
	private String photoType;
	private String photoPw;
	private String writer;
	private String createDate;
	private String updateDate;
	
	public int getPhotoNo() {
		return photoNo;
	}
	public String getPhotoName() {
		return photoName;
	}
	public String getPhotoOriginalName() {
		return photoOriginalName;
	}
	public String getPhotoType() {
		return photoType;
	}
	public String getPhotoPw() {
		return photoPw;
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
	public void setPhotoNo(int photoNo) {
		this.photoNo = photoNo;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public void setPhotoOriginalName(String photoOriginalName) {
		this.photoOriginalName = photoOriginalName;
	}
	public void setPhotoType(String photoType) {
		this.photoType = photoType;
	}
	public void setPhotoPw(String photoPw) {
		this.photoPw = photoPw;
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

}
