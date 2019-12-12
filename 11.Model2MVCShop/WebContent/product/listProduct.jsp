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
        
        .gotop a {
        	display: inline-block;
        	position: fixed;
        	bottom: 40px;
        	right: 40px;
        	background-color: #eaeaea;
        	width: 70px;
        	height: 70px;
        	border-radius: 50%;
        	opacity: 0;
        	transition: 0.5s;
        }
        
        .gotop.on a {
        	opacity: 1;
        }
        
        .gotop img {
        	position: absolute;
        	top: 50%;
        	left: 50%;
        	transform: translate(-50%, -50%);
        	width: 20px;
        }
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        $(function() {
        	
        	
        	$('.gotop').on('click', function() {
        		$('html, body').animate({
        			'scrollTop' : 0
        		}, 500);
        	});
        	
        	setScrollUI();
        	$(window).on('scroll', function() {
        		setScrollUI();
        	});
        	
        	function setScrollUI() {
        		var scrollTop = $(document).scrollTop();
        		if(scrollTop > 1000) {
        			$('.gotop').addClass('on');
        		} else {
        			$('.gotop').removeClass('on');
        		}
        	}

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



                            if (${param.menu.equals("manage")}) {
                                self.location = '/product/updateProduct?prodNo=' + prodNo;
                            } else if (${param.menu.equals("search")}) {
                                self.location = "/product/getHistory?prodNo=" + prodNo;
                            }




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



                if (${param.menu.equals("manage")}) {
                    self.location = '/product/updateProduct?prodNo=' + prodNo;
                } else if (${param.menu.equals("search")}) {
                    self.location = "/product/getHistory?prodNo=" + prodNo;
                }




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
    <jsp:include page="/layout/toolbar.jsp" />
    <!-- ToolBar End /////////////////////////////////////-->

    <!--  화면구성 div Start /////////////////////////////////////-->
    <div class="container">
    				<c:if test="${empty search.sorting && empty search.searchCondition && empty search.searchKeyword}">
                        <video width="100%" height="auto" autoplay muted loop>
            				<source src="../images/img/y2mate.com%20-%203ce_mini_multi_eye_color_palette_FFuHraUOJ0M_1080p.mp4" type="video/mp4">
            				<source src="../images/img/y2mate.com%20-%203ce_mini_multi_eye_color_palette_FFuHraUOJ0M_1080p.ogg" type="video/ogg">
       					 </video>
                    </c:if>
                    
                    
    

        <div class="page-header text-info">
            <h3>상품검색</h3>
        </div>

        <div class="row">

            <div class="col-md-6 text-left">
                <p class="text-primary">
                    전체 ${resultPage.totalCount } 건수
                </p>
            </div>

            <div class="col-md-6 text-right">
                <form class="form-inline" name="detailForm">

                    <div class="form-group">
                        <select class="form-control" name="searchCondition" id="searchCondition">
                            <option value="0" ${!empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
                            <option value="1" ${!empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
                            <option value="2" ${!empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="sr-only" for="searchKeyword">검색어</label>
                        <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                    </div>

                    <button type="button" class="btn btn-default">검색</button>

                    <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                    <input type="hidden" id="currentPage" name="currentPage" value="" />
                    <input type="hidden" id="sorting" name="sorting" value="${search.sorting }" />

                </form>

                <ul class="sorting">
                    <c:if test="${!empty search.sorting }">
                        <c:if test="${search.sorting == '0' }">
                            <li class="on"><a href="#"><span></span> 신상품</a></li>
                            <li><a href="#"><span></span> 낮은가격</a></li>
                            <li><a href="#"><span></span> 높은가격</a></li>
                            <li><a href="#"><span></span> 이름</a></li>
                        </c:if>
                        <c:if test="${search.sorting == '1' }">
                            <li><a href="#"><span></span> 신상품</a></li>
                            <li class="on"><a href="#"><span></span> 낮은가격</a></li>
                            <li><a href="#"><span></span> 높은가격</a></li>
                            <li><a href="#"><span></span> 이름</a></li>
                        </c:if>
                        <c:if test="${search.sorting == '2' }">
                            <li><a href="#"><span></span> 신상품</a></li>
                            <li><a href="#"><span></span> 낮은가격</a></li>
                            <li class="on"><a href="#"><span></span> 높은가격</a></li>
                            <li><a href="#"><span></span> 이름</a></li>
                        </c:if>
                        <c:if test="${search.sorting == '3' }">
                            <li><a href="#"><span></span> 신상품</a></li>
                            <li><a href="#"><span></span> 낮은가격</a></li>
                            <li><a href="#"><span></span> 높은가격</a></li>
                            <li class="on"><a href="#"><span></span> 이름</a></li>
                        </c:if>
                    </c:if>
                    <c:if test="${empty search.sorting}">
                        <li><a href="#"><span></span> 신상품</a></li>
                        <li><a href="#"><span></span> 낮은가격</a></li>
                        <li><a href="#"><span></span> 높은가격</a></li>
                        <li><a href="#"><span></span> 이름</a></li>
                    </c:if>

                </ul>
            </div>

        </div>

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
    
    
    
    
    
    <div class="gotop">
    	<a href="#">
    		<img src="../images/img/unnamed.png" alt="">
    	</a>
    </div>
    <!--  화면구성 div End /////////////////////////////////////-->


    <!-- PageNavigation Start... -->

    <!-- PageNavigation End... -->

</body></html>
