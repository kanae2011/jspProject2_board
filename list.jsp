<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
//페이지 처리를 위한 프로그램
//페이지 처리를 위한 객체 사용
PageObject pageObject = new PageObject();
//페이지에 대한 정보를 받음 
//page는 jsp에서 기본객체로 사용하고 있음->page의 정보가 담겨져 있음.때문에 다른 이름으로 
String strCurPage = request.getParameter("page");
//넘어오는 페이지가 있는 경우는 현재 페이지로 셋팅 , 그렇지 않으면 1이 셋팅 
if(strCurPage != null) pageObject.setPage(Integer.parseInt(strCurPage));
//한 페이지당 표시할 데이터의 수를 받음 
String strPerPageNum = request.getParameter("perPageNum");
//한 페이지당 표시할 데이터 수가 안넘어오면 10으로 셋팅. 넘어오면 넘어오는 데이터를 사용 
if(strPerPageNum != null) pageObject.setPerPageNum(Integer.parseInt(strPerPageNum));
//넘어온 데이터 확인
System.out.println("strCurPage = " + strCurPage + ", perPageNum = " + strPerPageNum);
//PageObject  확인
System.out.println("pageObject = " + pageObject);


String url = request.getServletPath();
@SuppressWarnings("unchecked")
List<BoardVO> list = (List<BoardVO>)ExeService.execute(Beans.get(url), pageObject);

//서버 객체 requset 에 담음
request.setAttribute("list", list);
request.setAttribute("pageObject", pageObject); //페이지를 보여주기 위해 서버 객체에 담음 


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
	<!-- BootStrap CDN 방식 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<style type="text/css">
.dataRow:hover{
	cursor: pointer;
	background: #eee;
}
</style>
<script type="text/javascript">
//객체 선택에 문제가 생김. 아래 문서가 다 로딩이 되면 실행되는 스크립트 작성 
//jQuery-> $(function(){처리문 만들기}); = jQuery(function(){처리문 만들기})
$(function () { //jQuery에서 익명함수를 전달해서 저장해놨다가 Document 로딩이 다 되면 호출,처리 
	//데이터 한 줄 선택하기와 이벤트처리
	$(".dataRow").click(function(){
		//alert($(this));
		//$(this) : 이벤트가 일어난 자신을 의미 
		//.find(selector) : .앞에 객체 안에서 찾아라 
		//.text() : 객체(태그) 사이에 문자를 가져옴
		//.text(data) : 객체(태그)사이에 문자를 셋팅 
		var no = $(this).find(".no").text();
		//조회수 1증가를 위해 inc=1 넘김 
		location = "view.jsp?no=" + no + "&inc=1";
	});
	
});
</script>
</head>
<body>
<div class= "container">
<h1>게시판 목록</h1>
<table class="table">
	<thead>
		<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<!-- 데이터가 있는 만큼 반복이 되는 시작 부분 -->
		<c:forEach items="${list }" var="vo">
		<tr class = "dataRow">
		<td class = "no">${vo.no }</td>
		<td>${vo.title }</td>
		<td>${vo.writer }</td>
		<td>${vo.writeDate }</td>
		<td>${vo.hit }</td>
		</tr>
		</c:forEach>
		<!-- 데이터가 있는 만큼 반복이 되는  끝 부분 -->
	</tbody>
	<tfoot>
		<tr>
			
			<td colspan="5">
			<pageObject:pageNav listURI="list.jsp" pageObject="${pageObject }"/>
			</td>
		</tr>
		<tr>
			<td colspan="5">
			<a href = "writeForm.jsp" class="btn btn-default">글쓰기</a>
			</td>
		</tr>
	</tfoot>
</table>
</div>
</body>
</html>
