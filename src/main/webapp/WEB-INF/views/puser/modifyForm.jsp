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
		var uploadtxt = document.getElementById("upload").value;
		
		var check ="N";
		if (uploadtxt.endsWith('.jpg')||uploadtxt.endsWith('.png')||uploadtxt.endsWith('.gif')) {
			check="Y";
		}	

		if(uploadtxt==""){
			var welcomeForm = document.getElementById("welcomeForm");
			welcomeForm.action='modifypUser';
			
			welcomeForm.submit();

			}									
		if(check =="N"){
			document.getElementById("upload").select();
			return;
			}
		var welcomeForm = document.getElementById("welcomeForm");
	
		welcomeForm.submit();

	}
	$(function(){
		$("#username").on("keyup",function(){
			var username=$("#username").val();

			if(username.trim().length < 3 || username.trim().length >8){
						$("#idcheck").css("color","red");	
						$("#idcheck").text("아이디를 3-8글자로 입력해주세요");
						return;
						
				}
							$("#idcheck").text('');

							$.ajax({
					//입력한 아이디가 사용가능한지 여부
							type : 'GET'
							,url : "idCheck"
							, data : {"username" : username}
							,success : function(resp) {

							if(resp=='success'){
					$("#idcheck").css("color","blue");
						$("#idcheck").text("사용가능한 아이디입니다.");
											}
										else{
									$("#idcheck").css("color","red");
									$("#idcheck").text("사용 불가능한 아이디입니다.");
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
		<h1>회원 정보 수정</h1>
		<p>정보 확인후 수정해주세요</p>
		<hr>

		<form id="welcomeForm" action="modifyUser" method="POST" enctype="multipart/form-data">
			<label for="upload"> 프로필 사진 입력</label>
			<input type="file" value="프로필사진 첨부" name="upload" id="upload" /><br>
			
			<label for="useremail"><b>이메일 작성</b></label>
			<input type="text" id="useremail" name="useremail" value="${temppuser.useremail}"  readonly="readonly"required> 
			<label for="username"> 닉네임 입력 <span id="idcheck"></span></label>
			<input type="text" name="username" id="username"  value="${temppuser.username}">
			<label for="userpwd"><b>비밀번호</b></label> 
			<input type="password"  id="userpwd" name="userpwd" required>
			<label for="custpwd2"><b>비밀번호 확인</b></label> 
			<input type="password" id="custpwd2" required> 
			
			<hr>

			<button type="button" class="registerbtn" onclick="formcheck()">정보수정</button>
			<button type="reset" class="registerbtn">취소</button>
			 </form>
			
			
	</div>

</body>
</html>