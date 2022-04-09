<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<% 	
	
	//상세보기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));//writer의 값을 넘겨받는다
	System.out.println(guestbookNo+ " <- guestbookNo");//디버깅
	//guestbookdao 호출
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = new Guestbook();
	guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>guestbookOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div>
	<div class="row">
  	<div class="col-sm-2">

	</div>
	  	<div class="col-sm-7">
		<div class="jumbotron">
	  <h3>상세보기</h3>
	</div>
	<table class="table table-hover">
		<tr> <!-- 해당하는 값들을 가져와서 테이블을 만든다. -->
			<td>guestbook_no</td>
			<td><%=guestbook.guestbookNo%></td>
		</tr>
		<tr class="table-dark text-dark">
			<td>guestbook_content</td>
			<td><%=guestbook.guestbookContent%></td>
		</tr>
	</table>
	<div>
	<button type="button" class="btn btn-outline-secondary btn-sm">
		<a href="<%=request.getContextPath()%>/updateGuestbookForm.jsp?guestbookNo=<%=guestbook.guestbookNo%>">수정</a>
	</button>
	<button type="button" class="btn btn-outline-secondary btn-sm">
		<a href="<%=request.getContextPath()%>/deleteGuestbookForm.jsp?guestbookNo=<%=guestbook.guestbookNo%>">삭제</a>
	</button>
	</div>
	</div>
</body>
</html>