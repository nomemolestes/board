package dao;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import vo.Board;

public class BoardDao {
	public BoardDao() {}//생성자메서드
	//입력
	public void insertBoard(Board board) throws Exception {
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
		stmt.setInt(1, insertBoard.setBoardNo());//몇번째 물음표 무엇인지설명
		stmt.setString(2, Board.categoryName);//몇번째 물음표 무엇인지설명
		stmt.setString(3, board.boardTitle);
		stmt.setString(4, board.boardContent);
		stmt.setString(5, board.boardPw);
		int row= stmt.executeUpdate();//insert-update
		if(row == 1) {
			System.out.println("입력성공");//행의 1줄 변화가 생긴다면 입력성공한것
		} else {
			System.out.println("입력실패");//행의 변화가 없다면 입력 실패한것
		}
		stmt.close();
		conn.close();//연결종료
	}

	
	//수정
	public void updateBoard(Board board) {}
	//삭제
	public void deleteBoard(int BoardNo, String categoryName) {}
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
	public ArrayList<Board> selectBoardListByPage(int beginRow, int rowPerPage) throws Exception {
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
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		// 데이터 변환(가공)
		while(rs.next()) { //다음행의 커서뒤에 데이터가 있으면 갖고온다.
			Board b = new Board();
			b.boardNo = rs.getInt("boardNo");
			b.categoryName = rs.getString("categoryName");
			b.boardTitle = rs.getString("boardTitle");
			b.boardContent = rs.getString("boardContent");
			b.boardPw = rs.getString("boardPw");
			b.createDate = rs.getString("createDate");
			b.updateDate = rs.getString("updateDate");
			list.add(b);//리스트 추가.
		}
			
		// 데이터베이스 자원들 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
