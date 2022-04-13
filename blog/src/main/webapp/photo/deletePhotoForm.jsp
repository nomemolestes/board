<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Photo" %>
<%@ page import = "dao.PhotoDao" %>
<%@ page import = "java.util.*" %>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));//photoNo 넘겨받은 문자열 숫자를 정수타입으로 변화
	String photoPw = request.getParameter("photoPw");//photoPw값을 넘겨받음
	//객체생성
	PhotoDao photo = new PhotoDao();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteOhotoForm</title>
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
	<!-- 게시글 리스트 -->
	<h5>삭제하기</h5>
		<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
			<table class="table">
				<tr class="table-dark text-dark">
					<td>삭제할 번호</td>
					<td>
						<input type="number" name="photoNo" value="<%=photoNo%>" readonly="readonly"><br>
					</td>
				<tr class="table-dark text-dark">	
					<td>비번</td>
					<td>
						<input type="password" name="photoPw">
					</td>
				<tr>	
					<td>
						<button type="submit" class="btn btn-outline-danger">삭제</button>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>