<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	String categoryName = request.getParameter("categoryName");	

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
		b.setBoardNo(boardRs.getInt("boardNo"));
		b.setCategoryName(boardRs.getString("categoryName"));
		b.setBoardTitle(boardRs.getString("boardTitle"));
		b.setCreateDate(boardRs.getString("createDate"));
		boardList.add(b);
	}
	
	//카테고리 목록
	BoardDao boardDao = new BoardDao();
	ArrayList<String> list = boardDao.selectCatecoryList(categoryName);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>

	<!-- category별 게시글 링크 메뉴 -->
	
		<form method="post" action="<%=request.getContextPath() %>/board/insertBoardAction.jsp">
  			<table class="table table-striped">
  				<tr>
					<td>categoryName</td>
					<td>
						<select name="categoryName" class="custom-select">
						<%
							for(String s : list){
						%>
							<option value="<%=s%>"><%=s%></option>
						<%		
							}
						%>
					</select>
					</td>
				</tr>
				<tr>
					<td>boardTitle</td>
					<td>
						<input name="boardTitle" type="text" class="form-control">
					</td>
				</tr>
				<tr>
					<td>boardContent</td>
					<td>
						<textarea name="boardContent" rows="5" cols="80" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td>boardPw</td>
					<td>
						<input name="boardPw" type="password" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit" class="btn btn-outline-success">입력</button>
					</td>
				</tr>
			</table>
	</form>
</body>
</html>
