<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<!-- calendar를 위한 라이브러리들 지우면 안됨 -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script
	src='https://fullcalendar.io/releases/fullcalendar/3.9.0/lib/moment.min.js'></script>
<link
	href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css'
	rel='stylesheet' />
<link
	href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.print.css'
	rel='stylesheet' media='print' />
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>


<script type="text/javascript">
	function modifypuser() {
		var userpwd = prompt("비밀번호를 입력하세요");
		document.getElementById("usernameConfirm").value = "${sessionScope.username}";
		document.getElementById("userpwdConfirm").value = userpwd;
		document.getElementById("pwdcheck").submit();
	}
	$(document).ready(function() {
		$('#calendar').fullCalendar({
			header : {
				right : 'custom2 prevYear,prev,next,nextYear'

			},
			// 달력 정보 가져오기 
			eventSources : [ {
				// ajax 통신으로 달력 정보 가져오기 
				// GET "/users/attendances" -> {dateList:[ date: "2016-03-21", ... ]}
				color : 'purple',
				textColor : 'white'
			} ]

		});
	});

	
</script>
<style type="text/css">
div#bgmMusic {
	width: 50%;
	font-size: 13pt;
}

div.left {
	width: 30%;
	float: left;
	box-sizing: border-box;
}

div.right {
	width: 70%;
	float: right;
	box-sizing: border-box;
}
</style>

</head>
<body>
	<div class="jumbotron" style="margin-bottom: 0">
		<div id="bgmMusic">
			bgm🎵
			<audio src="resources/audio/homepageMainBgm.mp3" controls id="ap"
				style="height: 25px;">
			</audio>
		</div>
		<h2 style="font-weight: bolder; text-align: center;">ゲーム情報掲示板</h2>
	</div>




	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<c:if test="${sessionScope.username!=null}">
			<a href="logout" class="navbar-brand">ログアウト</a>
		</c:if>
		<c:if test="${empty sessionScope.username}">
			<a href="userlogin" class="navbar-brand">로그인</a>


		</c:if>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">

			<c:if test="${empty sessionScope.username}">

				<a class="navbar-brand" href="join">회원가입</a>
			</c:if>
			<c:if test="${sessionScope.username!=null}">
				<a class="navbar-brand" onclick="modifypuser()">情報修正</a>
			</c:if>
			<a class="navbar-brand" href="guestbook">芳名録</a> <a
				class="navbar-brand" href="chat">フリーチャットルーム</a> <a
				class="navbar-brand" href="mainBoard">掲示板</a> <a
				class="navbar-brand" href="boardWrite">サマーノート</a> <a
				class="navbar-brand" style="color: yellow;">今週の人気文!</a>
			<form method="get" action="http://www.op.gg/summoner/"
				target="_blank">
				<table>
					<tr>

						<td><input type="text" name="userName" size="25"
							maxlength="25" value="" placeholder="op.gg 検索する"
							style="float: left; height: 45px;" /> <input type="image"
							src="<c:url value='/resources/images/op.gg.png'/>"
							style="width: 50px; height: 45px;"></td>
					</tr>
				</table>
			</form>
		</div>



		<c:if test="${not empty sessionScope.userimgs}">
			<img src="<c:url value='/imgs/${sessionScope.userimgs}'/>"
				width="50px" height="30px" />
		</c:if>
		<c:if test="${empty sessionScope.userimgs}">

			<img src="<c:url value='/resources/images/userdefalut.png'/>"
				width="50px" height="30px" />
		</c:if>
		<c:if test="${not empty sessionScope.username}">
			<a class="navbar-brand">${sessionScope.username}お会いできて嬉しいです。</a>
		</c:if>
		<c:if test="${empty sessionScope.username}">
			<a class="navbar-brand">이용자님 반갑습니다.</a>
		</c:if>

	</nav>

	<!-- bgm 요망 -->
	<div class="left">
		<div class="container calendar-container">
			<div id="calendar" style="max-width: 500px"></div>
			<div id="data"></div>
		</div>
	</div>
	<div class="right">
		<table class="table table-dark" id="tabling">
			<thead>
				<tr>
					<th>番号</th>
					<th>文題</th>
					<th>書き物日</th>
					<th>書き手</th>
					<th>アクセス数</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${boardList}" varStatus="stat">
					<tr>
						<td width="150px">${stat.count+navi.startRecord}</td>

						<td align="left" width="500px"><input type="image"
							src="resources/images/paw.png" width="15px"> <a
							href="boardDetail?boardno=${board.boardno}&currentPage=${navi.currentPage}&searchItem=${searchItem}&searchWord=${searchWord}">
								<span style="color: white;">${board.title}</span>
						</a> <c:forEach var="key" items="${map}">
								<c:if test="${key.key==board.boardno}">
									<span style="color: red; font-size: 7pt;"> ${key.value}</span>
								</c:if>
							</c:forEach></td>
						<td>${board.regdate}</td>
						<td>${board.writer}</td>
						<td>${board.hitcount}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<!-- 비밀번호 체크용 폼 -->
	<form id="pwdcheck" action="modifyConfirmCustomer" method="POST">
		<input type="hidden" value="" id="usernameConfirm"
			name="usernameConfirm"> <input type="hidden" value=""
			id="userpwdConfirm" name="userpwdConfirm">
	</form>

</body>
</html>