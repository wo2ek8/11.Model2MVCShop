<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        * {
            padding: 0;
            margin: 0;
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
        	padding-top: 80px;
            color: #464646;
            font-size: 14px;
            font-family: 'Roboto', sans-serif;
            font-family: 'Nanum Gothic', sans-serif;
        }

        div.wrap {
            
            margin: 0 auto 30px;
            overflow: hidden;
        }

        div.wrap>div>div {
            float: left;
        }

        div.image {
            width: 50%;
            padding: 0 20px;
        }

        div.image img {
            width: 100%;
        }

        div.productInfo {
            width: 50%;
            padding: 0 30px;
            font-size: 12px;
        }

        div.prodName {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 25px;
        }

        table tr {
            height: 30px;
            vertical-align: top;
        }

        table {
            border-bottom: 1px solid #bcbcbc;
            width: 100%;
            margin-bottom: 30px;
        }

        input {
            width: 30px;
            height: 20px;
            float: left;
        }

        table a {
            display: block;
            width: 20px;
            height: 10px;

        }

        table a img {
            vertical-align: top;
            height: 100%;
        }

        div.button {
            display: inline-block;
        }

        div.total {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        div.total span {
            color: #898989;
            font-weight: normal;
        }

        div.btn_ {
            width: 100%;
            overflow: hidden;
        }

        div.btn_ span {
            width: 32%;
            display: block;
            float: left;
            text-align: center;
            height: 40px;
            line-height: 40px;
            border: 1px solid black;
            font-weight: bold;
        }

        div.btn_ span:first-child {
            background-color: #d99f9d;
            color: white;
        }

        div.btn_ span+span {
            margin-left: 2%;
        }

        div.afterUpdate {
            border-bottom: 1px solid #bcbcbc;
            overflow: hidden;
            padding-bottom: 30px;
            margin-bottom: 30px;
        }

        div.top {
            width: 100%;
            overflow: hidden;
            margin-bottom: 35px;
        }

        p.title {
            font-size: 20px;
            width: 50%;
            float: left;
        }

        p.more {
            float: right;
            font-size: 11px;
            line-height: 30px;
        }

        p.bestReviewer img {
            width: 100%;
        }

        div.review {
            margin: 30px 0;
        }

        div.review div.textArea {
            width: 100%;
            background-color: lavender;
            text-align: center;
            position: relative;
            margin-bottom: 10px;
        }

        div.review div.textArea span {
            background-color: #d99f9d;
            color: white;
            height: 40px;
            line-height: 40px;
            width: 120px;
            border: 1px solid #898989;
            position: absolute;
            bottom: 0;
            right: 0;
        }

        div.review div.textArea textarea {
            padding: 20px;
            width: 100%;
            vertical-align: bottom;
            overflow: hidden;
        }

        table.user {
            border: 1px solid #dbdbdb;
            color: #898989;
            padding: 10px;
            margin-bottom: 10px;
        }

        table.user tr,
        table.user td {

            padding: 10px;
        }

        table.user tr:nth-child(1) td {
            border-bottom: 1px solid #dbdbdb;
        }

        table.user span.regDate {
            float: right;
        }

        span.grade {
            font-weight: bold;
            color: rgb(217, 159, 157);
            margin-left: 6px;
        }

        div.imagelist {

            text-align: center;
        }

        div.imagelist img {

            margin: 10px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script>
        function fncAddReview() {

            var userReview = document.getElementById("userReview").value;

            document.detailForm.action = '/review/addReview?userReview=' + userReview + '&prodNo=' + ${product.prodNo};
            document.detailForm.submit();
        }



        $(function() {
            $('div.btn span:eq(0)').click(function() {
                self.location = '/product/addCart?prodNo=${product.prodNo }&userId=${user.userId}';
                console.log('/product/addCart?prodNo=${product.prodNo }&userId=${user.userId}');
            });

            $('div.btn span:eq(2)').click(function() {
                self.location = "/purchase/addPurchase?prodNo=" + ${product.prodNo} + "&quantity=" + ${product.quantity};
            });

            $('div.review div.textArea span').click(function() {
                fncAddReview();
            });

            $('#btn_count_up').click(function() {

                var quantity = $('#count').val();
                console.log($('#count').val());

                quantity = Number(quantity) + 1;
                $('#count').val(quantity);
                console.log(quantity);


            });

            $('#btn_count_down').click(function() {

                var quantity = $('#count').val();
                console.log($('#count').val());

                quantity = Number(quantity) - 1;

                if (quantity < 1) {
                    quantity = 1;
                }

                $('#count').val(quantity);
                console.log(quantity);


            });


        });
    </script>

</head>

<body>

    <!-- ToolBar Start /////////////////////////////////////-->
    <jsp:include page="/layout/toolbar.jsp" />
    <!-- ToolBar End /////////////////////////////////////-->
<div class="container">
    <!--  화면구성 div Start /////////////////////////////////////-->
    <form name="detailForm" method="post">

        <div class="wrap">
            <div class="afterUpdate">
                <div class="image">


                    <img src="/images/uploadFiles/${product.fileNameList[0]}" />

                </div>
                <div class="productInfo">
                    <div class="prodName">
                        ${product.prodName }
                    </div>
                    <table>
                        <colgroup>
                            <col width="25%">
                            <col width="75%">
                        </colgroup>
                        <tr>
                            <td>
                                Price
                            </td>
                            <td>
                                ${product.price }원
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Code
                            </td>
                            <td>
                                ${product.prodNo }
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Point
                            </td>
                            <td>
                                100원 (1%)
                            </td>
                        </tr>
                        <tr class="quantity">
                            <td>
                                Quantity
                            </td>
                            <td>
                                <input type="text" value="1" id="count">
                                <div class="button">
                                    <a href="#" id="btn_count_up"><img src="/images/btn_count_up.gif" alt=""></a>
                                    <a href="#" id="btn_count_down"><img src="/images/btn_count_down.gif" alt=""></a>
                                </div>
                            </td>
                        </tr>
                        <tr></tr>
                    </table>
                    <div class="total">
                        TOTAL<span>(QUANTITY) : </span>${product.price }원 <span>(1개)</span>
                    </div>
                    <div class="btn_">
                        <span><a href="/product/addCart?prodNo=${product.prodNo }&userId=${user.userId}">장바구니</a></span>
                        <span><a href="#">관심상품</a></span>
                        <span><a href="/purchase/addPurchase?prodNo=${product.prodNo }&quantity=${product.quantity}">구매하기</a></span>
                    </div>
                </div>
            </div>
            <div class="imagelist">
            
			 	<c:forEach var="i" items="${product.fileNameList}" begin="1">
			 		<c:if test="${!empty product.fileNameList[1]}">
                    	<img src="/images/uploadFiles/${i}" />
                    </c:if>
                </c:forEach>
			
			
                
            </div>


            <div class="review">
                <div class="top">
                    <p class="title">REVIEW</p>
                    <p class="more">more ></p>

                </div>
                <p class="bestReviewer"><img src="/images/review_de.jpg" alt=""></p>

                <div class="textArea">
                    <textarea name="userReview" id="userReview" rows="10" placeholder="글을 입력해 주세요."></textarea>

                    <span>
                        <!-- <a href="javascript:fncAddReview()"> -->글쓰기
                        <!-- </a> --></span>
                </div>

                <c:forEach var="review" items="${list }">
                    <table class="user">
                        <tr>
                            <td>${review.reviewer.userId } <span class="grade">${review.reviewer.grade }</span> <span class="regDate">${review.regDate }</span></td>
                        </tr>
                        <tr>
                            <td>${review.userReview }</td>
                        </tr>
                        <tr>
                            <td>댓글 0 ｜ 등록순</td>
                        </tr>


                    </table>
                </c:forEach>


            </div>
        </div>


    </form>
    </div>
    <!--  화면구성 div Start /////////////////////////////////////-->

</body></html>
