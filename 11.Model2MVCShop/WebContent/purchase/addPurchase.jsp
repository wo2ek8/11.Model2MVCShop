


<%-- <%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="com.model2.mvc.service.purchase.PurchaseService"%>
<%@page import="com.model2.mvc.service.purchase.impl.PurchaseServiceImpl"%>
<%@page import="com.model2.mvc.service.domain.Purchase"%> --%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%-- <%
        	Purchase purchase = (Purchase)request.getAttribute("purchase");
        %> --%>
        
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>

<body>

<form name="updatePurchase" action="/purchase/updatePurchase" method="post">

������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
		<td>��ǰ��ȣ</td>
		<%-- <td><%=purchase.getPurchaseProd().getProdNo() %></td> --%>
		<td>${purchase.purchaseProd.prodNo }</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<%-- <td><%=purchase.getBuyer().getUserId() %></td> --%>
		<td>${purchase.buyer.userId }</td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		<%-- <%
		if(purchase.getPaymentOption().equals("1")) {%>
			ī�� ����
		<%} else if(purchase.getPaymentOption().equals("2")) {%>
			�޴��� ����
		<%} else {%>
			������ �Ա�
		<%}
		%> --%>
		<c:if test="${purchase.paymentOption.equals('0') }">
		ī�� ����
		</c:if>
		<c:if test="${purchase.paymentOption.equals('1') }">
		�޴��� ����
		</c:if>
		<c:if test="${purchase.paymentOption.equals('2') }">
		������ �Ա�
		</c:if>
			
		
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<%-- <td><%=purchase.getReceiverName() %></td> --%>
		<td>${purchase.receiverName }</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<%-- <td><%=purchase.getReceiverPhone() %></td> --%>
		<td>${purchase.receiverPhone }</td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<%-- <td><%=purchase.getDivyAddr() %></td> --%>
		<td>${purchase.divyAddr }</td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<%-- <td><%=purchase.getDivyRequest() %></td> --%>
		<td>${purchase.divyRequest }</td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<%-- <td><%=purchase.getDivyDate() %></td> --%>
		<td>${purchase.divyDate }</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>