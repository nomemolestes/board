<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Guestbook" %>
<%@page import="dao.GuestbookDao"%>
<%
	//삭제 할 board번호를 가져와서 정수타입으로 변환
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	//디버깅
	System.out.println(guestbookNo+"<-삭제할번호");
	System.out.println(guestbookPw+"<-비번");
	// 값 하나로묶어서 처리, 객체생성
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookPw(guestbookPw);
	//dao호출
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);
	//쿼리의 실행
	if(row == 1) { //삭제 성공할때
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); //guestbookList로 이동
	} else if (row == 0) { //삭제 실패 할때
		System.out.println("삭제 실패");
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?guestbookNo="+guestbook.getGuestbookNo()); //deleteGuestbookForm으로이동
	} else { //알수없는 에러
		System.out.println("에러");
	}
%>