<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.io.*" %>
<%
	//요청값 받아오기
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));//파일번호
	String pdfPw = request.getParameter("pdfPw");//비번
	//객체생성.dao호출
	PdfDao pdfDao = new PdfDao();
	Pdf pdf = new Pdf();
	//이름확인?하는 메서드 호출
	String photoName = pdfDao.selectPdfName(pdfNo);
	//테이블 먼저 삭제함
	int delRow = pdfDao.deletePdf(pdfNo,pdfPw);
	//폴더이미지 삭제 성공인지 아닌지를 확인함.
	if(delRow == 1) {
		String path = application.getRealPath("pdfa");
		File file = new File(path + "\\" + pdfNo);
		//잘못 업로드된 파일을 삭제함
		file.delete();
		//업로드된 파일을 지우고 폼으로 이동
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");//리스트 페이지로 돌아감.
		} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/pdf/deletePdfForm.jsp");//다시 삭제하는 폼페이지로 돌아감
		}
%>