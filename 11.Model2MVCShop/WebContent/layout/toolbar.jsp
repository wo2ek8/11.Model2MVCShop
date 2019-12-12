<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-default navbar-fixed-top">

        <div class="container">

            <a class="navbar-brand" href="../index.jsp">Model2 MVC Shop</a>

            <!-- toolBar Button Start //////////////////////// -->
            <div class="navbar-header">
                <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <!-- toolBar Button End //////////////////////// -->

            <div class="collapse navbar-collapse" id="target">

                <ul class="nav navbar-nav navbar-right">

                    <c:if test="${ ! empty user }">
					 	<li><a href="/user/logout">LOGOUT</a></li>
					 </c:if>
                    <c:if test="${empty user }">
                    <li><a href="/user/login">LOGIN</a></li>
                    </c:if>
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                            <span>MY PAGE</span>
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                        <c:if test="${ !empty user}">
	                        <li><a href="/user/getUser?userId=${user.userId}">개인정보조회</a></li>
	                        <li><a href="/purchase/listPurchase">구매이력조회</a></li>
	                        <li><a href="javascript:history()">최근본상품</a></li>
							<li><a href="/product/listCart">장바구니</a></li>
                        </c:if>
                        <c:if test="${empty user}">
	                        <li><a href="/user/login">개인정보조회</a></li>
	                        <li><a href="/user/login">구매이력조회</a></li>
	                        <li><a href="javascript:history()">최근본상품</a></li>
	                        <li><a href="/user/login">장바구니</a></li>
                        </c:if>
                            
                            
                            
                        </ul>
                    </li>


                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                        LANGUAGE <span class="glyphicon glyphicon-globe"></span>
                    </button>




                    
                </ul>

            </div>

        </div>
    </div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
 	<div class="container">
 		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel"></h4>
                    </div>
                    <div class="modal-body">
                        <p>
                        	LANGUAGE<br>
							WORLDWIDE SHIPPING<br>
							PLEASE SELECT YOUR PREFERRED LANGUAGE.<br>
							<img src="../images/img/m_kr1__.png">
							
                        </p>
                    </div>
                    <div class="modal-footer">
                        <select class="form-control">
							  <option>LANGUAGE : 한국어</option>
							  <option>LANGUAGE : English</option>
							  <option>LANGUAGE : 中文</option>
							  <option>LANGUAGE : 日本語</option>
							  <option>LANGUAGE : 繁體中文</option>
							</select>
                        <button type="button" class="btn btn-primary">GO</button>
                    </div>
                </div>
            </div>
        </div>
 	</div>
   	
   	
   	
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

        a:focus,
        a:hover {
            color: inherit;
            text-decoration: none;
        }

        body {
            font-size: 14px;
            color: #898989;
            font-family: 'Roboto', sans-serif;
            font-family: 'Nanum Gothic', sans-serif;
            padding-top: 80px;
        }

        .navbar-default {
            background: none;
            background-color: rgba(255, 255, 255, 0.7);
            box-shadow: none;
            border: none;
            padding: 15px 0;
        }

        .navbar-default .navbar-nav>.open>a,
        .navbar-default .navbar-nav>.open>a:focus,
        .navbar-default .navbar-nav>.open>a:hover {
            background-color: transparent;
        }

        .navbar-default .navbar-nav>.active>a,
        .navbar-default .navbar-nav>.open>a {
            background: none;
            box-shadow: none;
        }

        .dropdown-menu>li>a:focus,
        .dropdown-menu>li>a:hover {
            background: none;
            font-weight: bold;
        }

        .dropdown-menu>li>a {
            line-height: 2;
        }

        .dropdown-menu {
            padding: 10px 5px 10px 0;
            min-width: auto;
        }

        .navbar-default .navbar-nav>li>a:focus,
        .navbar-default .navbar-nav>li>a:hover {
            color: #777;
        }

        .navbar-right>.btn-primary {
            background: none;
            border: none;
            text-shadow: none;
            box-shadow: none;
            color: #777;
            font-size: 14px;
            line-height: 30px;
        }

        .navbar-right>.btn-primary:focus {
            background: transparent;
            border: none;
        }
        
        .container-fluid>.navbar-collapse, .container-fluid>.navbar-header, .container>.navbar-collapse, .container>.navbar-header {
            padding-right: 15px;
        }
        .navbar>.container .navbar-brand, .navbar>.container-fluid .navbar-brand {
            margin-left: 0;
        }
        .modal-header {
        	border: none;
        }
        .modal-body img {
        	margin-top: 30px;
        }
        .modal-body p {
        	text-align: center;
        }
        .modal-body p:nth-child(1) {
        	font-size: 18px;
        	font-weight: bold;
        }
        .modal-footer {
        	border: none;
        	text-align: center;
        }
        .modal-footer .btn-primary {
        	background: none;
        	border: none;
        	text-shadow: none;
        	box-shadow: none;
        	color: #101010;
    		background: #d99f9d;
    		border: 1px solid #101010;
    		width: 385px;
		    height: 49px;
		    line-height: 25px;
		    border-radius: 0;
		    margin-bottom: 20px;
        }
        .modal-footer .form-control {
        	width: 385px;
        	margin: 0 auto 20px;
        }
    </style>
   	
   	
   	
   	
   	<script type="text/javascript">
   	
   	function history() {
        popWin = window
            .open(
                "/product/getHistoryList",
                "popWin",
                "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
    }
   	
   	
	
		//============= logout Event  처리 =============	
		 $(function() {
			 
			 $('#myModal').on('shown.bs.modal', function() {
			        $('#myInput').focus()
			    })
			 
			 
			 
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logout");
				//self.location = "/user/logout"
			}); 
		 });
		
		//============= 회원정보조회 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('회원정보조회')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/user/listUser"
			}); 
		 });
		
		//=============  개인정보조회회 Event  처리 =============	
	 	/* $( "a:contains('개인정보조회')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		}); */
		
	</script>  