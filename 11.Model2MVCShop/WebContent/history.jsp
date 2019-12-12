<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

<title>열어본 상품 보기</title>

</head>
<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>



		<c:forEach var="product" items="${list }">
		<form>
			<a href="/product/getProduct?prodNo=${product.prodNo }&menu=search" target="opener">${product.prodNo }</a>
			<br>
		</form>
		</c:forEach>

</body>
</html>