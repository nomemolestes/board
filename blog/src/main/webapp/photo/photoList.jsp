<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "vo.Photo" %>
<%@ page import = "dao.PhotoDao" %>
<%
//photoList 페이지를 실행하면 최근 5개목록 보여주고 1p로 설정.
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
	int beginRow = 0;
	int rowPerPage = 5;
	//dao호출
	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
	int lastPage = 0;//마지막 페이지 초기화
	int totalCount = photoDao.selectPhotoTotalRow();
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
<title>photoList</title>
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
	<h3>이미지 목록</h3>
	<table class="table table-dark">
		<%
		//한 행에 5개 이미지가 출력(tr안에 td가 5개)
		//이미지가 3개 -tr 1개> td 5개
		//이미지가 5개 tr 1개>td 5개
		//이미지가 10개 tr 2개>td 10개
		//이미지가 9개 tr 2개>td 10개
		
		//td의 갯수가 5의배수가 되도록
		//list.size()가 1-5 -td는 5개
		//list.size()가 6-10 -td는 10개
		System.out.println(list.size()+"<=list.size()");
		
			//int startIdx = 1;//무조건 1부터임
			int endIdx = (((list.size()-1)/5)+1)*5;//5의 배수가 되어야함(하나의 줄에 5개씩 나올수있게)
			System.out.println(endIdx+"<-10");
		//	for(Photo p : list) {//size만큼 반복되므로 5의배수가 아닐수도 있음.
			for(int i = 0; i<endIdx; i++) {//01234, 0123456789 9개인데 조건으로 인해서 10개를 반복문을 돌ㄹ림.
				if(i!=0 && i%5==0) {
		%>
			<tr></tr>
		<%		
				}
			
				if(i<list.size()) {
		%>	
				<td>
					<a href="<%=request.getContextPath()%>/photo/photoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
						<img src="<%=request.getContextPath()%>/koala/<%=list.get(i).getPhotoName()%>" width="250" height="250">
					</a>		
				</td>
		<%
				} else {
		%>
				<td>&nbsp;</td>
		<%	
				}
			}
		%>
	</table>
	<div> <!-- 현재페이지가 10p였다면 이전은 9p, 다음은 11p -->
		<%
			if(currentPage > 1) { //현재페이지가 1이면 이전페이지가 존재하면 안됨.
		%>
		<button type="button" class="btn btn-outline-secondary">
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>">이전</a> <!-- 현재페이지값을넘겨줌/현재페이지에서 1을빼줌-->
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
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>">다음</a>	 <!-- 현재페이지값을넘겨줌/현재페이지에서 1을빼줌-->
			</button>
			<%
				}
			%>
	</div>
</body>
</html>