package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import vo.Pdf;

public class PdfDao {
	public PdfDao() {}
	//파일이름반환하는메서드
	public String selectPdfName(int pdfNo) throws Exception {
		String pdfName="";
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		//쿼리전송	
		String sql = "select pdf_name pdfName from pdf where pdf_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		System.out.println(stmt+ "<-stmt");//디버깅
		rs = stmt.executeQuery();
		//쿼리실행확인
		if(rs.next()) {
			pdfName = rs.getString("pdfName");
		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
		return pdfName;
	}
	//삭제메서드
	public int deletePdf(int pdfNo, String pdfPw) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		//연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리 전송
		String sql = "delete from pdf where pdf_no=? and pdf_pw=?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		stmt.setString(2, pdfPw);
		//쿼리실행
		int row = stmt.executeUpdate();
		//반납
		stmt.close();
		conn.close();
		return row;
	}
	//이미지 입력
	public void insertPdf(Pdf pdf) throws Exception {
		//드라이버 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리 전송
		String sql = "insert into pdf(pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date) values (?,?,?,?,?,now(), now())";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pdf.getPdfName()); //몇번째 물음표 무엇인지의 설명
		stmt.setString(2, pdf.getPdfOriginalName());
		stmt.setString(3, pdf.getPdfType());
		stmt.setString(4, pdf.getPdfPw());
		stmt.setString(5, pdf.getWriter());
		//쿼리실행
		rs = stmt.executeQuery();
		while(rs.next()) {
			Pdf p = new Pdf();
			p.setPdfName(rs.getString("pdf_name"));
			p.setPdfOriginalName(rs.getString("pdf_original_name"));
			p.setPdfType(rs.getString("pdf_type"));
			p.setPdfPw(rs.getString("pdf_pw"));
			p.setWriter(rs.getString("writer"));

		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
	}
	//pdf목록
	//n행씩 반환하는 메서드
	public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf>();
		Class.forName("org.mariadb.jdbc.Driver");
		//드라이버 로딩
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;//데이터를 테이블모양으로 저장.
		//드라이버 연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		//쿼리전송	
		String sql = "select pdf_no pdfNo, pdf_name pdfName, pdf_original_name pdfOriginalName, pdf_type pdfType, pdf_pw pdfPw, writer, create_date createDate, update_date updateDate from pdf order by create_date desc limit ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);//rowPerPage만큼 가져온다
		rs = stmt.executeQuery();
		//쿼리실행
		while(rs.next()) {
			Pdf p = new Pdf();
			p.setPdfNo(rs.getInt("pdfNo"));
			p.setPdfName(rs.getString("pdfName"));
			p.setPdfOriginalName(rs.getString("pdfOriginalName"));
			p.setPdfType(rs.getString("pdfType"));
			p.setPdfPw(rs.getString("pdfPw"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate"));
			p.setUpdateDate(rs.getString("updateDate"));
			list.add(p);//목록에 추가함
		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	//페이징 가능하도록 전체 글의 수를 구하는 코드
	public int selectPdfTotalRow() throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버 연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		//쿼리전송
		String sql = "select count(*) cnt from pdf";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		//쿼리실행
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	//파일 1개 상세보기
	public Pdf selectPdfOne(int pdfNo) throws Exception {
		Pdf pdf = null;
		//드라이버로딩
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		//드라이버연결
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		//쿼리전송	
		String sql = "SELECT pdf_no pdfNo, pdf_name pdfName, writer, create_date createDate, update_date updateDate FROM pdf WHERE pdf_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		System.out.println(stmt+ "<-상세보기");
		//쿼리실행
		rs = stmt.executeQuery();
		while(rs.next()) {
			Pdf p = new Pdf();
			p.setPdfNo(rs.getInt("pdfNo"));
			p.setPdfName(rs.getString("pdfName"));
			p.setWriter(rs.getString("writer"));
			p.setCreateDate(rs.getString("createDate"));
			p.setUpdateDate(rs.getString("updateDate"));
		}
		//반납
		rs.close();
		stmt.close();
		conn.close();
		return pdf;
	}
	}
