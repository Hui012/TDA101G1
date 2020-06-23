<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="com.customerizedetail.model.CustDetailVO"%>
<%@page import="com.customerize.model.CustomerizeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
<%

// CustVO custVO = (CustVO) request.getAttribute("custVO");
List<CustDetailVO> lists = (List<CustDetailVO>) request.getAttribute("custDetails");
pageContext.setAttribute("list", lists);
// session.setAttribute("list", lists);


%>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Google Map -->
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAbXslbdHryJFaivbDzQzHhvwo4bxM9hpc&callback=initMap&libraries=&v=weekly"
        defer></script>
    <link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/vendors/css/footer.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <!-- 載入 Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
    <style>
        * {
            font-family: 微軟正黑體;
            font-weight: bold;
        }
        .navbar-light .navbar-nav .nav-link {
		    color: rgba(0,0,0,.5) !important;
		    font-weight: normal;
		}

        body {
            height: 100%;
        }

        div.main-content {
            min-height: 100%;
            padding-top: 50px;
            padding-bottom: 50px;
            position: relative;
            margin-bottom: -100px;
        }

        footer {
            background-color: black;
            height: 164px;
            font-size: 24px;
            font-weight: bold;
            /* position: absolute;
            bottom: 0;
            left: 0; */
            width: 100%;
        }

        button,
        img,
        .btn_overlay_schedule_close,
        .btn_overlay_style_close {
            cursor: pointer;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        .-none {
            display: none;
        }

        nav.navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 10;
            opacity: 0.8;
        }

        /*-------------------------------top_navbar------------------------------*/
        div.top_navbar {
            width: 100%;
            height: 70px;
            margin-top: 56px;
            background-color: #343434;
            color: #E6903B;
            font-size: 32px;
            font-weight: bold;
            /* display: flex; */
            /* align-items: center */
        }

        span.text_title {
            line-height: 70px;
            height: 500px;
        }

        div.btn_model {
            line-height: 62px;
            float: right;
        }

        div.btn_model button {
            margin-left: 10px;
        }

        /*-------------------------------行程明細------------------------------*/
        div.schedule_content {
            width: 100%;
            height: 100%;
            border: 1px solid black;
        }

        div.detail_block {
            width: 600px;
            height: 150px;
            border: 1px solid black;
            font-size: 0;
            box-shadow: 0 0 6px;
            border-radius: 4px;
            margin: 20px auto 0 auto;
        }

        div.detail_info {
            border-top: 1px solid black;
            display: block;
            width: 100%;
            height: 69px;
            font-size: 16px;
            word-break: break-all;
        }

        div.detail_info p {
            max-height: 100%;
            word-break: break-all;
            overflow: hidden;
        }

        div.detail_time {
            display: inline-block;
            width: calc(100% - 120px);
            height: 100%;
            font-size: 16px;
            text-align: center;
        }

        div.detail_img {
            display: inline-block;
            vertical-align: bottom;
            width: 120px;
            height: 100%;
        }

        div.detail_img img {
            width: 100%;
            height: 100%;
        }

        div.detail_top {
            width: 100%;
            height: 80px;
        }

        div.product_ticket {
            width: 230px;
            height: 120px;
            border: 1px solid black;
        }


        /*-------------------選購明細--------------------*/
        div.cart_content {
            display: block;
            width: 100%;
            height: 100%;
            border: 1px solid black;
            max-height: 650px;
            text-align: center;
            position: sticky;
            top: 56px
        }

        div.cart_title {
            border: 1px solid black;
            width: 100% + 2px;
            height: 80px;
            margin: -1px 0 0 -1px;
            text-align: center;
        }

        div.cart_title {
            line-height: 80px;
            font-size: 32px;
            font-weight: bold;
            color: #343434;
        }

        li.cart_detail {
            width: 100%;
            height: 140px;
            border-bottom: 1px solid #343434;
            margin-top: 20px;
        }

        div.product_block {
            height: 140px;
        }

        div.product_ticket {
            box-shadow: 0 0 6px;
            border-radius: 4px;
        }

        div.product_ticket_img {
            width: 120px;
            height: 100%;
            border-bottom: 1px solid #343434;
            display: inline-block;
        }

        div.product_ticket_img img {
            width: 100%;
            height: 100%;
        }

        div.product_ticket_name {
            width: calc(100% - 120px - 4px);
            height: 100%;
            display: inline-block;
            vertical-align: top;
        }

        div.product_ticket_name p {
            margin-top: 40px;
            text-align: center;
            /* line-height: 108px; */
            font-size: 16px;
            font-weight: bold;
            color: #343434;
            word-break: break-all;
        }

        div.trash_block {
            height: 140px;
            text-align: center;
            line-height: 140px;
        }

        div.select_block {
            height: 140px;
            text-align: center;
        }

        input.input_quantity {
            width: 45px;
            vertical-align: top;
        }

        div.cart_body {
            height: calc(100% - 82px - 80px);
            overflow-y: scroll;
            overflow-x: hidden;
        }

        div.go_buy {
            width: 100%;
            height: 80px;
            bottom: 0;
            border-top: 1px solid black;
            line-height: 80px;
        }


        /*--------------------廣告------------------------*/
        div.ad_content {
            width: 100%;
            height: 100%;
            border: 1px solid black;
            display: block;
        }

        div.ad_title {
            border: 1px solid black;
            width: 100% + 2px;
            height: 80px;
            margin: -1px 0 0 -1px;
            text-align: center;
        }

        div.ad_title {
            line-height: 80px;
            font-size: 32px;
            font-weight: bold;
            color: #343434;
        }



        /*------------------行程資訊---------------------*/
        div.schedule_info {
            text-align: center;
            margin: 20px 0;
        }

        div.total_day {
            border: 1px solid black;
            background-color: #31C7D2;
            width: 280px;
            height: 105px;
            display: inline-block;
            margin-right: 10px;

        }

        div.icon_date_block {
            width: 76px;
            height: 100%;
            display: inline-block;
        }

        div.schedule_spent {
            border: 1px solid black;
            background-color: #31C7D2;
            width: 280px;
            height: 105px;
            display: inline-block;
            margin-left: 10px;
        }

        div.icon_money_block {
            width: 76px;
            height: 100%;
            display: inline-block;
        }

        div.icon_date,
        div.icon_money {
            line-height: 68px;
            background-color: #E0DFDF;
            width: 55px;
            height: 55px;
            border-radius: 50px;
            margin: 22px auto 0 auto;
            color: #343434;
            font-weight: bold;

        }

        div.text_date,
        div.text_money {
            display: inline-block;
            font-size: 16px;
            font-weight: bold;
            color: #343434;
            vertical-align: top;
            width: 198px;
            height: 100%;

            /* line-height: 103px; */
        }

        /*------------------------單日資訊------------------------*/
        div.day_info,
        div.day_weather,
        div.day_spent {
            width: 100%;
            height: 100%;

        }

        div.all {
            width: 600px;
            height: 80px;
            margin: 20px auto 0 auto;
            text-align: center;
            font-size: 16px;
        }

        div.day_icon {
            display: inline-block;
            height: 100%;
            width: 70px;
            vertical-align: top;
        }

        div.day_date {
            background-color: #E6903B;
            width: 55px;
            height: 55px;
            border-radius: 50px;
            color: #343434;
            font-weight: bold;
            display: inline-block;
            line-height: 55px;
        }

        div.day_text_date {
            display: inline-block;
            height: 100%;
            width: 124px;
        }

        /*------------------------地圖資訊------------------------*/
        #map {
            height: 100%;
        }

        div.days {
            height: 100%;
            width: 100%;
            box-shadow: 0 0 10px;
            margin-top: -1px 0 1px 0;
            /* box-shadow: 10px 0 5px -2px #888; */
        }

        ul.day {
            list-style: none;
            padding: 0;
        }

        ul.day p {
            border-bottom: 1px solid #E0DFDF;
            height: 70px;
            width: 100%;
            line-height: 70px;
            text-align: center;
            font-size: 20px;
            margin: 0;
        }

        .-selected {
            background-color: #E0DFDF;
            color: #E6903B;
            border-color: #E6903B;
            box-shadow: 0 0 6px;
        }

        /*------------------------文字閃爍------------------------*/
        .blink {
            animation-duration: 1s;
            animation-name: blink;
            animation-iteration-count: infinite;
            animation-direction: alternate;
            animation-timing-function: ease-in-out;
            color: red;
            line-height: 45px;
            font-size: 18px;
        }
        @keyframes blink {
            from {
                opacity: 1;
            }
            to {
                opacity: 0;
            }
        }



        div.btn_model button {
            width: 150px;
      margin-right: 5px;
    }
        .dropdown-menu{
        width: 400px;
        padding: 10px 20px;
        margin: 0 auto;
        height: 110px;
    }
        .show{
        /* transform: translate3d(381px, 48px, 0px); */
        left: -10px !important;
        }
        .dropdown-menu span{
            font-size: 20px;
        }

    </style>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>

