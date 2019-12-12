<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="com.model2.mvc.service.product.ProductService"%>
<%@page import="com.model2.mvc.service.product.impl.ProductServiceImpl"%>
<%@page import="com.model2.mvc.service.domain.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

li {
	list-style: none;
}

a {
	text-decoration: none;
	color: inherit;
}

body {
	font-size: 12px;
	color: #898989;
	font-family: 'Roboto', sans-serif;
	font-family: 'Nanum Gothic', sans-serif;
}

img {
	width: 100px;
	margin: 10px;
}

table {
	margin: 0 auto;
	text-align: center;
	border-collapse: collapse;
}

tr {
	border-top: 1px solid;
	border-bottom: 1px solid;
}

div.title {
	padding: 30px 0;
	font-weight: bold;
	letter-spacing: 2px;
	text-align: center;
}

tr:nth-child(1) {
	line-height: 3;
}

td.name {
	text-align: left;
}

div.button {
	display: inline-block;
	height: 30px;
	background: #fff;
}

div.button a {
	display: block;
	border: 1px solid;
	height: 50%;
	font-size: 10px;
}

td.select span {
	padding: 5px 10px;
	display: inline-block;
	margin-bottom: 3px;
	color: #fff;
	background-color: #c9c9c9;
}

center {
	margin-top: 30px;
}
</style>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('td.select span:contains("�ֹ��ϱ�")').click(function() {
				var prodNo = $(this).children("#add_purchase_prod").val();
				var quantity = $(this).children('#add_purchase_quantity').val();
				self.location ="/purchase/addPurchase?prodNo=" + prodNo + "&quantity=" + quantity;
				
				console.log("/purchase/addPurchase?prodNo=" + prodNo + "&quantity=" + quantity);
			});
			
			$('td.select span:contains("�����ϱ�")').click(function() {
				var prodNo = $(this).children("#remove_cart_prod").val();
				self.location ="/product/removeCart?prodNo=" + prodNo;
				
				console.log("/product/removeCart?prodNo=" + prodNo);
			});
		});
	</script>
</head>
<body>
	<div class="title">SHOPPING CART</div>
	<table>
		<colgroup>
			<col width="50px">
			<col width="150px">
			<col width="350px">
			<col width="100px">
			<col width="100px">
			<col width="100px">
			<col width="100px">
			<col width="100px">
		</colgroup>
		<tr>
			<td><input type="checkbox" name="check"></td>
			<td>Product</td>
			<td>Name</td>
			<td>Price</td>
			<td>Quantity</td>
			<td>Mileage</td>
			<td>Total</td>
			<td>Select</td>
		</tr>
		<%-- <%
			User user = (User) session.getAttribute("user");
			String userId = user.getUserId();
			String cart = null;
			Cookie[] cookies = request.getCookies();
			if (cookies != null && cookies.length > 0) {
				for (int i = 0; i < cookies.length; i++) {
					Cookie cookie = cookies[i];
					if (cookie.getName().equals(userId)) {
						cart = cookie.getValue();
					}
				}
				if (cart != null) {
					String[] c = cart.split(",");
					for (int i = 0; i < c.length; i++) {
						if (!c[i].equals("null") && !c[i].equals("")) {
		%>

		<%
			ProductService productService = new ProductServiceImpl();
			Product product = productService.getProduct(Integer.parseInt(c[i]));
		%> --%>
		
		<c:forEach var="product" items="${list }">
		<tr>
			<td><input type="checkbox" name="check"></td>
			<td>
				<img src="/images/uploadFiles/${product.fileNameList[0]}"/>
				</td>
			<td class="name"><strong>${product.prodName }</strong></td>
			<td><strong>${product.price }��</strong></td>
			<td>-</td>
			<td>-</td>
			<td><strong>${product.price }��</strong></td>
			<td class="select">
				<span><%-- <a href="/purchase/addPurchase?prodNo=${product.prodNo }&quantity=${product.quantity}"> --%>
				<input type="hidden" id="add_purchase_prod" value="${product.prodNo }">
				<input type="hidden" id="add_purchase_quantity" value="${product.quantity }">
				�ֹ��ϱ�<!-- </a> --></span>
				<br>
				<span><%-- <a href="/product/removeCart?prodNo=${product.prodNo }"> --%>
				<input type="hidden" id="remove_cart_prod" value="${product.prodNo }">
				�����ϱ�<!-- </a> --></span></td>
		</tr>
		</c:forEach>
		<%-- <%
			} else {%>
				</table>
				<center>��ٱ��ϰ� ��� �ֽ��ϴ�.</center>
			<%}
					}%>
					</table>
		
	
	<%
		} else {%> </table><center>��ٱ��ϰ� ��� �ֽ��ϴ�.</center> <%}
		} %> --%>
	
</table>
</body>
</html>