<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JSTL 의 core 기능을 사용하기 위한 설정 : if, forEach, set 사용 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring Board</title>
<!-- 현재 기기의 너비에 맞추어서 출력을 하고
기본 크기는 1배 최대 크기도 1배 확대축소 못하게 하는 설정
모바일 웹 애플리케이션에서 주로 이용 -->
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>

<!-- 부트스트랩 스타일시트 파일 링크 설정
contextPath는 절대 경로를 만들기 위해서 추가 -->
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<!-- IE 9 이전 버전에서 HTML5의 semantic 태그를
사용하기 위한 설정 -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.comrespond/1.4.2respond.min.js"></script>
    <![endif]-->

</head>
<!-- jQuery 설정 -->

<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<header class="main-header">
			<div class="page-header">

				<input type="text" id="search01" name="search"
					placeholder="제품/매장 검색 예)치즈, 딸기, 역삼" title="매장 또는 제품명을 입력하세요."
					hname="검색어" minbyte="1" required="Y" errmsg="매장 또는 제품명을 입력하세요.">
				<button type="submit">
					<img
						src="${pageContext.request.contextPath}/resources/userimage/a2.png">
				</button>
				<h1>
					<div class="text-center">
						<img
							src="${pageContext.request.contextPath}/resources/userimage/a1.png">
				</h1>
			</div>
		</header>
	</div>


	<aside class="main-sidebar">
		<section class="sidebar">
			<ul class="nav nav-tabs">

				<li role="presentation" class="active"><a href="#">제품안내</a></li>
				<li role="presentation"><a
					href="${pageContext.request.contextPath}/board/list">매장찾기</a></li>
				<li role="presentation"><a
					href="${pageContext.request.contextPath}/board/register">마이페이지</a></li>
				<c:if test="${user == null }">
					<li role="presentation"><a
						href="${pageContext.request.contextPath}/user/register">회원가입</a></li>
				</c:if>
				<c:if test="${user != null}">
					<li role="presentation"><img
						src="${pageContext.request.contextPath}/userimage/${user.image}"
						width="50" height="50" /> ${user.nickname}님</li>
				</c:if>
			</ul>
		</section>
	</aside>
	<div>