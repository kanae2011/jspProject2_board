<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("utf-8");
//1.데이터 수집
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
String title = request.getParameter("title");
String content = request.getParameter("content");
String writer = request.getParameter("writer");

BoardVO vo = new BoardVO();
vo.setNo(no);
vo.setTitle(title);
vo.setContent(content);
vo.setWriter(writer);

//2.DB처리 - update.jsp -> service-> dao
String url = request.getServletPath();
Integer result = (Integer)ExeService.execute(Beans.get(url), vo);

//3.view로 자동이동  
response.sendRedirect("view.jsp?no=" + no + "&inc=0");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

  
</head>
<body>

</body>
</html>