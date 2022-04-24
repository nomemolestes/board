<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*"%>
<%@ page import="java.io.*" %>
<%
	/* 
		form tag의 enctype="multipart/form-data"로 넘겨져서
		request.getParameter() API는 사용불가.
		->request를 단순하게 사용하게 해주는 cos.jar같은 외부라이브러리사용해야함
		
	*/
	//String writer = request.getParameter("writer");//사용불가
	request.setCharacterEncoding("utf-8");//한글깨짐방지 인코딩
	//DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();//객체생성
	//새로운 MultipartRequest가 나옴(request, 저장할 파일이름, 크기(계산은안함), 인코딩유형, 들어오는 파일의 이름중복방지용 코드)
	//요청값을 받기위한 준비(multi~)
	String path = application.getRealPath("pdfa");//app~은 톰캣을 가리키는 변수
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	//요청값 받기가능
	String pdfPw = multiReq.getParameter("pdfPw");
	String writer = multiReq.getParameter("writer");
	//파일저장
	//원래 파일 업로드때의 원본의 이름
	String pdfOriginalName = multiReq.getOriginalFileName("pdf");
	//폼 페이지의 input type="file" name="pdf"를 받음.
	//new DefaultFileRenamePolicy()객체를 통해 변경된 이름
	String pdfName = multiReq.getFilesystemName("pdf");
	//이미지 파일인가 아닌가 알수있음
	String pdfType = multiReq.getContentType("pdf");
	//디버깅
	System.out.println(pdfPw + "<-pdfPw");
	System.out.println(writer + "<-writer");
	System.out.println(pdfOriginalName + "<-pdfOriginalName");
	System.out.println(pdfName + "<-pdfName");
	System.out.println(pdfType + "<-pdfType");
	//파일 업로드의 경우 100이하의 file/pdf
	if(pdfType.equals("application/pdf")) { //등록가능한 파일확장자명
		System.out.println("db저장");
		PdfDao pdfDao = new PdfDao();
		Pdf pdf = new Pdf();
		pdf.setPdfName(pdfName);
		pdf.setPdfOriginalName(pdfOriginalName);
		pdf.setPdfType(pdfType);
		pdf.setPdfPw(pdfPw);
		pdf.setWriter(writer);
	//메서드 호출
	pdfDao.insertPdf(pdf);
	response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");
	} else {
		//업로드 취소
		System.out.println("pdf파일만 올리세요.");
		//잘못된 이미지를 불러옴 java.io.File 임포트.
		File file = new File(path+"\\"+pdfName);
		//잘못 업로드된 파일을 삭제
		file.delete();
		//업로드된 파일을 지우고 폼으로 이동
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp");
	}
%>