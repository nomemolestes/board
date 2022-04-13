<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.File"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
/*
	form tag의 enctype="multipart/form-data"로 넘겨져서
	reuqest.getParameter() API를 사용할수없음
	->해결책:request를 단순하게 사용하게 해주는 cos.jar같은 외부라이브러리(API)를 사용해야함
*/
//String writer = request.getParameter("writer");
	request.setCharacterEncoding("utf-8");//인코딩
	DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy();//rp는 new DefaultFileRenamePolicy의 객체임.
	//새로운 MultipartRequest가 나옴.(request, 저장할파일이름, 크기(계산하면안됨), 인코딩, 들어온 파일이름을 중복되지않게 계속 만들어줌.)
	//저장할 파일이름 말고 주소를 씀-> 근데 \쓸수없으므로 \\사용함.
	String path = application.getRealPath("koala");//application은 톰캣을 가리키는 변수
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", rp);
	//100메가바이트 1024*1024*100바이트
	//24*60*60=하루를 계산한 sec

	//이제 요청값을 받을수 있게됨.
	String photoPw = multiReq.getParameter("photoPw");
	String writer= multiReq.getParameter("writer");
	//이미지를 저장해야함
	//원래 파일 업로드할때 원본의 이름
	String photoOriginalName = multiReq.getOriginalFileName("photo");
	//폼 페이지의 input type="file" name="photo"를 받음.
	//new DefaultFileRenamePolicy()객체를 통해 변경된 이름		
	String photoName = multiReq.getFilesystemName("photo");
	//이미지 파일인지 아닌지 알수있음.
	String photoType = multiReq.getContentType("photo");
	//디버깅
	System.out.println(photoPw+"<-photoPw");
	System.out.println(writer+"<-writer");
	System.out.println(photoOriginalName+"<-photoOriginalName");
	System.out.println(photoName+"<-photoName");
	System.out.println(photoType+"<-photoType");
	//파일 업로드의 경우 100메가바이트 이하의 image/gif, image/png, image/jpeg 3가지 이미지만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")) {
		//db에 저장
		System.out.println("db고고");
		PhotoDao photoDao = new PhotoDao();
		Photo photo = new Photo();
		photo.photoName = photoName;
		photo.photoOriginalName = photoOriginalName;
		photo.photoType = photoType;
		photo.photoPw = photoPw;
		photo.writer = writer;
		//메서드호출
		photoDao.insertPhoto(photo);
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
	} else {
		//업로드 취소
		System.out.println("이미지파일만 올리세요");
		//잘못된 이미지를 불러옴 java.io.File 임포트.
		File file = new File(path+"\\"+photoName);
		//잘못 업로드된 파일을 삭제
		file.delete();
		//업로드된 파일을 지우고 폼으로 이동
		response.sendRedirect(request.getContextPath()+"/photo/insertPhotoForm.jsp");
	}
%>