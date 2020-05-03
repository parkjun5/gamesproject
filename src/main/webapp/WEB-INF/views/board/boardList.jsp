
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
#wrapper {
	background: url(resources/images/backgroundimgss.png) no-repeat center
		center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

}
a {
	text-decoration: none;
	color: black;
}

btn-toolbar {
	margin-left: 600px;
}

div#bgmMusic {
	width: 50%;
	font-size: 13pt;
}
</style>
</head>
<body>

	<div id="wrapper">
		<div id="homereturner">
			<c:url var="home" value="resources/images/homeimg.png"></c:url>
			<c:url var="root" value="/"></c:url>
			<a href="${root}"><img src="${home}" width="30px"></a>
		</div>
		<div id="bgmMusic">
			음악🎵
			<audio src="resources/audio/homepageMainBgm.mp3" controls id="ap"
				style="height: 25px;">
			</audio>
		</div>

		<div class="container">

			<h2 style="color: white;">자유 게시판 입니다</h2>
			<h4 style="color: white;">게임과 관련된 게시물을 작성해주세요</h4>
			<nav class="navbar navbar-expand-sm bg-white navbar-dark">
				<div class="container" style="margin: auto;">
					<span> <c:if test="${not empty sessionScope.userimgs}">
							<img src="<c:url value='/imgs/${sessionScope.userimgs}'/>"
								width="50px" height="30px" />
						</c:if> <c:if test="${empty sessionScope.userimgs}">

							<img src="<c:url value='/resources/images/userdefalut.png'/>"
								width="50px" height="30px" />
						</c:if> <c:if test="${not empty sessionScope.custname}">
					${sessionScope.custname}님반갑습니다.
				</c:if> <c:if test="${empty sessionScope.custname}">
					이용자님 반갑습니다.
				</c:if></span>
					<form class="form-inline" id="search" action="mainBoard"
						method="get">
						<select name="searchItem">
							<option value="title" ${searchItem=='title'?'selected' : ''}>제목</option>
							<option value="writer" ${searchItem=='writer'?'selected' : ''}>글쓴이</option>
						</select> <input type="text" name="searchWord" />
						<button class="btn btn-success" type="submit">Search</button>
						<a href="boardWrite"><input class="btn btn-success"
							type="button" value="글쓰기" /></a>
					</form>

				</div>


			</nav>
			<table class="table table-dark" id="tabling">
				<thead>
					<tr>
						<th>번호</th>
						<th>글제목</th>
						<th>글쓴날</th>
						<th>글쓴이</th>
						<th>조회수</th>
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
		<br />
		<div class="container">
			<div class="btn-toolbar ">
				<div class="mx-auto">
					<div class="btn-group">
						<a
							href="mainBoard?searchItem=${searchItem}&searchWord=${searchWord}&currentPage=${navi.currentPage-navi.pagePerGroup}"
							style="color: black; text-decoration: none;">
							<button type="button" class="btn btn-secondary">◀◀</button>
						</a> &nbsp; <a
							href="mainBoard?searchItem=${searchItem}&searchWord=${searchWord}&currentPage=${navi.currentPage-1}"
							style="color: black; text-decoration: none;">
							<button type="button" class="btn btn-secondary">◁</button>
						</a> &nbsp;
					</div>
					<div class="btn-group">
						<c:forEach var="currentPage" begin="${navi.startPageGroup}"
							end="${navi.endPageGroup}">
							<c:if test="${navi.currentPage==currentPage}">

								<button type="button" class="btn btn-secondary">
									<span style="font-weight: bold; color: yellow;">${currentPage}</span>
								</button>
							</c:if>
							<c:if test="${navi.currentPage!=currentPage}">

								<a
									href="mainBoard?searchItem=${searchItem}&searchWord=${searchWord}&currentPage=${currentPage}"
									style="color: blue; text-decoration: none;"><button
										type="button" class="btn btn-secondary">${currentPage}</button></a>
							</c:if>
						</c:forEach>
						<div class="btn-group">

							&nbsp;<a
								href="mainBoard?searchItem=${searchItem}&searchWord=${searchWord}&currentPage=${navi.currentPage+1}"
								style="color: black; text-decoration: none;">
								<button type="button" class="btn btn-secondary">▷</button>
							</a> &nbsp; <a
								href="mainBoard?searchItem=${searchItem}&searchWord=${searchWord}&currentPage=${navi.currentPage+navi.pagePerGroup}"
								style="color: black; text-decoration: none;">
								<button type="button" class="btn btn-secondary">▶▶</button>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>