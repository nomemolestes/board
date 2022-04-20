<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.sql.*" %>
<%	
	//한글깨짐방지, 인코딩
	request.setCharacterEncoding("utf-8");
	//양식 페이지의 요청받은 값을 정수타입으로 변환함, 순서정렬.
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	//묶어서 한번에 처리함.
	Board board = new Board();
	board.setBoardNo(boardNo);
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	board.setBoardPw(boardPw);
	
	//드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";//ip주소
	String dbuser = "root";//아이디
	String dbpw = "java1234";//비번
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-연결완료");//디버깅
	//쿼리를 전송.저장,
	PreparedStatement stmt = conn.prepareStatement("update board set category_name=?,board_title=?,board_content=?,update_date=now() where board_no=? and board_pw=?");
	stmt.setString(1, categoryName);//몇번째 물음표가 무엇인지를 설명함.순서정렬.
	stmt.setString(2, boardTitle);
	stmt.setString(3, boardContent);
	stmt.setInt(4, boardNo);
	stmt.setString(5, boardPw);
	System.out.println(stmt+" <-쿼리수정완료");//디버깅
	//행의 수정이 성공했는지. 실패했는지 확인
	int row = stmt.executeUpdate();
	if(row == 0) { //행에 변화가 없다면
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/updateBoardForm.jsp?boardNo="+board.getBoardNo());//수정입력페이지로 돌아가시오.
	} else if(row == 1) {//행에 변화가 있다면
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/boardOne.jsp?boardNo="+board.getBoardNo());
	} else {//나머지 경우에는
		System.out.println("오류");
	}
	conn.close();//열려있다면 닫아라, 연결종료임.
	
%>