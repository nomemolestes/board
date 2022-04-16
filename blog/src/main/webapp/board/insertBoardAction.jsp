<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Board"%>
<%@ page import="dao.BoardDao"%>

<%	
	//한글깨짐방지, 인코딩
	request.setCharacterEncoding("utf-8");
	//요청받은 값들은 가져온다, 정수.문자열타입에 맞게 변환
	String categoryName = request.getParameter("categoryName");
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardPw = request.getParameter("boardPw");
	String createDate = request.getParameter("createDate");
	String updateDate= request.getParameter("updateDate");
	
	//요청에서 넘겨진 값들을 하나의 변수로
	Board board = new Board();
	board.setCategoryName(categoryName);
	board.setBoardTitle(boardTitle);
	board.setBoardContent(boardContent);
	//BoardDao 호출함
	BoardDao boardDao = new BoardDao();
	boardDao.insertBoard(board);	
	//입력이 완료되면 리스트페이지로 돌아감.
	response.sendRedirect(request.getContextPath()+"/boardList.jsp");
%>