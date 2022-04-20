package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Board;

public class BoardDao {
	public BoardDao() {}//생성자메서드
	
	//입력
	public void insertBoardList(Board board) throws Exception {
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		//드라이버 연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리전송.저장
		String sql = "insert into board(board_no, category_name, board_title, board_content, board_pw, create_date, update_date) values (?,?,?,?,?,now(), now()) "; 
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, board.getBoardNo());
		stmt.setString(2, board.getCategoryName());
		stmt.setString(3, board.getBoardTitle());
		stmt.setString(4, board.getBoardPw());
		stmt.setString(5, board.getBoardPw());
		int row= stmt.executeUpdate();//insert-update
		if(row == 1) {
			System.out.println("입력성공");//행의 1줄 변화가 생긴다면 입력성공한것
		} else {
			System.out.println("입력실패");//행의 변화가 없다면 입력 실패한것
		}
		stmt.close();
		conn.close();//연결종료
	}
	//삭제
	public void deleteBoard(int BoardNo, String categoryName) {
		
	}
	//board 전체 행의 수를 반환하는 메서드
	public int selectBoardTotalRow() throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리전송실행
		String sql = "select count(*) cnt from board";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	//board n행씩 반환 메서드
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage, String categoryName) throws Exception {
		ArrayList<Board> list = new ArrayList<Board>();
		// board 10행 반환되도록 구현
		Class.forName("org.mariadb.jdbc.Driver");
	
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
			
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		stmt.setString(3, categoryName);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		// 데이터 변환(가공)
		while(rs.next()) { //다음행의 커서뒤에 데이터가 있으면 갖고온다.
			Board b = new Board();
			b.setBoardNo(rs.getInt("boardNo"));
			b.setCategoryName(rs.getString("categoryName"));
			b.setBoardTitle(rs.getString("boardTitle"));
			b.setBoardContent(rs.getString("boardContent"));
			b.setBoardPw(rs.getString("boardPw"));
			b.setCreateDate(rs.getString("createDate"));
			b.setUpdateDate(rs.getString("updateDate"));
			list.add(b);//리스트 추가.
		}
			
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	//카테고리목록
	public ArrayList<String> selectCatecoryList(String categoryName) throws Exception{
		//ArraList
		ArrayList<String> list = new ArrayList<String>();
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//db연결
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		//db접속
		String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
		String dbuser = "root"; //db계정
		String dbpw = "java1234"; //비밀번호
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println(conn + " : conn결과");//디버깅

		//쿼리문 가져와서 저장
		String sql = "SELECT category_name categoryName FROM category order by category_name ASC";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		while(rs.next()) {
			list.add(rs.getString("categoryName"));
		}	
		rs.close();
		stmt.close();
		conn.close();//db종료

		return list;
	}
	//카테고리 목록과 그에따른 글의 수
	public ArrayList<HashMap<String,Object>> categoryList() throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//maria db접속
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String dburl = "jdbc:mariadb://localhost:3306/blog"; //db주소
		String dbuser = "root"; //db계정
		String dbpw = "java1234"; //비밀번호
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		System.out.println(conn + " : conn결과");//디버깅

		String sql="SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();

		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryName", rs.getString("categoryName"));
			map.put("cnt", rs.getInt("cnt"));
			list.add(map);
		}
		rs.close();
		stmt.close();
		conn.close();//db종료
		return list;

	}
	//boardList, boardNo categoryName boardTitle createDate목록
	public ArrayList<Board> boardList(int beginRow, int rowPerPage, String categoryName) throws Exception{
		ArrayList<Board> list = new ArrayList<Board>();
		Class.forName("org.mariadb.jdbc.Driver");
		//데이터베이스 자원 준비
		String sql = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root"; 
		String dbpw = "java1234"; 
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		if(categoryName == "") { 
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow); 
			stmt.setInt(2, rowPerPage); //행개수
		} else {
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setInt(2, beginRow); 
			stmt.setInt(3, rowPerPage);
		}
				rs = stmt.executeQuery();
				while(rs.next()) { 
					Board b = new Board(); 
					b.setBoardNo(rs.getInt("BoardNo"));
					b.setCategoryName(rs.getString("categoryName"));
					b.setBoardTitle(rs.getString("boardTitle"));
					b.setCreateDate(rs.getString("createDate"));
					list.add(b); 
				}
				rs.close();
				stmt.close();
				conn.close();
				
				return list;
	}
}
