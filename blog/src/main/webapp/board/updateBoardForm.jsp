<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
		
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));//요청받은 값을 정수타입으로 변경해주세요
	//드라이버 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	//연결
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";//ip주소
	String dbuser = "root";//아이디
	String dbpw = "java1234";//비번
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn");//디버깅 
	//쿼리를 전송한다
	PreparedStatement stmt = conn.prepareStatement("select board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate from board WHERE board_no = ?");
	stmt.setInt(1, boardNo);//몇번째 물음표가 무엇인지 설명함.
	ResultSet rs = stmt.executeQuery();//쿼리의 실행값을 테이블모양으로 저장한다.
	System.out.println(rs+"<-rs");//디버깅
	
	Board board= null;
	if(rs.next()) { //커서의 다음행이 있으면 true리턴하고 그 행으로 이동,저장된값을 한행단위로 불러옴
		Board b = new Board();//데이터가 있을때만 보드를 만든다
		b.setBoardNo(rs.getInt("boardNo"));
		b.setBoardTitle(rs.getString("boardTitle"));
		b.setBoardContent(rs.getString("boardContent"));
		b.setCreateDate(rs.getString("createDate"));
		b.setUpdateDate(rs.getString("updateDate"));
	}
	//카테고리 목록(선택용)
	PreparedStatement categoryStmt = conn.prepareStatement("select category_name from category");
	System.out.println(categoryStmt+ "<-categoryRs");//디버깅
	
	ResultSet categoryRs = categoryStmt.executeQuery();//select만 executeQuery를 사용함.
	ArrayList<String> list = new ArrayList<String>();
	while(categoryRs.next()) {
		list.add(categoryRs.getString("category_name"));
	}
	conn.close(); //conn의 해제, 사용이 끝나면 반납, 연결종료
	/* 액션페이지에서 실행할 쿼리는 update board set category_name=? board_title=? board_content=?
			update_date=now() where board_no=? and board_no=? */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="jumbotron">
	<h2>수정하기</h2>
	</div>
	<form method="post" action="<%=request.getContextPath()%>/updateBoardAction.jsp">
		<table class="table table-hover">
			<tr>
				<td>boardNo</td>
				<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>categoryName</td>
				<td>
					<select name="categoryName">
						<%
							for(String s : list) {
								if(s.equals(board.getCategoryName())) {
						%>
							<option selected="selected" value="<%=s%>"><%=s%></option>
						<%				
								} else {
						%>
							<option value="<%=s%>"><%=s%></option>
						<%		
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>boardTitle</td>
				<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
			</tr>
			<tr>
				<td>boardContent</td>
				<td>
					<textarea rows="7" cols="70" name="boardContent"><%=board.getBoardContent()%></textarea>
				</td>
			</tr>
			<tr>
				<td>boardPw</td>
				<td><input type="password" name="boardPw" value=""></td>
			</tr>	
		</table>
			<button type="submit">수정</button>
	</form>
</body>
</html>