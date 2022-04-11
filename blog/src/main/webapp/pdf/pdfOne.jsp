<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%> 
<%@ page import="dao.*"%> 
<%@ page import="java.io.*"%> 
<%
	//요청값 받아옴, 문자열숫자를 정수타입으로 변환
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	//객체생성, dao호출
	PdfDao pdfDao = new PdfDao();
	Pdf pdf = pdfDao.selectPdfOne(pdfNo);
	//pdf용

 



 




%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PdfOne</title>
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
	<h6>상세보기</h6>
	<table class="table table-hover">
		<tr class="table-warning">
			<td>번호</td>
			<td><%=pdf.pdfNo%></td>
		</tr>
		<tr class="table-warning">
			<td>
				<a href="<%=request.getContextPath()%>/pdfa/<%=pdf.pdfName%>"><%=pdf.pdfName%></a>
				<!-- pdf뷰어페이지 생성 -->
			</td>
		</tr>
		<tr class="table-warning">
			<td>작성자</td>
			<td><%=pdf.writer%></td>
		</tr>
		<tr class="table-warning">
			<td>작성일자</td>
			<td><%=pdf.createDate%></td>
		</tr>
		<tr class="table-warning">
			<td>수정일자</td>
			<td><%=pdf.updateDate%></td>
		</tr>
	</table>
	<div>
		<button type="button" class="btn btn-outline-secondary btn-sm">
			<a href="<%=request.getContextPath()%>/pdf/deletePdfForm.jsp?pdfNo=<%=pdf.pdfNo%>">삭제</a>
		</button>
	</div>
</body>
</html>