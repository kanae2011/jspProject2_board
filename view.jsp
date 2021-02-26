<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
//자바 코드 부분 .JSP-Service-DAO-> /board/view.jsp
String url = request.getServletPath();

//넘어오는 데이터 받기
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
String strInc = request.getParameter("inc");
long inc = Long.parseLong(strInc);

BoardVO vo = (BoardVO)ExeService.execute(Beans.get(url), new Long[]{no,inc});

//서버 객체 requset 에 담음
request.setAttribute("vo", vo);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글보기</title>
	<!-- BootStrap CDN 방식 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  


<script type="text/javascript">
//객체 선택에 문제가 생김. 아래 문서가 다 로딩이 되면 실행되는 스크립트 작성 
//jQuery-> $(function(){처리문 만들기}); = jQuery(function(){처리문 만들기})
$(function () { //jQuery에서 익명함수를 전달해서 저장해놨다가 Document 로딩이 다 되면 호출,처리 

	//삭제 버튼 클릭시 확인여부 
	$("#deleteBtn").click(function () {
		if(!confirm("삭제하시겠습니까?")) return false;
	});
	
});
</script>
</head>
<body>
<div class= "container">
<h1>게시판 글보기</h1>
<table class="table">
	
	<tbody>
		<tr>
			<th>글번호</th>
			<td class = "no">${vo.no }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${vo.title }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td><pre style ="backfround: #fff; border:none; padding: 0px;"></pre>${vo.content }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${vo.writer }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${vo.writeDate }</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${vo.hit }</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2">
			<a href = "updateForm.jsp?no=${vo.no }" class="btn btn-default">글수정</a>
			<a href = "delete.jsp?no=${vo.no }" class="btn btn-default" id="deleteBtn">글삭제</a>
			<a href = "list.jsp" class="btn btn-default">목록</a>
			</td>
		</tr>
	</tfoot>
</table>
</div>
</body>
</html>