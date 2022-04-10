<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 다른 페이지의 부분으로사용 -->
	<div>
		<a href="<%=request.getContextPath()%>/index.jsp">홈</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp">사진게시판</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp">PDF게시판</a>&nbsp;&nbsp;&nbsp;
		<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp">방명록</a>&nbsp;&nbsp;&nbsp;
	</div>