<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:if test="${!empty success }">
	<script>alert("${success}")</script>
</c:if>
<!--jQuery  -->
</head>
<body>
<h1>미니쇼핑몰</h1>

<jsp:include page="common/top.jsp" flush="true"></jsp:include><br>
<jsp:include page="common/menu.jsp" flush="true"></jsp:include><br>
<hr>
<jsp:include page="goods/goodsList.jsp" flush="true"></jsp:include>
</body>
</html>