<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="vo.Photo" %>
<%@ page import="dao.PhotoDao" %>
<%
	//상세보기 요청값 가져와서 변환, 가져오기
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	//객체생성. dao호출
	PhotoDao photoDao = new PhotoDao();
	Photo photo = photoDao.photoOne(photoNo);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectPhotoOne</title>
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
	<h6>상세보기</h6>
	<table class="table table-hover">
		<tr>
			<td>번호</td>
			<td><%=photo.getPhotoNo()%></td>
		</tr>
		<tr>
			<td>
				<img src="<%=request.getContextPath()%>/koala/<%=photo.getPhotoName()%>">
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%=photo.getPhotoName()%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=photo.getWriter()%></td>
		</tr>
		<tr>
			<td>작성일자</td>
			<td><%=photo.getCreateDate() %></td>
		</tr>
		<tr>
			<td>수정일자</td>
			<td><%=photo.getUpdateDate()%></td>
		</tr>
	</table>
	<div>
	<button type="button" class="btn btn-outline-secondary btn-sm">
		<a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photo.getPhotoNo()%>">삭제</a>
	</button>
	</div>
</body>
</html>