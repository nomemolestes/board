package dao;
import java.util.ArrayList;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import vo.Photo;

public class PhotoDao {
	public PhotoDao() {}
	//이미지 이름반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		String photoName="";
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		//쿼리전송	
		//select photo_name from photo where photo_no=?
		String sql = "select photo_name photoName from photo where photo_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);//몇번째 물음표가 무엇인지 설명
		System.out.println(stmt+"<-stmt");
		rs = stmt.executeQuery();//select-query
		//쿼리실행
		if(rs.next()) {
			photoName = rs.getString("photoName");
		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
		return photoName;
	}
	//이미지입력
	public void insertPhoto(Photo photo) throws Exception {
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리전송
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.getPhotoName());//몇번째 물음표에 어떤게 들어가는지.
		stmt.setString(2, photo.getPhotoOriginalName());
		stmt.setString(3, photo.getPhotoType());
		stmt.setString(4, photo.getPhotoPw());
		stmt.setString(5, photo.getWriter());
		//쿼리실행
		rs = stmt.executeQuery();//insert-update
		while(rs.next()) {
			Photo p = new Photo();
			p.setPhotoName(rs.getString("photo_name"));
			p.setPhotoName(rs.getString("photo_original_name"));
			p.setPhotoType(rs.getString("photo_type"));
			p.setPhotoPw(rs.getString("photo_pw"));
			p.setWriter(rs.getString("writer"));
		}
		rs.close();
		stmt.close();//연결종료.반환
		conn.close();//연결종료.반환
	}
	//사진삭제하기
	//이름 deletePhoto 반환타입 row-int
	//입력매개변수 photoNo photoPw
	public int deletePhoto(int PhotoNo, String photoPw) throws Exception {//photoNo, photoPw
		int row = 0;
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//연결.쿼리전송
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		String sql = "delete from photo where photo_no=? and photo_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, PhotoNo);//몇번째 물음표가 무엇을 뜻하는지
		stmt.setString(2, photoPw);
		System.out.println(stmt+" <-sql deletePhoto");//디버깅
		row = stmt.executeUpdate();
		
		stmt.close();//반납
		conn.close();//반납
		return row;
	}
	//이미지 목록
	// photo n행씩 반환 메서드
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception { //예외를 허용한다.
		ArrayList<Photo> list = new ArrayList<Photo>();
		Class.forName("org.mariadb.jdbc.Driver");
		//드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;//데이터를 테이블모양으로 저장.
		//드라이버 연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		//쿼리전송
		String sql = "select photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, photo_type photoType, photo_pw photoPw, writer, create_date createDate, update_date updateDate FROM photo ORDER BY create_date desc limit ?,?";
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);//몇번째 물음표 무엇인지 ,beginRow번째만큼
		stmt.setInt(2, rowPerPage);//rowPerPage만큼 가져온다
		rs = stmt.executeQuery();//select-query
		//쿼리실행,데이터변환(가공)
		while(rs.next()) {
			Photo p = new Photo();//새로운 객체생성
			p.setPhotoNo(rs.getInt("photoNo"));
			p.setPhotoName(rs.getString("photoName"));
			p.setPhotoOriginalName(rs.getString("photoOriginalName"));
			p.setPhotoType(rs.getString("photoType"));
			p.setPhotoPw(rs.getString("photoPw"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate"));
			p.setUpdateDate(rs.getString("updateDate"));
			list.add(p);//목록에 추가함
		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	//전체 갯수를 알아야 페이징 가능하므로, 전체갯수 구하는 코드
	// guestbook 전체 행의 수를 반환 메서드
	public int selectPhotoTotalRow() throws Exception {
		int totalrow = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버 연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리전송
		String sql = "select count(*) cnt from photo";
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();//select-query
		//쿼리실행
		if(rs.next()) {
			totalrow = rs.getInt("cnt");
		}
		return totalrow;
	}
	//이미지 1개 상세보기
	public Photo photoOne(int photoNo) throws Exception {
		Photo photo = null;//null값을 넘김.
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		//쿼리전송	
		String sql = "SELECT photo_no photoNo, photo_name photoName, writer, create_date createDate, update_date updateDate FROM photo WHERE photo_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);//몇번째 물음표가 무엇인지 설명
		System.out.println(stmt+"<-상세보기");
		//쿼리실행
		rs = stmt.executeQuery();
		while(rs.next()) { //다음 행에 값이 있다면
			Photo p = new Photo();//새로운 객체생성,기본생성자메서드
			p.setPhotoNo(rs.getInt("photoNo"));//이 값을 채움
			p.setPhotoName(rs.getString("photoName"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate"));
			p.setUpdateDate(rs.getString("updateDate"));
		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
		return photo;
	}
}

