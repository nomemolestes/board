<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>InsertPhotoForm</title>
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
	<h6>이미지 등록</h6>
	<!-- 
	* 폼 태그안에 값을 넘기는 기본값은 문자열, 파일 못넘김
	 ->기본값(application/x-www-form-urlencoded) 변경필요->multipart/form-date로 변경하면 기본값이 문자열에서
	 바이너리(이진수)로 변경됨->같은 폼 안의 모든값이 이진수로 넘어감->request.getParameter사용불가
	 ->복잡한 코드를통해서만 이진수 내용을 넘겨받을수있음->외부라이브러리(cos.jar)를 사용해서 복잡한 코드 간단하게 구현가능함.
	 -->
	<form action="./insertPhotoAction.jsp" method="post" enctype="multipart/form-data">
		<table class="table table-dark"> <!-- 부트스트랩으로 변경. -->
			<tr>
				<td>이미지파일</td>
				<td>
					<input type="file" name="photo">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="photoPw">
				</td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td>
					<input type="text" name="writer">
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-outline-danger">사진 등록</button>
	</form>
</body>
</html>