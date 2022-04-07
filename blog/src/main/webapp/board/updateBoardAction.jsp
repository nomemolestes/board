<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*" %>
<%	
	//한글깨짐방지, 인코딩
	request.setCharacterEncoding("utf-8");
	//양식 페이지의 요청받은 값을 정수타입으로 변환함, 순서정렬.
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String boardPw = request.getParameter("boardPw");
	
	//묶어서 한번에 처리함.
	Board board = new Board();
	board.boardNo = boardNo;
	board.categoryName = categoryName;
	board.boardTitle = boardTitle;
	board.boardContent = boardContent;
	board.boardPw = boardPw;
	//guestbookdao호출
	BoardDao BoardDao = new BoardDao();
	BoardDao.updateBoard(board);
	
%>