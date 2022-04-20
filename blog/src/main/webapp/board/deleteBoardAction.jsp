<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//삭제 할 board번호를 가져와서 정수타입으로 변환
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	//한번에 묶어서 처리함??
	Board board = new Board();
	board.setBoardNo(boardNo);
	//maria db 드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";//접속ip주소
	String dbuser = "root";//아이디
	String dbpw = "java1234";//비번
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- 연결성공");//디버깅
	//쿼리저장
	PreparedStatement stmt = conn.prepareStatement("delete from board where board_no=?");
	//실행하려는 쿼리를 전송해주는게 PreparedStatement이므로 괄호안에 실행할 쿼리를 적어준다.
	System.out.println(stmt+" <-전송성공");//디버깅
	stmt.setInt(1, boardNo);//몇번째 물음표인지와 그게 무엇인지에 대한 설명임.
	//쿼리의 실행
	int row = stmt.executeUpdate();//값을 row에 저장, 
	if(row == 0) {//삭제실패하면, 변화한 행이 없으므로 삭제가 실패한것임
		response.sendRedirect("./deleteBoardForm.jsp");//다시 입력페이지로 돌아가라.
		System.out.println("삭제실패");
	} else if (row == 1) { //삭제성공하면, 행이 변화했으므로 성공한것.
		response.sendRedirect("./boardList.jsp");//성공했으니 리스트페이지로 가시오.
		System.out.println("삭제성공");
	} else {
		System.out.println("에러");
	}

	
	
	
%>