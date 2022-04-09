<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Guestbook"%>
<%@ page import = "dao.GuestbookDao" %>

<%	
	//한글깨짐방지, 인코딩
	request.setCharacterEncoding("utf-8");
	//요청받은 값들은 가져온다
	String writer = request.getParameter("writer");
	String guestbookPw= request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");	
	//요청에서 넘겨진 값들을 하나의 변수로
	Guestbook guestbook = new Guestbook();
	guestbook.writer = writer;
	guestbook.guestbookPw = guestbookPw;
	guestbook.guestbookContent = guestbookContent;
	//GuestbookDao를 호출함.
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.insertGuestbook(guestbook);
	//입력이 완료되ㅣ면 리스트페이지로 돌아감.
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
%>