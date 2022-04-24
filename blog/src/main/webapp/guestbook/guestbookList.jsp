<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
	//페이지 5개씩 묶어서 처리, 이전다음페이지로 넘길때 값도 함꼐 바껴야함. dao사용안함.
	int currentPage = 1;//현재페이지의 기본값이 1페이지임.
	if(request.getParameter("currentPage") != null) {//이전, 다음링크를 통해서 들어온거라면
		currentPage = Integer.parseInt(request.getParameter("currentPage"));//현재페이지는 요청받은 current page값인 문자열 숫자를 정수타입으로 바꿈.
	}
	System.out.println(currentPage+ "<-currentPage");//디버깅
	int rowPerPage = 5;//5개씩 글을 묶어서 하나의 페이지로 보여줌.
	int beginRow = (currentPage-1)*rowPerPage;//알고리즘생성
	GuestbookDao guestbookDao = new GuestbookDao();//객체생성
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();//dao호출함
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	//형변환
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	  <p>방명록을 써주세요</p>
	  
	</div>
	<!-- 게시글 리스트 -->
  	</div>
  	<div class="row">
    <div class="col-sm-6" style="background-color:lavender;">
      	<h2>방명록 목록</h2>
    
    <% 
	for(Guestbook g : list) {
%>
		<table class="table table-striped">
			<tr>
				<td><%=g.getWriter()%></td>
				<td><%=g.getCreateDate()%></td>
			</tr>
			<tr>
				<td><%=g.getGuestbookContent()%></td>
			</tr>
		</table>
			<div>
			<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">수정</a>
			<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>">삭제</a>
		</div>
	
<%	
	}
	
	if(currentPage > 1) {
%>
		<button class="btn btn-warning">
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		</button>
<%		
	}
	
	if(currentPage < lastPage) {
%>
		<button class="btn btn-warning">
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		</button>
<%
	}
%>
    </div>
    
    <div class="col-sm-6" style="background-color:lavenderblush;">
    	<!-- 방명록 입력 -->
	
	<h3>입력하기</h3>
	<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
		<table>
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw"></td></tr>
			<tr>
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-warning">입력</button>
	</form>
    </div>
  </div>


	</div>
	</div>
</body>
</html>
