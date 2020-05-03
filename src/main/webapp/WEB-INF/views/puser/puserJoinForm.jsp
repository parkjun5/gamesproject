<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
	background-color: black;
}

* {
	box-sizing: border-box;
}

/* Add padding to containers */
.container {
	padding: 16px;
	background-color: white;
}

/* Full-width input fields */
input[type=text], input[type=password] {
	width: 100%;
	padding: 15px;
	margin: 5px 0 22px 0;
	display: inline-block;
	border: none;
	background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
	background-color: #ddd;
	outline: none;
}

/* Overwrite default styles of hr */
hr {
	border: 1px solid #f1f1f1;
	margin-bottom: 25px;
}

/* Set a style for the submit button */
.registerbtn {
	background-color: #4CAF50;
	color: white;
	padding: 16px 20px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 100%;
	opacity: 0.9;
}

.registerbtn:hover {
	opacity: 1;
}

/* Add a blue text color to links */
a {
	color: dodgerblue;
}

/* Set a grey background color and center the text of the "sign in" section */
.signin {
	background-color: #f1f1f1;
	text-align: center;
}
</style>
<script type="text/javascript">
	function formcheck() {

		
		var userpwd = document.getElementById("userpwd").value;
		if (userpwd.trim().length < 3 || userpwd.trim().length > 15) {
			document.getElementById("userpwd").select();
			return;
		}
		var custpwd2 = document.getElementById("custpwd2").value;
		if (userpwd !== custpwd2) {
			document.getElementById("custpwd2").select();
			return;
		}

		var username = document.getElementById("username").value;
		if (username.trim().length <2) {
			document.getElementById("username").select();
			return;
		}
		var useremail = document.getElementById("useremail").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

				if(exptext.test(useremail)==false){

			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
			alert("이 메일형식이 올바르지 않습니다.");
			document.getElementById("useremail").select();
			document.addjoin.email.focus();
			return ;

		}

		var welcomeForm = document.getElementById("welcomeForm");
		welcomeForm.submit();
		alert("이메일 인증 후에 로그인 하실수 있습니다!");

	}
	$(function() {
		$("#username").on("keyup", function() {
			var username = $("#username").val();

			if (username.trim().length < 3 || username.trim().length > 8) {
				$("#idcheck").css("color", "red");
				$("#idcheck").text("아이디를 3-8글자로 입력해주세요");
				return;

			}
			$("#idcheck").text('');

			$.ajax({
				//입력한 아이디가 사용가능한지 여부
				type : 'GET',
				url : "idCheck",
				data : {
					"username" : username
				},
				success : function(resp) {

					if (resp == 'success') {
						$("#idcheck").css("color", "blue");
						$("#idcheck").text("사용가능한 아이디입니다.");
					} else {
						$("#idcheck").css("color", "red");
						$("#idcheck").text("사용 불가능한 아이디입니다.");
					}
				}
			});
		});

		$("#useremail").on("keyup", function() {
			var useremail = $("#useremail").val();

			$.ajax({
				type : 'GET',
				url : "useremailCheck",
				data : {
					"useremail" : useremail
				},
				success : function(resp) {

					if (resp == 'success') {
						$("#emailcheck").css("color", "blue");
						$("#emailcheck").text("사용가능한 이메일입니다..");
					} else {
						$("#emailcheck").css("color", "red");
						alert("이미 존재하는 이메일입니다.")
						$("#emailcheck").text('중복메일을 입력하셧습니다.');
						$("#useremail").val('');
						
					}
				}
			});
		});

	});
</script>
<style type="text/css">
#wrapper {
	margin-top: 150px;
	margin-left: 450px;
}
</style>

</head>
<body>
	<div class="container">
	<div id = "homereturner">
			<c:url var="home" value="resources/images/homeimg.png"></c:url>
			<c:url var="root" value="/"></c:url>
			<a href="${root}"><img src="${home}" width="30px"></a>
			</div>
		<h1>회원가입</h1>
		<p>계정을 만들기 위해 다음의 정보를 입력해주세요!</p>
		<hr>
		<form id="welcomeForm" action="puserjoin" method="POST" >
			<label for="useremail"><b>이메일 작성</b> <span id="emailcheck"></span></label>
			<input type="text" placeholder="이메일을 작성해주세요" id="useremail"
				name="useremail" required> <label for="username">
				닉네임 입력 <span id="idcheck"></span>
			</label> <input type="text" name="username" id="username"
				placeholder="닉네임을 정해주세요 (8자리 이내)"> <label for="userpwd"><b>비밀번호</b></label>
			<input type="password" placeholder="비밀번호를 3~10자이내로 입력하세요"
				id="userpwd" name="userpwd" required> <label for="custpwd2"><b>비밀번호
					확인</b></label> <input type="password" placeholder="비밀번호 일치시켜주세요" id="custpwd2"
				required>

			<hr>

			<button type="button" class="registerbtn" onclick="formcheck()">가입</button>
			<button type="reset" class="registerbtn">취소</button>
		</form>
		<div class="container signin">

			<p>
				Already have an account? <a href="userlogin">LOGIN in</a>.
			</p>
		</div>

	</div>

</body>
</html>