<body>
    <div class="main_content">

       <%--  <nav class="navbar navbar-expand navbar-light d-flex justify-content-start" style="background-color: #e3f2fd;">
            <a class="navbar-brand mr-auto" href="#">
                <img src="<%=request.getContextPath()%>/img/hui/logo.png" width="30" height="30"
                    class="d-inline-block align-top" alt="tourism">
                Tourism</a>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-pen"></i>建立行程</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-store"></i>商城</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-shopping-cart"></i>購物車</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-sign-in-alt"></i>會員中心</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-user"></i>USER</a>
                </li>
            </ul>
        </nav> --%>
		<%@include file="../frontstage_member/pages/header.file" %>

        <div class="container-fliud">
            <div class="top_navbar" data-schedule-id="${custVO.cust_Schedule_ID}" data-member-id="${custVO.member_ID}"
                data-position="${custVO.cust_Position}" data-selected-county="${custVO.cust_Selected_County}">
                <div class="row" style="margin: 0;">
                    <div class="col col-md-6">
                        <span class="text_title">${custVO.cust_Schedule_Name}</span>
                    </div>

                    <div class="col col-md-6">
                        <form action="<%=request.getContextPath()%>/CustomerizeController" method="POST">
                            <div class="btn_model">
                                <button id="btn_map" type="button" class="btn btn-primary btn-lg">行程路線</button>
                                <button id="btn_standard" type="button" class="btn btn-primary btn-lg -none">標準模式</button>
                                <button id="btn_produce" type="submit" class="btn btn-primary btn-lg">編輯行程</button>
                                <button id="btnGroupDrop1" type="button" class="btn btn-primary btn-lg dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">共同編輯</button>
                                <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                <span>請輸入email：</span><input id="email" type="text" style="width: 75%;">
                                <button id="invite" type="button" style="width: 50px;">邀請</button>
                                </div>
                                <!-- <button id="btn_share" type="button" class="btn btn-primary btn-lg">分享行程</button> -->
                                <input type="hidden" name="action" value="edit_schedule">
                                <input type="hidden" name="cust_schedule_id" value="${custVO.cust_Schedule_ID}">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <div class="container-fluid -none">
            <div class="tex">
                <div class="row" style="height: 1000px">
                    <div class="col col-md-1" style="padding: 0; z-index: 10;">
                        <div class="days">
                            <ul class="day">
                                <%int j = 0;%>
                                <c:forEach var="value" items="${list}">
                                    <c:if test="${value.cust_Schedule_Detail_Seq == 0}">
                                        <li class="Day<%=++j%>">
                                            <p>D<%=j%></p>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="col col-md-11" style="padding: 0;">
                        <div id="map"></div>
                    </div>
                </div>
            </div>
        </div>


        <div class="container" style="margin-top: -1px;">
            <div class="test">
                <div class="row">
                    <div class="col col-md-7" style="padding-right: 0;">
                        <div class="schedule_content">
                            <div class="schedule_info">
                                <div class="total_day">
                                    <div class="icon_date_block">
                                        <div class="icon_date">
                                            <i class="far fa-calendar-alt fa-2x"></i>
                                        </div>
                                    </div>
                                    <div class="text_date">
                                        <p style="margin: 25px auto auto auto;">
                                            <span>共</span>${custVO.cust_Schedule_Total_Day}<span>天</span></p>
                                        <p>${custVO.cust_Schedule_Start_Time}~${custVO.cust_Schedule_End_Time}</p>
                                    </div>
                                </div>
                                <div class="schedule_spent">
                                    <div class="icon_money_block">
                                        <div class="icon_money">
                                            <i class="fas fa-dollar-sign fa-2x"></i>
                                        </div>
                                    </div>
                                    <div class="text_money">
                                    <c:set value="0" var="totalSum" />
                                        <c:forEach var="value" items="${list}">
                                            <c:forEach var="productDetail" items="${value.productVO.productDetailVOs}"
                                                varStatus="status">
                                                <c:if test="${status.first}">
                                                    <c:set
                                                        value="${totalSum + (productDetail.product_Detail_Money * custVO.cust_Quantity)}"
                                                        var="totalSum" />
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                        <span style="line-height: 103px;">TWD <span id="money">${totalSum}</span></span>
                                    </div>
                                </div>
                            </div>

                            <ul class="schedule_detail">
                                <!--------------- 動態新增 --------------->
                                <%int i = 0;%>
                                <c:forEach var="value" items="${list}">
                                    <c:if test="${value.cust_Schedule_Detail_Seq == 0}">
                                        <div id="Day<%=++i%>" class="all">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="col col-md-4" style="padding-right: 0; padding-left: 0;">
                                                    <div class="day_info">
                                                        <div class="day_icon">
                                                            <div class="day_date">
                                                                <span>D<%=i%></span>
                                                            </div>
                                                        </div>
                                                        <div class="day_text_date">
                                                            <p id="user_date">${value.cust_Schedule_Detail_Date}</p>
                                                            <p>
                                                                <fmt:formatDate pattern="E"
                                                                    value="${value.cust_Schedule_Detail_Date}" />
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col col-md-4" style="padding-right: 0; padding-left: 0;">
                                                    <div class="day_weather">
                                                        <p style="margin-bottom: 6px;">單日里程：<span class="total_km"></span> 公里</p>
                                                        <p id="all_weather">天氣預測：<span id="weather"></span>度
                                                            <span id="sun" class="-none"><i class="fas fa-sun fa-2x"></i></span>
                                                            <span id="cloud" class="-none"><i class="fas fa-cloud fa-2x"></i></span>
                                                            <span id="cloud-showers-heavy" class="-none"><i class="fas fa-cloud-showers-heavy fa-2x"></i></span>
                                                            <span id="cloud-sun" class="-none"><i class="fas fa-cloud-sun fa-2x"></i></span>
                                                            <span id="cloud-sun-rain" class="-none"><i class="fas fa-cloud-sun-rain fa-2x"></i></span>
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="col col-md-4" style="padding-right: 0; padding-left: 0;">
                                                    <div class="day_spent">
                                                        <p>單日花費：$ <span id="day_spent">0</span></p>
                                                        <p><span>人數：</span>${custVO.cust_Quantity}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <li class="schedule_block" id="${value.productVO.product_ID}_Day<%=i%>"
                                            data-sort="${value.cust_Schedule_Detail_Seq}" data-county="${value.productVO.product_County}"
                                            data-latitutde="${value.productVO.product_Latitutde}"
                                            data-longitude="${value.productVO.product_Longitude}"
                                            style="padding-left: 15px; padding-right: 15px;">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="col col-md-12" style="padding: 0;">
                                                    <div class="detail_block">
                                                        <div class="detail_top">
                                                            <div class="detail_img">
                                                                <img
                                                                    src="<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=${value.product_ID}">
                                                            </div>
                                                            <div class="detail_time">
                                                                <p style="font-size: 24px">
                                                                    ${value.productVO.product_Name}
                                                                </p>
                                                                <%--                                                                 <fmt:parseNumber var="time" integerOnly="" value="${value.productVO.product_Staytime}"></fmt:parseNumber> --%>
                                                                <p><i class="far fa-clock"></i>
                                                                    	建議遊玩時間：<span>${value.productVO.product_Staytime}</span>小時
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="detail_info">
                                                            <p>${value.cust_Schedule_Detail_Info}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:if>
                                    <c:if test="${value.cust_Schedule_Detail_Seq != 0}">
                                        <li class="schedule_block" id="${value.productVO.product_ID}_Day<%=i%>"
                                            data-sort="${value.cust_Schedule_Detail_Seq}" data-county="${value.productVO.product_County}"
                                            data-latitutde="${value.productVO.product_Latitutde}"
                                            data-longitude="${value.productVO.product_Longitude}"
                                            style="padding-left: 15px; padding-right: 15px;">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="col col-md-12" style="padding: 0;">
                                                    <div class="row"
                                                        style="padding-left: 15px; padding-right: 15px; margin-top: 20px;">
                                                        <div class="col col-md-3">
                                                            <span><i class="fas fa-car-side fa-2x"></i></span>
                                                            <span><span id="km"></span> 公里</span>
                                                        </div>
                                                        <div class="col col-md-6" style="text-align: center;">
                                                            <span style="margin: auto;"><i class="fas fa-arrow-down fa-2x"></i></span>
                                                        </div>
                                                    </div>

                                                    <div class="detail_block">
                                                        <div class="detail_top">
                                                            <div class="detail_img">
                                                                <img
                                                                    src="<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=${value.product_ID}">
                                                            </div>
                                                            <div class="detail_time">
                                                                <p style="font-size: 24px">
                                                                    ${value.productVO.product_Name}
                                                                </p>
                                                                <p><i class="far fa-clock"></i>
                                                                   	 建議遊玩時間：<span>${value.productVO.product_Staytime}</span>小時
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="detail_info">
                                                            <p>${value.cust_Schedule_Detail_Info}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="col col-md-5" style="padding-left: 0;">
                        <div class="cart_content">
                            <div class="cart_title">
                                <p>選購明細</p>
                            </div>
                            <div class="cart_body">
                                <ul id="cart_list">
                                    <!--------------- 動態新增 --------------->
                                    <c:forEach var="value" items="${list}">
                                        <li id="${value.productVO.product_ID}" class="cart_detail" 
                                            data-date="${value.cust_Schedule_Detail_Date}" data-sort="${value.cust_Schedule_Detail_Seq}">
                                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                                <div class="col col-md-6" style="padding-left: 5px;">
                                                    <div class="product_block">
                                                        <div class="product_ticket">
                                                            <div class="product_ticket_img">
                                                                <img
                                                                    src="<%=request.getContextPath()%>/ImageController?action=printImage_product_id&product_id=${value.productVO.product_ID}">
                                                            </div>
                                                            <div class="product_ticket_name">
                                                                <p>${value.productVO.product_Name}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col col-md-5" style="padding-right: 0; padding-left: 0;">
                                                    <div class="select_block">
                                                        <c:choose>
															<c:when test="${not empty value.productVO.productDetailVOs}">
                                                                <p id="ticket_date" style="margin: 0;">${value.cust_Schedule_Detail_Date}</p>
                                                                <p id="stock" class="-none" style="margin: 0; font-size: 16px; line-height: 24px">已達庫存上限</p>
                                                                <c:choose> 
                                                                    <c:when test="${value.productVO.product_State == 0}">
                                                                        <p style="line-height: 80px;">※此商品已下架※</p>
                                                                    </c:when>
		                                                           	<c:otherwise> 
                                                                        <input class="input_quantity" style="margin-top: 15px;"
                                                                        type="number" value="${custVO.cust_Quantity}" name="points" min="1" max="99"></input>
                                                                        <c:forEach var="productDetail" items="${value.productVO.productDetailVOs}" varStatus="status">
                                                                            <c:if test="${status.first}">
                                                                                <span style="line-height: 60px;"> NT$ <span id="sum">
                                                                                    ${productDetail.product_Detail_Money * custVO.cust_Quantity}</span>
                                                                                </span>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                        <select class="select_options" style="height: 30px; width: 80%;">
                                                                            <c:forEach var="productDetail" items="${value.productVO.productDetailVOs}">
                                                                                <option value="${productDetail.product_Detail_Money}" data-productdetail-ID="${productDetail.product_Detail_ID}" data-instock="${productDetail.product_Detail_Instock}">
                                                                                    ${productDetail.product_Detail_Spc}        
                                                                                </option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </c:otherwise> 
                                                                </c:choose> 
                                                        	</c:when>                                             
                                                        	<c:otherwise>
                                                            	<p style="line-height: 80px;">※此商品無須票券※</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <div class="col col-md-1" style="padding-right: 0; padding-left: 0;">
                                                    <div class="trash_block">
                                                        <span class="trash" style="cursor: pointer;"><i
                                                                class="fas fa-trash-alt fa-2x"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="go_buy">
                                <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                    <div class="col col-md-6" style="padding-right: 0; padding-left: 0;">
                                        <c:set value="0" var="sum" />
                                        <c:forEach var="value" items="${list}">
                                            <c:forEach var="productDetail" items="${value.productVO.productDetailVOs}"
                                                varStatus="status">
                                                <c:if test="${status.first}">
                                                    <c:set
                                                        value="${sum + (productDetail.product_Detail_Money * custVO.cust_Quantity)}"
                                                        var="sum" />
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                        <p style="font-size: 20px;">合計：NT$<span id="total_price">${sum}</span></p>
                                    </div>
                                    <div class="col col-md-6" style="padding-right: 0; padding-left: 0;">
                                        <button id="btn_buy" type="button" class="btn btn-primary btn-lg">加入購物車</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- <div class="ad_content">
                        <div class="ad_title">
                            <p>廣告</p>
                        </div>
                        <ul class="ad_list"> -->
                        <!--------------- 動態新增 --------------->
                        <!-- <li id="" class="ad_detail">
                                <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                    <div class="col col-md-6">

                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div> -->


                    </div>
                </div>
            </div>
        </div>
    </div>
 <!--    <footer class="footer">
        <div class="container">
            <span class="text-muted">WEB DEVELOPER</span>
        </div>
    </footer> -->

	<%@ include file="../frontstage_member/pages/footer.file" %>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
        integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous">
    </script>
    <!-- Font-Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"></script>
    <!-- jQuery -->
    <script src="<%=request.getContextPath()%>/vendors/jquery/jquery-3.4.1.min.js"></script>
    <!-- 日曆 -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <!-- sweetalert -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/js/footer.js"></script>
    <script>
        function initMap(){}
        $(function () {
            sessionStorage.clear(); //清除sessionStorge資料
            init_takeSchedule_setSessionstorage();
            calculateDistance_and_totalKm();
            load_location_weather_week();
            a_day_spent();
            let position = $("div.top_navbar").attr("data-position").split(",");
            var user_departure = {lat: parseFloat(position[0]), lng: parseFloat(position[1])};
            var map;
            initMap = function () {
                map = new google.maps.Map(document.getElementById("map"), {
                    center: user_departure,
                    zoom: 14,
                    gestureHandling: 'greedy'
                });
            }

            /*----------------------------選購明細的操作--------------------------------*/
            $("div.select_block").on("change", function () {
                let $this = $(this);
                let price = parseFloat($this.find("select.select_options").val());
                let quantity = parseFloat($this.find(".input_quantity").val());
                let stock = $this.find("select option:selected").attr("data-instock")
                let total_price = 0;
                $this.find(".input_quantity").attr("max", stock);     //會依照選擇的品項決定數量的最大值
                $this.find("span#sum").html(quantity * price);
                $("ul#cart_list").find("li").each(function (i, value) {
                    if($(value).find("span#sum").html() != undefined){
                        total_price += parseInt($(value).find("span#sum").html());
                    }
                });
                $("span#total_price").html(total_price);
                $("div.text_money span#money").html(total_price);
                if(quantity > stock){
                    $this.find(".input_quantity").val(stock);
                }
                if(quantity == stock){
                    console.log(5646)
                    $this.find("p#ticket_date").addClass("-none");
                    $this.find("p#stock").removeClass("-none").addClass("blink");
                    setTimeout(function(){
                        $this.find("p#stock").removeClass("-blink").addClass("-none");
                        $this.find("p#ticket_date").removeClass("-none"); 
                    },4000)
                }
                a_day_spent();
            });
            /*----------------------------選購明細的操作--------------------------------*/
            $("button#btn_buy").on("click", function(){
                let member_ID = $("div.top_navbar").data("member-id");
                let cart = []
                $("ul#cart_list").find("li").each(function(i, value){
                    console.log(value)
                    let product_ID = $(value).attr("id");
                    let product_Name = $(value).find("div.product_ticket_name p").text();
                    let productDetail_ID = $(value).find("select option:selected").data("productdetail-id");
                    let quantity = $(value).find("input.input_quantity").val();
                    let spc = $(value).find("select option:selected").text().trim();
                    let start_end = $(value).data("date");
                    let price = $(value).find("select option:selected").val();
                    let temp = {
                        "member_ID":member_ID,
                        "product_ID":product_ID,
                        "product_Name":product_Name,
                        "productDetail_ID":productDetail_ID == undefined? "null":productDetail_ID,
                        "quantity":quantity == undefined? "null":quantity,
                        "spc":spc,
                        "start":start_end,
                        "end":start_end,
                        "price":price == undefined? "null":price
                    }
                    cart.push(temp);
                });
                console.log(cart)
                
                $.ajax({
                    url:"<%=request.getContextPath()%>/project/JsonController",
                    type:"POST",
                    data: {
                        "action":"add_cart",
                        "cart_list": JSON.stringify(cart)
                    },
                    dataType:"json",
                    success: function (data) {
                        if(data.result === "success"){
                            $("ul#cart_list").html("");
                            $("span#total_price").text(0);
                            swal({
                                position: 'top-end',
                                icon: 'success',
                                title: '已成功加入購物車',
                                showConfirmButton: false,
                                timer: 1500
                            });
                        }
                    },error: function(){
                        console.log("fail");
                    }
                });

            });
            // String member_ID, String product_ID, String product_Name,
			// String productDetail_ID, String quantity, String spc, String start, String end, String price
            /*----------------------------刪除購買項目--------------------------------*/
            $("span.trash").on("click", function () {
                $(this).closest("li").remove();
                let total_price = 0;
                $("ul#cart_list").find("li").each(function (i, value) {
                    if($(value).find("span#sum").html() != undefined){
                        total_price += parseInt($(value).find("span#sum").html());
                    }
                });
                $("span#total_price").html(total_price);
                $("div.text_money span#money").html(total_price);
                a_day_spent();
            });

            /*----------------------------行程路線按鈕--------------------------------*/
            $("button#btn_map").on("click", function () {
                $("ul.day").find("li.Day1").addClass("-selected");
                $("div.container-fluid").removeClass("-none")
                $("div.container").addClass("-none")
                $(this).addClass("-none");
                $("button#btn_standard").removeClass("-none");

                let current_sessiontorage = JSON.parse(sessionStorage.getItem("Day1"));
                calculateAndDisplayRoute(current_sessiontorage)
            });
            /*----------------------------標準模式按鈕--------------------------------*/
            $("button#btn_standard").on("click", function () {
                $("div.container-fluid").addClass("-none")
                $("div.container").removeClass("-none")
                $(this).addClass("-none");
                $("button#btn_map").removeClass("-none");
            });

            /*----------------------------地圖模式的天數按鈕--------------------------------*/
            $("ul.day").find("li").on("click", function () {
                let day = $(this).attr("class");  //取得點選的天數
                $("ul.day").find("li").each(function (i, value) {
                    if ($(this).hasClass("-selected")) {
                        $(this).removeClass("-selected");
                    }
                });
                $(this).addClass("-selected");

                let current_sessiontorage = JSON.parse(sessionStorage.getItem(day));
                calculateAndDisplayRoute(current_sessiontorage)
            });

            /*----------------------------單日花費計算--------------------------------*/
            function a_day_spent(){
                let li_length = $("ul#cart_list").children("li").length;
                let day_spent = 0;
                let count = 0;
                $("ul#cart_list").find("li").each(function(i, value){
                    let spent = $(value).find("span#sum").html();
                    let current_sort = $(value).attr("data-sort");
                    let next_sort = $(value).next().attr("data-sort");

                    if(spent != undefined){
                        day_spent += parseFloat(spent);
                        if(next_sort == 0){
                            $("div#Day"+ (++count)).find("span#day_spent").html(day_spent);
                            day_spent = 0;
                        }
                        if(i == li_length - 1){
                            $("div#Day"+ (++count)).find("span#day_spent").html(day_spent);
                        }
                    }else if (next_sort == 0 && spent == undefined){
                        $("div#Day"+ (++count)).find("span#day_spent").html(day_spent);
                        day_spent = 0;
                    }
                 });
            }

            /*----------------------------測試--------------------------------*/
            function calculateKm(distance, day){
                let day_km = 0;
                $.each(distance, function(i, item){
                    day_km += item;
                });
                console.log(day_km)
                $("div#"+day).find("span.total_km").html(day_km.toFixed(1));
            }



            // function calculateKm(){
            //     let li_length = $("ul.schedule_detail").children("li").length;
            //     let day_km = 0;
            //     let count = 0;
            //     $("ul.schedule_detail").find("li").each(function(i, value){
            //         let km = parseFloat($(value).find("span#km").html());
            //         let current_sort = $(value).attr("data-sort");
            //         let next_sort = $(value).next().attr("data-sort");

            //         if(current_sort != 0){
            //             day_km += km;
            //             if(next_sort == undefined){
            //                 $("div#Day"+ (++count)).find("span.total_km").html(day_km);
            //                 day_km = 0;
            //             }
            //             if(i == li_length - 1){
            //                 $("div#Day"+ (++count)).find("span.total_km").html(day_km);
            //             }
            //         }
            //         console.log(value)
            //     });
            // }
            /*----------------------------ajax連線氣象局未來一週的天氣--------------------------------*/
            function load_location_weather_week(){
                $.ajax({
                    url:"https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=CWB-0D551AD8-4C7E-49D4-923D-F248A6E8BC2C",
                    type:"GET",
                    dataType:"json",
                    success: function (data) {
                        if(data.success == "true"){
                            let location_weather = (data.records.locations[0].location)
                            check_location_weather_week(location_weather);
                        }
                    },error: function(){
                        console.log("fail");
                    }
                });
            }

            /*----------------------------判斷景點所屬縣市的天氣--------------------------------*/
            function check_location_weather_week(location_weather){
                let temperature = "";
                let weather_num = "";
                $("ul.schedule_detail").find("div.all").each(function(i, items){
                    let first_county = $(items).next("li").attr("data-county");
                    let user_date = $(this).find("p#user_date").html();
                    $.each(location_weather, function(j, location){
                        if(first_county === location.locationName){
                            let temperature_time = location.weatherElement[1].time;      //溫度
                            let weather_time = location.weatherElement[6].time;          //天氣現象
                            let count_temperature = 0;
                            let count_weather = 0;
                            $.each(temperature_time, function(k, time1){
                                if(count_temperature == 1){
                                    return;
                                }
                                let temperature_date = flatpickr.formatDate(new Date(time1.startTime), 'Y-m-d');
                                if(user_date == temperature_date){
                                    ++count_temperature;
                                    temperature = time1.elementValue[0].value;
                                }
                            });
                            $.each(weather_time, function(l, time2){
                                if(count_weather == 1){
                                    return;
                                }
                                let weather_date = flatpickr.formatDate(new Date(time2.startTime), 'Y-m-d');
                                if(user_date == weather_date){
                                    ++count_weather;
                                    weather_num = parseInt(time2.elementValue[1].value);
                                }
                            });
                        }
                    });
                    console.log(weather_num);
                    if(temperature == "" && weather_num == ""){
                        $("div#Day"+(i+1)).find("p#all_weather").html("僅提供未來一週天氣預報").addClass("blink");
                        setTimeout(function(){
                            $("div#Day"+(i+1)).find("p#all_weather").html("僅提供未來一週天氣預報")
                                        .removeClass("blink").css("color", "red").css("line-height", "45px")
                        },4000);
                    }else{
                        $("div#Day"+(i+1)).find("span#weather").html(temperature);
                        weather_num == 1 || weather_num == 2? $("div#Day"+(i+1)).find("span#sun").removeClass("-none"):  
                        weather_num == 3 || weather_num == 4? $("div#Day"+(i+1)).find("span#cloud-sun").removeClass("-none"):
                        weather_num >= 5 && weather_num <= 7? $("div#Day"+(i+1)).find("span#cloud").removeClass("-none"):
                        weather_num >= 8 && weather_num <= 10? $("div#Day"+(i+1)).find("span#cloud-sun-rain").removeClass("-none")
                                                              :$("div#Day"+(i+1)).find("span#cloud-showers-heavy").removeClass("-none")
                    }
                });
            }

            /*----------------------------顯示路線google API--------------------------------*/
            function calculateAndDisplayRoute(current_sessiontorage) {
                initMap();
                var directionsRenderer = new google.maps.DirectionsRenderer;
                var directionsService = new google.maps.DirectionsService;
                directionsRenderer.setMap(map);
                // let travel_mode = travelMode == null ? 'DRIVING' : travelMode;
                let waypts = [];
                $.each(current_sessiontorage, function (i, value) {
                    if (i == (current_sessiontorage.length - 1)) {
                        user_destination = {lat: value.lat, lng: value.lng};
                    } else {
                        let temp = {
                            location: {lat: value.lat, lng: value.lng}, //使用者選的地點經緯度
                            stopover: true
                            // type: ('location_'+ (i+1))        //用哪一個icon
                        }
                        waypts.push(temp);
                    }
                });
                directionsService.route({
                    origin: user_departure, // Note that Javascript allows us to access the constant
                    destination: user_destination, // using square brackets and a string value as its"property."
                    waypoints: waypts,
                    optimizeWaypoints: false,
                    travelMode: google.maps.TravelMode['DRIVING']
                }, function (response, status) {
                    if (status == 'OK') {
                        console.log(response.routes[0]);
                        directionsRenderer.setDirections(response);
                    } else {
                        console.log('Directions request failed due to ' + status);
                    }
                });
            }

            /*----------------------------讀取當前列表景點的資料，存入sessionStorage--------------------------------*/
            function init_takeSchedule_setSessionstorage() {
                let count = 1;
                let current_product = [];
                let start = "";
                let end = "";
                $("ul.schedule_detail").find("li").each(function (i, value) {
                    let product_id = $(value).attr("id");
                    let product_name = $(value).find("div.detail_time p").html().trim();
                    let sort = $(value).attr("data-sort");
                    let lat = parseFloat($(value).attr("data-latitutde"));
                    let lng = parseFloat($(value).attr("data-longitude"));
                    let temp = {
                        "product_id": product_id,
                        "product_name": product_name,
                        "sort": sort,
                        "lat": lat,
                        "lng": lng
                    }
                    current_product.push(temp); 
                    if ($(value).next("div").hasClass("all")) { 
                        sessionStorage.setItem("Day" + count, JSON.stringify(current_product));
                        count++;
                        current_product = [];
                    }
                    if ($(value).is(":last-child")) { //最後一筆資料直接存入
                        sessionStorage.setItem("Day" + count, JSON.stringify(current_product));
                    }
                }); 
             }
                    /*---------進入兩地距離計算，判斷式---------*/
                    // if(i == 0){
                    //     start = {lat : lat, lng: lng};
                    //     return;
                    // }
                    // if($(value).attr("data-sort") == 0 && i > 0){
                    //     start = {lat : lat, lng: lng};
                    //     return;
                    // }else{
                    //     end = {lat : lat, lng: lng};
                    // }
                    // let directionsService = new google.maps.DirectionsService;
                    // directionsService.route({
                    //         origin: start, // Note that Javascript allows us to access the constant
                    //         destination: end, // using square brackets and a string value as its"property."
                    //         optimizeWaypoints: false,
                    //         travelMode: google.maps.TravelMode['DRIVING']
                    //     }, function (response, status) {
                    //         if (status == 'OK') {
                    //             let legs = response.routes[0].legs;
                    //             let distance = parseFloat(legs[0].distance.text);
                    //             $("li#"+product_id).find("span#km").html(distance);
                    //             callback();
                    //         } else {
                    //             console.log('Directions request failed due to ' + status);
                    //         }
                    //     });
                    //     start = {lat : lat, lng: lng};                    //這必須放在 directionsService 外，不然會來不及給數值(應該是ajax緣故)
              
            /*----------------------------將每天的sessionStorage取出計算兩地距離，並計算單日總里程，無路線--------------------------------*/
            function calculateDistance_and_totalKm(){
                var directionsService = new google.maps.DirectionsService;
                let object_keys = Object.keys(sessionStorage).sort();
                $.each(object_keys, function (i, value) {
                    let start = "";
                    let end = "";
                    let waypts = [];
                    let product_id = [];
                    let day_km = 0;
                    let data = JSON.parse(sessionStorage.getItem(value)); //將value一個一個取出
                    $.each(data, function(j, items){
                        let lat = items.lat;
                        let lng = items.lng;
                        product_id.push(items.product_id);
                        if(j == 0){
                            start = {lat : lat, lng: lng};
                            return;
                        }else if(j == (data.length - 1)){
                            end = {lat:lat, lng:lng};
                        }else{
                            let temp = {
                                        location: {lat:lat, lng:lng},     //使用者選的地點經緯度
                                        stopover: true                    
                                        }
                            waypts.push(temp);     
                        }
                    });
                    directionsService.route({
                        origin: start, // Note that Javascript allows us to access the constant
                        destination: end, // using square brackets and a string value as its"property."
                        waypoints: waypts,
                        optimizeWaypoints: false,
                        travelMode: google.maps.TravelMode['DRIVING']
                    }, function (response, status) {
                        if (status == 'OK') {
                            let legs = response.routes[0].legs;
                            for(let i = 0; i < legs.length; i++){
                                let distance = parseFloat(legs[i].distance.text);
                                $("li#"+product_id[i+1]).find("span#km").html(distance);  //id設定為product_id+天數，以便分日
                                day_km += distance;
                            }
                            $("div#"+value).find("span.total_km").html(day_km.toFixed(1));
                        } else {
                            console.log('Directions request failed due to ' + status);
                        }
                    });
                });
            }

            //     function calculateDistance(){
            //     var directionsService = new google.maps.DirectionsService;
            //     let object_keys = Object.keys(sessionStorage).sort();
            //     let start;
            //     let end;
            //     $.each(object_keys, function (i, value) {
            //         start = "";
            //         end = "";
            //         let data = JSON.parse(sessionStorage.getItem(value)); //將value一個一個取出
            //         $.each(data, function(i, items){
            //             let lat = data[i].lat;
            //             let lng = data[i].lng;
            //             let product_id = data[i].product_id;
            //             let data_length = data.length;
            //             if(i == 0 && data[i].sort == "0"){
            //                 start = {lat : lat, lng: lng};
            //                 return;
            //             }else{
            //                 end = {lat : lat, lng: lng};
            //             }
            //         directionsService.route({
            //                 origin: start, // Note that Javascript allows us to access the constant
            //                 destination: end, // using square brackets and a string value as its"property."
            //                 optimizeWaypoints: false,
            //                 travelMode: google.maps.TravelMode['DRIVING']
            //             }, function (response, status) {
            //                 if (status == 'OK') {
            //                     let legs = response.routes[0].legs;
            //                     distance = parseFloat(legs[0].distance.text); 
            //                     $("li#"+product_id).find("span#km").html(distance);
            //                 } else {
            //                     console.log('Directions request failed due to ' + status);
            //                 }
            //             });
            //             start = {lat : lat, lng: lng};
            //         });
            //     });
            // }



        });
    </script>
</body>

</html>