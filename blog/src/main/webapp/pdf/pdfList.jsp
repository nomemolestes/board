<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//페이지 묶음
	int currentPage = 1;//현재페이지의 기본값이 1페이지임.
	if(request.getParameter("currentPage") != null) {//이전, 다음링크를 통해서 들어온거라면
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+ "<-currentPage");
	String pageNum = request.getParameter("pageNum");

	int beginRow = 0;
	int rowPerPage = 5;
	//객체생성, dao호출
	Pdf pdf = new Pdf();
	PdfDao pdfDao = new PdfDao();
	ArrayList<Pdf> list = pdfDao.selectPdfListByPage(beginRow, rowPerPage);
	int lastPage = 0;//마지막 페이지 초기화
	int totalCount = pdfDao.selectPdfTotalRow();
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pdf list</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

</head>
<body>
	<div>
	<div class="bg-warning">
		
				<!-- 메인메뉴, 모든페이지에 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명 프로젝트이름이 명시하지않음 -->
	<!-- 메인메뉴 끝. -->
	</div>
	
	<div class="jumbotron">
	  <h1>BLOG</h1>
	  <p></p>
	</div>
	<!-- 게시글 리스트 -->
	</div>
	<!-- 게시글 리스트 -->
	<h3>pdf 글 목록</h3>
		<table class="table">
		<%
			for(Pdf p : list) {			
		%>
			<tr class="table-warning">
				<td>
					<a href="<%=request.getContextPath()%>/pdf/pdfOne.jsp?pdfNo=<%=p.pdfNo%>"><%=p.pdfName%></a>
				</td>
			</tr>
		<%		
				}
		%>	
	</table>

	<div> <!-- 현재페이지가 10p였다면 이전은 9p, 다음은 11p -->
		<%
			if(currentPage > 1) { //현재페이지가 1이면 이전페이지가 존재하면 안됨.
		%>
		<button type="button" class="btn btn-outline-secondary">
			<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage-1%>">이전</a> <!-- 현재페이지값을넘겨줌/현재페이지에서 1을빼줌-->
		</button>
		<%		
			}
		%>
			<!-- 마지막 페이지 구하기
					전체행  마지막페이지
					10개		1p
					11-20	2p
					21-30	3p
					31-40	4p
				마지막 페이지 = 전체행/rowPerPage
			. -->
			<%
			
				//
				if(currentPage < lastPage) {
			%>	
			<button type="button" class="btn btn-outline-secondary btn-sm">
			<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp?currentPage=<%=currentPage+1%>">다음</a>	 <!-- 현재페이지값을넘겨줌/현재페이지에서 1을빼줌-->
			</button>
			<%
				}
			%>
	</div>
</body>
</html>