<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertPdfForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="bg-warning" align="center">
	<!-- 메인메뉴, 모든페이지에 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명 프로젝트이름이 명시하지않음 -->
	<!-- 메인메뉴 끝. -->
	</div>
	
	<div class="jumbotron">
	  <h1>BLOG</h1>
	</div>
	<h6>pdf 등록</h6>
	<form action="./insertPdfAction.jsp" method="post" enctype="multipart/form-data">
	<table class="table table-dark">
		<tr>
			<td>pdf파일</td>
			<td>
				<input type="file" name="pdf">
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pdfPw">
			</td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td>
				<input type="text" name="writer">
			</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-outline-danger">파일 등록</button>
	</form>
</body>
</html>