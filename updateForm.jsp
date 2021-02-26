<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
//자바 코드 부분 //

//1.넘어오는 데이터 받기 - 글 번호 
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
//2.글 번호에 맞는 데이터 가져오기 -> BoardViewService -> /board/view.jsp
String url = "/board/view.jsp"; //현재 url(update)과 다르므로 강제로 셋팅  
//조회수는 증가 하지 않도록 inc=0 강제 셋팅
BoardVO vo = (BoardVO)ExeService.execute(Beans.get(url), new Long []{no,0L});
//3.서버 객체에 넣기 
request.setAttribute("vo", vo);
//넘어오는 데이터 받기


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글수정</title>
	<!-- BootStrap CDN 방식 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</head>
<body>
<div class= "container">
<h1>게시판 글수정</h1>
<form action="update.jsp" id="writeForm" method="post">
	<div class="form-group">
		<label>번호</label>
		<input name="no" class ="form-control" id="no" readonly="readonly" value="${vo.no }">
	</div>
	<div class="form-group">
		<label>제목</label>
		<input name="title" class ="form-control" id="title" required="required" value="${vo.title }">
	</div>
	<div class="form-group">
		<label>내용</label>
		<textarea name="content" class ="form-control" id="content" >${vo.content }</textarea>
	</div>
	<div class="form-group">
		<label>작성자</label>
		<input name="writer" id="writer" class ="form-control"  value="${vo.writer }">
	</div>


<button class="btn btn-default">수정</button>
<button class="btn btn-default" type="reset">새로 입력</button>
<button class="btn btn-default" type="button" id="cancelBtn">취소</button>
</form>
</div>
</body>
</html>