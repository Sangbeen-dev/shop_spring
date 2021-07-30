<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String mesg = (String)session.getAttribute("mesg");
	if(mesg != null){
%>
	<script type = "text/javascript">
		alert('<%=mesg %>');
	</script>
<%
	//
	session.removeAttribute("mesg");
	}
%>	
<h1>mypage 화면입니다.</h1>

<jsp:include page = "common/top.jsp" flush = "true"></jsp:include><br>
<jsp:include page = "common/menu.jsp" flush ="true"></jsp:include><br>
<hr>
<jsp:include page = "member/mypage.jsp" flush ="true"></jsp:include><br> 
</body>
</html>