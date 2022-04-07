<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
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
	String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
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
	
	// boardList
	String boardSql = null;
	PreparedStatement boardStmt = null;
	if(categoryName == null) {
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT 0, 10";
		boardStmt = conn.prepareStatement(boardSql);
	} else {
		boardSql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT 0, 10";
		boardStmt = conn.prepareStatement(boardSql);
		boardStmt.setString(1, categoryName);
	}
	ResultSet boardRs = boardStmt.executeQuery();
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(boardRs.next()) {
		Board b = new Board();
		b.boardNo = boardRs.getInt("boardNo");
		b.categoryName = boardRs.getString("categoryName");
		b.boardTitle = boardRs.getString("boardTitle");
		b.createDate = boardRs.getString("createDate");
		boardList.add(b);
	}
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<style type="text/css">
	tabel, th, td {
		border: 1px solid pink;
	}
</style>
</head>
<body>
	<!-- category별 게시글 링크 메뉴 -->
	<div>
		<ul>
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					<li>
						<a href="<%=request.getContextPath()%>/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a>
					</li>
			<%		
				}
			%>
		</ul>
	</div>
	
	<!-- 게시글 리스트 -->
	<h1>게시글 목록</h1>
	<table>
		<thead>
			<tr>
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : boardList) {
			%>
					<tr>
						<td><%=b.categoryName%></td>
						<td><a href="<%=request.getContextPath()%>/boardOne.jsp?boardNo=<%=b.boardNo%>"><%=b.boardTitle%></a></td>
						<td><%=b.createDate%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
</body>
</html>
