<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.io.*" %>
<%
	//값을 받아옴.
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));
	String photoPw = request.getParameter("photoPw");
	PhotoDao photoDao = new PhotoDao();//삭제 전에  dao를 호출
	String photoName = photoDao.selectPhotoName(photoNo);
	//테이블 삭제먼저
	int delRow = photoDao.deletePhoto(photoNo,photoPw);
	//폴더이미지삭제 성공했는지 아닌지 확인
	if(delRow == 1) {
		String path = application.getRealPath("koala");
		File file = new File(path+"\\"+photoName);
		//잘못 업로드된 파일을 삭제
		file.delete();
		//업로드된 파일을 지우고 폼으로 이동
		System.out.println("삭제성공");
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");//처음 리스트로 이동
	} else {
		System.out.println("삭제실패");
		response.sendRedirect(request.getContextPath()+"/photo/photoOne.jsp?photoNo="+photoNo);//상세보기로 이동
	}
	
%>
