<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="jumbotron">
	  <h2>index</h2>
	  </div>
	<div class="container">
		  <h5>이동을 위해 클릭하세요</h5>
	<table class="table table-hover">
		<tr>
		<td>
			<a href="<%=request.getContextPath()%>/index.jsp">홈</a>&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
		<tr>
		<td>
			<a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
		<tr>
		<td>
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp">사진게시판</a>&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
		<tr>
		<td>
			<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF게시판</a>&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
		<tr>
		<td>
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>&nbsp;&nbsp;&nbsp;
		</td>
		</tr>
	</div>
</body>
</html>