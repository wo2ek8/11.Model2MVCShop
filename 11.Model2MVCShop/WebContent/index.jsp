<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<c:if test="${user.role == 'admin'}">
	<jsp:forward page="admin.jsp" />
</c:if>


<c:if test="${user.role != 'admin'}">
	<jsp:forward page="/product/listProduct?menu=search"></jsp:forward>
</c:if>

