<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>

<%
	int guestbookNo= Integer.parseInt(request.getParameter("guestbookNo"));//요청받은 guestbookNo값을 정수타입으로 변환해서 저장
	String guestbookPw = request.getParameter("guestbookPw");//요청받은 guestbookPw값을저장
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="bg-warning">
		
				<!-- 메인메뉴, 모든페이지에 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명 프로젝트이름이 명시하지않음 -->
	<!-- 메인메뉴 끝. -->
		</div>
	<div class="jumbotron">
		  <h1>BLOG</h1>
	
	</div>
		<div class="jumbotron">
	
		<h5>삭제하기</h5>
		<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp">
			<input type="number" name="guestbookNo" value="<%=guestbookNo%>" readonly ="readonly"><br>
			<input type="password" name="guestbookPw">
			<div>
				<button type="submit">삭제</button>
			</div>
		</form>
	</div>
</body>
</html>