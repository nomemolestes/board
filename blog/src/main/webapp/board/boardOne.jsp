<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "vo.Board" %>
<% 	//카테고리 목록
	String categoryName = request.getParameter("categoryName");	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	System.out.println(conn + " <-- conn");
	/*
		SELECT category_name categoryName, COUNT(*) cnt
		FROM board
		GROUP BY category_name
	*/
	String categorySql = "SELECT board_no boardNo, category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	
	// 쿼리에 결과를 Category, Board VO로 저장할 수 없다. -> HashMap을 사용해서 저장하자!
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	while(categoryRs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("categoryName", categoryRs.getString("categoryName"));
		map.put("cnt", categoryRs.getInt("cnt"));
		categoryList.add(map);
	}
	
	//상세보기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));//boardTitle의 값을 넘겨받는다
	System.out.println(boardNo + " <-- boardNo");//디버깅

	PreparedStatement stmt = conn.prepareStatement("SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate FROM board where board_no=?");
	stmt.setInt(1, boardNo);//물음표수와 동일해야함
	System.out.println(stmt+ " <-stmt");//디버깅
	// ResultSet은 ArrayList같은 컬렉션 자료구조타입이지만 보편적 사용이 가능한 타입은 아님, 받은 데이터를 테이블모양으로 변환함
	ResultSet rs = stmt.executeQuery();//쿼리의 결과를 resultset에 저장함,select문을 사용할때 executeQuery사용, 리턴값이 문자열임
	System.out.println(rs+ " <-rs");//디버깅
	
	Board board= null;
	while(rs.next()) { //커서의 다음행이 있으면 true리턴하고 그 행으로 이동,저장된값을 한행단위로 불러옴
		Board b = new Board();//데이터가 있을때만 보드를 만든다
		b.setBoardNo(rs.getInt("boardNo"));
		b.setCategoryName(rs.getString("categoryName"));
		b.setBoardTitle(rs.getString("boardTitle"));
		b.setBoardContent(rs.getString("boardContent"));
		b.setCreateDate(rs.getString("createDate"));
		b.setUpdateDate(rs.getString("updateDate"));
	}
		conn.close(); //conn의 해제, 사용이 끝나면 반납, 연결종료
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div>
		<!-- category별 게시글 링크 메뉴 -->
	<div class="row">
  	<div class="col-sm-2">
		<ul class="list-group">
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					<li class="list-group-item">
						<a href="<%=request.getContextPath()%>/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%><span class="badge badge-pill badge-warning"><%=m.get("cnt")%></span></a>
					</li>
			<%		
				}
			%>
		</ul>
	</div>
	  	<div class="col-sm-7">
		<div class="jumbotron">
	  <h1>Bootstrap Tutorial</h1>
	</div>
	<table class="table table-hover">
		<tr> <!-- 해당하는 값들을 가져와서 테이블을 만든다. -->
			<td>board_no</td>
			<td><%=board.getBoardNo()%></td>
		</tr>
		<tr class="table-dark text-dark">
			<td>category_name</td>
			<td><%=board.getCategoryName()%></td>
		</tr>
		<tr class="table-dark text-dark">
			<td>board_title</td>
			<td><%=board.getBoardTitle()%></td>
		</tr>
		<tr class="table-dark text-dark">
			<td>board_content</td>
			<td><%=board.getBoardContent()%></td>
		</tr>
		<tr>
			<td>create_date</td>
			<td><%=board.getCreateDate()%></td>
		</tr>
		<tr>
			<td>update_date</td>
			<td><%=board.getUpdateDate()%></td>
		</tr>
	</table>
	<div>
	<button type="button" class="btn btn-outline-secondary btn-sm">
		<a href="<%=request.getContextPath()%>/updateBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">수정</a>
	</button>
	<button type="button" class="btn btn-outline-secondary btn-sm">
		<a href="<%=request.getContextPath()%>/deleteBoardForm.jsp?boardNo=<%=board.getBoardNo()%>">삭제</a>
	</button>
	</div>
	</div>
</body>
</html>