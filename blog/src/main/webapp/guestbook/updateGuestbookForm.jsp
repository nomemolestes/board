<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//한글깨짐방지 인코딩
	request.setCharacterEncoding("utf-8");
	//요청받은 값을 정수타입으로 변경
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	System.out.println(guestbookNo+"<-수정할 글 번호");//디버깅

	// 액션페이지에서 실행할 쿼리는 update board set category_name=? board_title=? board_content=?
			//update_date=now() where board_no=? and board_no=? */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<div class="jumbotron">
	<h2>수정하기</h2>
	<form method="post" action="updateGuestbookAction.jsp"> <!-- action주소를 계속 잘못입력해놔서, 컴파일못한다는 오류발생...확인잘하기 ㅠ -->
		<table class="table table-hover">
			<tr>
				<td>guestbookNo</td>
				<td>
					<input type="number" name="guestbookNo" value="<%=guestbookNo%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>guestbookContent</td>
		
				<td>
					<textarea rows="7" cols="50" name="guestbookContent"></textarea>
				</td>
			</tr>
			<tr>
				<td>guestbookPw</td>
				<td>
					<input type="password" name="guestbookPw">
				</td>
			</tr>	
		</table>
			<div>
				<button type="submit">수정</button><br>
			</div>
	</form>
</body>
</html>