<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));//요청받은 boardNo값을 정수타입으로 변환해서 저장
	String boardPw = request.getParameter("boardPw");//요청받은 boardPW값을 정수타입으로 변환해서 저장
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="jumbotron">
		<h5>삭제하기</h5>
		<form method="post" action="./deleteBoardAction.jsp">
			<input type="number" name="boardNo" value="<%=boardNo%>"><br>
			<input type="password" name="boardPw" value="<%=boardPw%>">
			<div>
				<button type="submit">삭제</button>
			</div>
		</form>
	</div>
</body>
</html>