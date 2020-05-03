<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>방 명 록</title>

<script type="text/javascript">
$(function(){
	init();
});


	
	function init() {

		$.ajax({
			method : 'GET',
			url : 'getAll',
			success : output,
			error : function(resp) {
				alert("Error");
			}
		})

	};
	function output(resp) {
		var nickname = "${sessionScope.username}";
		var data = ' <table class="table"><thead><tr><th>번호</th><th>작성자</th><th>내용</th><th>일자</th></tr></thead><tbody>';
				$.each(resp,
						function(index, item) {
					
							data += '<tr><td width="20%">' + item.seqno + '</td>'
							data += '<td width="20%">';
							if (item.savedfilename!=null) {
								data += '<img src="<c:url value="/imgs/'+item.savedfilename+'"/>" width="25px" height="25px"/>'
							} else {
								data +='<img src="/personal/resources/images/userdefalut.png" width="25px" height="25px"/>'
								
							}
							data += item.guestname + '</td>'
							data += '<input type="hidden" value="'+item.text+'">'
							data +='<td>'+ item.text+'</td><td>' ;
							data += '<td width="20%">'+item.regdate+'</td>'

							if (nickname == item.guestname) {
								data += '<td><input type="button" class="deletequest" data-num="'+item.seqno+'" value="삭제" >';
							}
							data += '</td></tr>'
						})
		data += '</tbody></table>';

		$("#questlist").html(data);
		$(".deleteqvuest").on("click",function(){
			var seqno = $(this).attr('data-num');
		 	$.ajax({
				method : 'GET',
				url : 'deletequest',
				data : {
					"seqno" : seqno
				},
				success : function(resp) {
					
						alert("삭제 성공");
						init();
				},
				error : function() {
					alert("에러 에러");
				}
			})
		});
		/* $(".replyUpdate").on('click', replyUpdate); */

	}
</script>
<style type="text/css">
div#bgmMusic {
	width: 50%;
	font-size: 13pt;
}
#wrapper {
	background: url(resources/images/teemo.jpg) no-repeat right
		center fixed;
/* 	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover; */
}
.table {
	width: 70%;

	
}
h2{
text-align: center;
}
</style>
</head>
<body>
	<div id="wrapper">
		<div id="bgmMusic">
			음악🎵
			<audio src="resources/audio/homepageMainBgm.mp3" controls id="ap"
				style="height: 25px;">
			</audio>
		</div>

	
		<div id="homereturner">
			<c:url var="home" value="resources/images/homeimg.png"></c:url>
			<c:url var="root" value="/"></c:url>
			<a href="${root}"><img src="${home}" width="30px"></a>
		</div>
		<h2>[ 방 명 록 ]</h2>



<div id="questlist"></div>
				<c:if test="${not empty sessionScope.username}">
			<form action="registGuestbook" method="POST">
				<input type="hidden" value="${sessionScope.username}" id=guestname
					name="guestname"> <input type="hidden"
					value="${sessionScope.userimgs}" id="savedfilename"
					name="savedfilename">
				<table class="table">
					<thead>
						<tr>
							<th style="text-align: left;"><c:if
									test="${not empty sessionScope.userimgs}">
									<img src="<c:url value='/imgs/${sessionScope.userimgs}'/>"
										width="50px" height="30px" />
								</c:if> <c:if test="${empty sessionScope.userimgs}">

									<img src="<c:url value='/resources/images/userdefalut.png'/>"
										width="50px" height="30px" />
								</c:if> ${sessionScope.username} 님 반갑습니다. 남기고 싶은말을 입력해주세요</th>
						</tr>
						<tr>

							<th><textarea rows="3" cols="130" name="text"></textarea></th>
						</tr>
						<tr>
							<th colspan="2"><input type="submit" value="등록"> <input
								type="reset" value="리셋"></th>
						</tr>
					</thead>
				</table>
			</form>
		</c:if>
</div>
</body>
</html>