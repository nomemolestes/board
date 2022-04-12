<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//요청값 받아오기
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));//파일번호
	String pdfPw = request.getParameter("pdfPw");//비번
	//객체생성
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePdfForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="bg-warning">
	<!-- 메인메뉴, 모든페이지에 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명 프로젝트이름이 명시하지않음 -->
	<!-- 메인메뉴 끝. -->	
	</div>
	<div class="junbotron">
		<h1>BLOG</h1>
	</div>
	<h5>삭제하기</h5>
		<form method="post" action="<%=request.getContextPath()%>/pdf/deletePdfAction.jsp">
			<table class="table">
				<tr class="table-dark text dark">
					<td>삭제할 번호</td>
					<td>
						<input type="text" name="pdfNo" value="<%=pdfNo%>" readonly = "readonly">
					</td>
				</tr>
				<tr class="table-dark text dark">
					<td>비밀번호</td>
					<td>
						<input type="password" name="pdfPw">
					</td>
				</tr>
				<tr>
					<td>
						<button class="submit" class="btn btn-outline-danger">삭제</button>
					</td>
				</tr>
			</table>
		</form>
</body>
</html>