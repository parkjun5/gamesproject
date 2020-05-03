
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <!--  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script> -->

<style type="text/css">


/* div#wrapper {
	background: url(resources/images/totoro2.jpg) no-repeat center center
		fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
} */
}
h2 {
	align-self: center;
}

pre {
	width: 500px;
	height: 300px;
}
</style>
<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : 'content',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR'
		});
		$('#summernote').summernote('code', '${board.content}');
		$('#summernote').summernote('disable');
	});
	function deleteBoard() {

		var chk = confirm("정말 삭제하시겠습니까?");
		if (chk) {
			document.getElementById("delData").value = ${board.boardno};
			document.getElementById("delForm").submit();
		}
	}
	$(function() {
		init();
		$("#replyControl").on('click', replySend);
	});
	function init() {
		var boardno = ${board.boardno};

		$.ajax({
			method : 'GET',
			url : 'replyAll',
			data : {
				"boardno" : boardno
			},
			success : output,
			error : function(resp) {
				alert("Error");
			}
		})

	}

	function output(resp) {
		var nickname = "${sessionScope.username}";
		var data = '   <table class="table table-dark"><thead><tr><th>입력일시</th><th>아이디</th><th>댓글내용</th></tr></thead><tbody>';
				$.each(resp,
						function(index, item) {
							data += '<tr><td>' + item.regdate + '</td>'
							data += '<td>';
							if (item.savedfilename!=null) {
								data += '<img src="<c:url value="/imgs/'+item.savedfilename+'"/>" width="25px" height="25px"/>'
							} else {
								data +='<img src="/personal/resources/images/userdefalut.png" width="25px" height="25px"/>'
								
							}
							data += item.writer + '</td>'
							data += '<input type="hidden" value="'+item.replytext+'">'
							data +='<td>'+ item.replytext+'</td><td>' ;

							if (nickname == item.writer) {
								data += '<input type="button" name ="replyno" data-num = "'+  item.replyno+'" class="replyDelete" value="댓글 삭제" style="color: black;">'
								data += '<input type="button" name ="replyno" data-num= "'+ item.replyno+'" data-text="'+item.replytext+'" class="replyUpdate" value="댓글 수정" style="color: black;">'
							}
							data += '</td></tr>'
						})
		data += '</tbody></table>';

		$("#replyResult").html(data);
		$(".replyDelete").on('click', replyDelete);
		$(".replyUpdate").on('click', replyUpdate);

	}

	function replyUpdate() {

		var replyno = $(this).attr("data-num");
		var replytext = $(this).attr("data-text");
		$("#replyControl").attr("data-num", replyno);

		$("#replytext").val(replytext);
		$("#replyControl").val('댓글수정');

	}
	//수정과 입력을 동시에 처리할것이다.
	function replySend() {
		var replyno = $(this).attr("data-num");
		if (replyno == ""){
			replyno = 0;
		}
		var replytext = $("#replytext").val();
		var boardno = ${board.boardno};
		var status = ($("#replyControl").val() == "댓글수정") ? "replyUpdate"
				: "replyWrite";
		var savedfilename = $("#getUserimgs").val();
		//, async : false 비동기 통신 을 못하게 동기통신으로 만듬
		if (status == 'replyUpdate') {
			var sendData = {
				"replyno" : replyno,
				"replytext" : replytext,
				"boardno" : boardno,
				"savedfilename" : savedfilename
			};
			$.ajax({
				method : "POST",
				url : status,
				data : sendData,
				success : function(resp) {
					if (resp == 'success') {
						alert("댓글수정완료");
						init();
						$("#replytext").val("");
						$("#replyControl").val("댓글달기");
					} else {
						alert("댓글수정실패")
					}
				}
			});

		} else {
			var sendData = {
				"replyno" : replyno,
				"replytext" : replytext,
				"boardno" : boardno,
				"savedfilename" : savedfilename
			};
			$.ajax({

				method : "POST",
				url : status,
				data : sendData,
				success : function(resp) {
					if (resp == 'success') {
						alert("작성");
						init();
						$("#replytext").val("");
					} else {
						alert("작성실패")
					}
				}
			});

		}
	}

	function replyDelete() {

		//ajax 기능을 이용해서 삭제하고자 하는 데이터를 보냄
		//replyno + boardno서버 전ㅅㅇ
		//reply no 의 값을 가져오기 위해서는 ajax의 사용자 정의 attribute를 사용한다.
		var replyno = $(this).attr('data-num');
		var boardno = ${board.boardno};

		var sendData = {
			"boardno" : boardno,
			"replyno" : replyno
		};

		$.ajax({
			method : 'GET',
			url : 'replyDelete',
			data : sendData,
			success : function(resp) {
				if (resp == 'success') {
					alert("삭제 성공");
					//전체 댓글다시 불러온다.
					init();
				} else
					alert('삭제 실패')
			},
			error : function() {
				alert("에러 에러");
			}
		})

	}
</script>
<style type="text/css">
#wrapper {
	background: url(resources/images/backgroundimgss.png) no-repeat center
		center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
	color: white;
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
	<!-- 데이터 삭제를 위한 폼 -->
	<form id="delForm" action="deleteBoard" method="get">
		<input type="hidden" value="" id="delData" name="boardno" />
	</form>
	<h2 style="text-align: center;">글 자세히 보기</h2>
	<div style="width: 60%; margin: auto;">
		<form method="post" action="/write"> 
		<span>작성자 :
			
			 ${board.writer}<br> 글제목 :${board.title}</span>
		
			<c:if test="${sessionScope.username==board.writer}">
				<a href="boardUpdate?boardno=${board.boardno}"><input
					type="button" value="수정"></a>
				<input type="button" style="color: red;" value="삭제" onclick="deleteBoard()">
			</c:if>
			<textarea id="summernote" name="content"></textarea>
			<div id="resultboard"></div>




		</form>
	</div>
	<br>
	<!-- 댓글 폼 영역  -->
	<div id="wrapper">
		<div id="replyForm" style="text-align: center;">
			<c:if test="${not empty username}">
				<form action="replyWrite" method="POST">
					<input type="hidden" name="writer" value="${sessionScope.username}">
					<input type="hidden" name="getUserimgs" id="getUserimgs" value="${sessionScope.userimgs}">
					<span id="usernameget">
					작성자 : 
					<c:if
					test="${not empty sessionScope.userimgs}">
					<img src="<c:url value='/imgs/${sessionScope.userimgs}'/>"
						width="50px" height="30px" />
				</c:if> <c:if test="${empty sessionScope.userimgs}">
					<img src="<c:url value='/resources/images/userdefalut.png'/>"
						width="50px" height="30px" />
				</c:if>
					${sessionScope.username}
					</span> <input type="text" id="replytext"
						value="댓글 입력" name="replytext" style="width: 575px; height: 50px; color: black;">
					<input id="replyControl" name="replyControl" data-num=""
						type="button" value="댓글달기" style="color: black;"> <input type="hidden"
						id="replyno" name="replyno" value="0">
				</form>
			</c:if>

		</div>
		<!-- 댓글 목록 출력 -->

		

	</div>
	<div id="replyResult" style="width: 60%; margin: auto; "></div>
</div>
</body>
</html>