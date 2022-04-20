<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import= "dao.*" %>
<%@ page import = "java.util.*" %>
<%	
	
	//boardList 페이지를 실행하면 최근 10개목록 보여주고 1p로 설정.
	int currentPage = 1;//현재페이지의 기본값이 1페이지임.
	
	if(request.getParameter("currentPage") != null) {//이전, 다음링크를 통해서 들어온거라면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+ "<-currentPage");
	//페이지가 변경될때마다 본 페이지의 데이터도 변경되어야함. 쿼리(limit n번째 a개를 갖고옴)에서 n만 바뀌면됨.
	//넘어온 페이지번호
	String pageNum = request.getParameter("pageNum");
/*
	필요한 알고리즘 select ... limit 0, 10
currentPage    | 	시작: beginRow
		1				0
		2				10
		3				20
		4				30
		5				40
	currentPage = (currentPage-1)*10
		*/
	
	//블로그 카테고리 목록
	String categoryName = "";
	if(request.getParameter("categoryName") != null) {//이전 다음링크에서 null값을 넘기지못하므로 null을 공백으로 바꿈. 
		categoryName = request.getParameter("categoryName");	
	}
	
	int rowPerPage = 10;//한 페이지에 보고싶은 페이지는 10개의 페이지입니다.	
	int beginRow = (currentPage-1)*rowPerPage;//g현재페이지가 변경되면 beginRow도 변경->갖고오는데이터가 변경됨.
	BoardDao boardDao= new BoardDao();
	ArrayList<Board> list = boardDao.selectBoardListByPage(beginRow, rowPerPage, categoryName);
	
	int lastPage = 0;//마지막 페이지 초기화
	int totalCount = boardDao.selectBoardTotalRow();
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	//Math.ceil 해당하는 값보다 크거나 같은 가장작은 정수값을 double형으로 반환
	//전달된 실수의 소수부분을 무조건 올림
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div>
	<!-- category별 게시글 링크 메뉴 -->
	<div class="bg-warning">
		
				<!-- 메인메뉴, 모든페이지에 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스트명 프로젝트이름이 명시하지않음 -->
	<!-- 메인메뉴 끝. -->
		</div>
	<div class="jumbotron">
	  <h1>BLOG</h1>
	</div>
	</div>
	<!-- 게시글 리스트 -->
	<h6>게시글 목록</h6>
	 <div class="col-sm-9">
	<table class="table-striped">
		<thead>
			<tr>
				<th>categoryName</th>
				<th>boardTitle</th>
				<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : list) {
			%>
					<tr> <!-- contextpath가 변경되도 전체를 다 바꾸지 않아도됨,웹전체경로(프로젝트+파일경로)를 가져옴. -->
						<td><%=b.getCategoryName()%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
						<td><%=b.getCreateDate()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
	<div> <!-- 현재페이지가 10p였다면 이전은 9p, 다음은 11p -->
		<%
			if(currentPage > 1) { //현재페이지가 1이면 이전페이지가 존재하면 안됨.
		%>
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&categoryName=<%=categoryName%>" class="btn btn-outline-secondary btn-sm">이전</a> 		
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
				<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%>" class="btn btn-outline-secondary btn-sm">이전</a> 		
			<%
				}
			%>
	</div>
		<div>
				<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-outline-secondary btn-sm">입력</a>
	</div>
</div>	
</body>
</html>