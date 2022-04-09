package dao;
import java.util.*;
import vo.*;
import java.sql.*;
public class GuestbookDao {
	// 생성자 메서드
	public GuestbookDao() {}
	// 입력
	// GuestbookDao guestbookDao = new GuestbookDao();
	// Guestbook guestbook = new Guestbook();
	// guestbookDao.insertGuestbook(guestbook); 호출
	public void insertGuestbook(Guestbook guestbook) throws Exception { //void-x-close
		Guestbook g = new Guestbook();
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		//드라이버접속
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";

		/* INSERT INTO guestbook(
		 	guestbook_content, writer, guestbook_pw, create_date, update_date
		 ) VALUES(?,?,?,NOW(),NOW()) */
		//쿼리전송.저장
		String sql = "INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES (?,?,?,NOW(),NOW())";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, this.??);//몇번째이고 무엇을 의미하는지
		stmt.setString(2, guestbook.writer);
		stmt.setString(3, guestbook.guestbookPw);
		//쿼리실행
		int row = stmt.executeUpdate();
		if(row == 1) { //행변화가 있다면
			System.out.println("입력성공");
		} else {//그 외의 나머지는
			System.out.println("입력실패");
		}
		stmt.close();//반납
		conn.close();//반납
	}
	// 수정, 상세보기 (guestbookOne, updateGuestbook)
	//updateGuestbookForm.jsp에서 호출
	//throws Ex~:예외가 발생하면 사용자에게 그대로 보여줌
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception { //Guestbook-rs-if-return guestbook
		Guestbook guestbook = null;//null을 넘김
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
		String sql = "select guestbook_no guestbookNo, guestbook_content guestbookContent from guestbook where guestbook_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);//몇번째 물음표가 무엇인지
		System.out.println(stmt+ "<-sql selectOne");//디버깅
		//쿼리실행
		rs = stmt.executeQuery();//select-Query
		if(rs.next()) {
			guestbook = new Guestbook();//기본생성자메서드
			guestbook.guestbookNo = rs.getInt("guestbookNo");//guestbook에 채울것
			guestbook.guestbookContent = rs.getString("guestbookContent");//guestbook에 채울것
		}
		rs.close();//반납
		stmt.close();//반납
		conn.close();//반납
		return guestbook;
	}
	//updateGuestbookAction.jsp에서 호출
	//이름; updateGuestbook, 반환타입;수정한 행의 수를 반환함;0은 수정실패 1은 수정성공->int
	//입력매개변수;guestbookNo, guestbookContent,guestbookPw->하나의 매개변수로 받고싶음(vo를 만들거나, Hashmap)->Guestbook타입사용함
	public int updateGuestbook(Guestbook guestbook) throws Exception { //int-int-close-return
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.guestbookContent);
		stmt.setInt(2, guestbook.guestbookNo);
		stmt.setString(3, guestbook.guestbookPw);
		System.out.println(stmt+" <-- sql updateGuestbook"); 
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	// 삭제(deleteGuestbook)
	//이름 deleteGuestbook
	//반환타입 row; 대체로 통일하는게 나음.;삭제한 행의수반환 0삭제실패 1삭제성고->int
	//입력매개변수 guestbookNo guestbookPw ->int String->따로 각각받음->Guestbook타입을 사용해도됨.
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0;
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		//쿼리전송
		String sql ="delete from guestbook where guestbook_no=? and guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		System.out.println(stmt +"<-sql deleteGuestbook");
		row = stmt.executeUpdate();
			
		stmt.close();
		conn.close();
		return row;
	}

	
	// guestbook 전체 행의 수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";

		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	// guestbook n행씩 반환 메서드
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Guestbook> list = new ArrayList<Guestbook>();
		// guestbook 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버 연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 

		/*
		 SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate 
		 FROM guestbook 
		 ORDER BY create_date 
		 DESC LIMIT ?, ?
		 */
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Guestbook g = new Guestbook();
			g.guestbookNo = rs.getInt("guestbookNo");
			g.guestbookContent = rs.getString("guestbookContent");
			g.writer = rs.getString("writer");
			g.createDate = rs.getString("createDate");
			list.add(g);
		}
		
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
	
		return list;
	 }

	
}
