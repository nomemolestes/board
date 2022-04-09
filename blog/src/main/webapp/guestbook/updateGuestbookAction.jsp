<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.GuestbookDao" %>
<%	
	//한글깨짐방지, 인코딩
	request.setCharacterEncoding("utf-8");
	//양식 페이지의 요청받은 값을 정수타입으로 변환함, 순서정렬.
	String guestbookContent = request.getParameter("guestbookContent");
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw= request.getParameter("guestbookPw");
	//디버깅
	System.out.println(guestbookContent+"<-수정할내용");
	System.out.println(guestbookNo+"<-수정할번호");
	System.out.println(guestbookPw+"<-비번");
	//묶어서 한번에 처리함,객체생성
	Guestbook guestbook = new Guestbook();
	guestbook.guestbookContent = guestbookContent;
	guestbook.guestbookNo = guestbookNo;
	guestbook.guestbookPw = guestbookPw;
	//guestbookdao호출
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.updateGuestbook(guestbook);
	if(row == 0) {//행 변화가 없다면
		System.out.println("수정실패");
	//입력양식페이지로 돌아가시오.
	response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo="+guestbook.guestbookNo);
	} else if(row == 1) {//행 변화가 있다면
		System.out.println("수정성공");
	//리스트로 돌아가시오.
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	} else { //그외 나머지 경우는 오류임.
		System.out.println("오류임");
	}
%>