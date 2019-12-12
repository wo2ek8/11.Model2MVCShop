<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



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
    <script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <!-- Bootstrap Dropdown Hover CSS -->
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic|Roboto&display=swap" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>


    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


    <!--  ///////////////////////// CSS ////////////////////////// -->
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
            padding-top: 50px;
            font-size: 14px;
            color: #898989;
            font-family: 'Roboto', sans-serif;
            font-family: 'Nanum Gothic', sans-serif;
        }

        .grid:after {
            content: '';
            display: block;
            clear: both;
        }

        .grid-sizer,
        .grid-item {
            width: 25%;
        }

        .grid-item {
            width: calc(25% - 20px);
            float: left;
            background: #fff;
            margin: 10px;
            box-shadow: rgba(0, 0, 0, 0.2) 0px 5px 13px;
            overflow: hidden;
            border-radius: 6px;
        }

        .grid-item img {
            width: 100%;
        }

        .grid-item div {
            padding: 20px;
        }

        ul.sorting {
            text-align: right;
            margin-top: 20px;
            margin-right: 10px;
        }

        ul.sorting li {
            display: inline-block;
        }

        ul.sorting li span {
            display: inline-block;
            width: 10px;
            height: 10px;
            border: 1px solid;
        }

        ul.sorting li.on span {
            background-color: rgb(217, 159, 157);
        }

        a:focus,
        a:hover {
            color: inherit;
            text-decoration: none;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        $(function() {

            $('ul.sorting li:contains("신상품")').click(function() {
                fncGetList('1', '0');

            })

            $('ul.sorting li:contains("낮은가격")').click(function() {
                fncGetList('1', '1');

            })

            $('ul.sorting li:contains("높은가격")').click(function() {
                fncGetList('1', '2');

            })

            $('ul.sorting li:contains("이름")').click(function() {
                fncGetList('1', '3');

            })

            $('.grid').masonry({
                columnWidth: '.grid-sizer',
                itemSelector: '.grid-item',
                percentPosition: true,
                transitionDuration: 0
            });

            var count = 2;
            var didScroll = false;
            var sorting = $('#sorting').val();
            var searchCondition = $('#searchCondition').val();
            var searchKeyword = $('#searchKeyword').val();


            $(window).on('scroll', function() {
                didScroll = true;
            });

            setInterval(function() {
                if (didScroll) {
                    didScroll = false;
                    if ($(window).scrollTop() == $(document).height() - $(window).height()) {

                        if (count <= ${resultPage.maxPage}) {

                            console.log('페이지 끝');


                            console.log(count);
                            infiniteScroll();

                            count++;
                        }
                    }
                }
            }, 1000);

            function infiniteScroll() {
                $.ajax({
                    url: '/product/json/listProduct',
                    method: 'POST',
                    data: JSON.stringify({
                        searchCondition: searchCondition,
                        searchKeyword: searchKeyword,
                        sorting: sorting,
                        currentPage: count
                    }),
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function(data) {


                        for (var i = 0; i < data.list.length; i++) {





                            var displayValue4 = "<div class='grid-item'>" +
                                "<a href='#'><span class='hiddenNo' style='display: none;'>" + data.list[i].prodNo + "</span>" +
                                "<img src='/images/uploadFiles/" + data.list[i].fileNameList[0] + "' alt=''>" +
                                "<div>" +
                                "<p>" + data.list[i].prodName + "</p>" +
                                "<p>" + data.list[i].prodDetail + "</p>" +
                                "<p>" + data.list[i].price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "</p>" +
                                "</div>" +
                                "</a>" +
                                "</div>";


                            $('.grid').append(displayValue4);
                            setInterval(function() {

                                $('.grid').masonry('reloadItems');
                                $('.grid').masonry('layout');
                            }, 1);









                        }

                        $('.grid-item a').click(function() {
                            var prodNo = $(this).children("span").text();
                            console.log(prodNo);



                            
                                self.location = "/product/getHistory?prodNo=" + prodNo;
                            




                        })


                    }
                });
            }
        });
        //=============    검색 / page 두가지 경우 모두  Event  처리 =============	
        function fncGetList(currentPage, sorting) {
            $("#currentPage").val(currentPage);
            $("#sorting").val(sorting);
            $("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu }").submit();
        }


        //============= "검색"  Event  처리 =============	
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("button.btn.btn-default").on("click", function() {
                fncGetList('1', '');
            });
        });


        //============= userId 에 회원정보보기  Event  처리(Click) =============	
        $(function() {

            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("td:nth-child(2)").on("click", function() {
                self.location = "/user/getUser?userId=" + $(this).text().trim();
            });

            //==> userId LINK Event End User 에게 보일수 있도록 
            $("td:nth-child(2)").css("color", "red");

        });


        //============= userId 에 회원정보보기  Event  처리 (double Click)=============
        $(function() {


            $('.grid-item a').click(function() {
                var prodNo = $(this).children("span").text();
                console.log(prodNo);



                
                    self.location = "/product/getHistory?prodNo=" + prodNo;
                




            })




            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $("td:nth-child(5) > i").on("click", function() {

                var userId = $(this).next().val();

                $.ajax({
                    url: "/user/json/getUser/" + userId,
                    method: "GET",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function(JSONData, status) {

                        var displayValue = "<h6>" +
                            "아이디 : " + JSONData.userId + "<br/>" +
                            "이  름 : " + JSONData.userName + "<br/>" +
                            "이메일 : " + JSONData.email + "<br/>" +
                            "ROLE : " + JSONData.role + "<br/>" +
                            "등록일 : " + JSONData.regDate + "<br/>" +
                            "</h6>";
                        $("h6").remove();
                        $("#" + userId + "").html(displayValue);
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////

            });

            //==> userId LINK Event End User 에게 보일수 있도록 
            $(".ct_list_pop td:nth-child(3)").css("color", "red");
            $("h7").css("color", "red");

            //==> 아래와 같이 정의한 이유는 ??
            $(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
        });
    </script>

</head>

<body>

    <!-- ToolBar Start /////////////////////////////////////-->

    <!-- ToolBar End /////////////////////////////////////-->

    <!--  화면구성 div Start /////////////////////////////////////-->
    <div class="container">


        <div class="grid">
            <div class="grid-sizer"></div>
            <c:forEach var="product" items="${list }">
                <div class="grid-item">

                    <a href="#">
                        <span class="hiddenNo" style="display: none;">${product.prodNo}</span>
                        <img src="/images/uploadFiles/${product.fileNameList[0]}" alt="">
                        <div>
                            <p>${product.prodName }</p>
                            <p>${product.prodDetail }</p>
                            <p>
                                <fmt:formatNumber value="${product.price}" pattern="#,###" />원
                            </p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
        <!--  table End /////////////////////////////////////-->

    </div>
    <!--  화면구성 div End /////////////////////////////////////-->


    <!-- PageNavigation Start... -->

    <!-- PageNavigation End... -->

</body></html>
