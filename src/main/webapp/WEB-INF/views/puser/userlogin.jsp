<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이제 로그인을 할꺼야</title>
<script src="resources/js/jquery-3.4.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}
/* style the container */
.container {
	position: relative;
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px 0 30px 0;
	text-align: center;
}

/* style inputs and link buttons */
input, .btn {
	width: 40%;
	padding: 12px;
	border: none;
	border-radius: 4px;
	margin: 5px 0;
	opacity: 0.85;
	display: inline-block;
	font-size: 17px;
	line-height: 20px;
	text-decoration: none; /* remove underline from anchors */
	
}

input:hover, .btn:hover {
	opacity: 1;
}

/* add appropriate colors to fb, twitter and google buttons */

/* style the submit button */
input[type=submit] {
	background-color: #4CAF50;
	color: white;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

/* Two-column layout */
.col {
	float: left;
	width: 50%;
	margin: auto;
	padding: 0 50px;
	margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/* vertical line */
.vl {
	position: absolute;
	left: 50%;
	transform: translate(-50%);
	border: 2px solid #ddd;
	height: 175px;
}

/* text inside the vertical line */
.vl-innertext {
	position: absolute;
	top: 50%;
	transform: translate(-50%, -50%);
	background-color: #f1f1f1;
	border: 1px solid #ccc;
	border-radius: 50%;
	padding: 8px 10px;
}

/* hide some text on medium and large screens */
.hide-md-lg {
	display: none;
}

/* bottom container */
.bottom-container {
	text-align: center;
	background-color: #666;
	border-radius: 0px 0px 4px 4px;
}

/* Responsive layout - when the screen is less than 650px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 650px) {
	.col {
		width: 100%;
		margin-top: 0;
	}
	/* hide the vertical line */
	.vl {
		display: none;
	}
	/* show the hidden text on small screens */
	.hide-md-lg {
		display: block;
		text-align: center;
	}
	div#homereturner{
	
	width: 20%;
	}
}
</style>
<c:if test="${not empty error}">
	<script type="text/javascript">
		alert('${error}')
	</script>
</c:if>
	<script>

	
	$(function(){
			$("#loginbutton").on("click",function(){
			
				var useremail = $("#useremail").val();
				 if(useremail.trim().length < 1  ){
					alert("이메일을 입력해주세요");
					return ;//이메일 확인하는거 가져오기
				} 

				var userpwd = $("#userpwd").val();
				if(userpwd.trim().length < 3 || userpwd.trim().length >15 ){
					alert("비밀번호 3~15글자 입력");
					return ;
				}
				var loginUserForm = $("#loginUserForm");
				loginUserForm.submit();
			
				});

			
		});

	

		
	</script>

</head>
<body>

	<h2>Responsive 로 그 인</h2>
	
			<div id = "homereturner">
			<c:url var="home" value="resources/images/homeimg.png"></c:url>
			<c:url var="root" value="/"></c:url>
			<a href="${root}"><img src="${home}" width="30px"></a>
			</div>
	<p>Resize the browser window to see the responsive effect. When the
		screen is less than 650px wide, make the two columns stack on top of
		each other instead of next to each other.</p>

	<div class="container">
		<form  id="loginUserForm" action="loginAct" method="POST">
			<div class="row">
 		<div class="hide-md-lg">
          <p>Or sign in manually:</p>
        </div>
				<input type="text" name="useremail" id="useremail"
				value="" placeholder="email을 입력해주세요"
				required >
				
				<br>
				<input type="password" name="userpwd" id="userpwd"
					placeholder="3~5글자이상 입력" required> 
					<br>
					<input type="submit" id="loginbutton" value="Login"> 	
			</div>

		</form>
	</div>


	
	

	<div class="bottom-container">
		<div class="row">
			<div class="col">
				<a href="join" style="color: white" class="btn">Sign up</a>
			</div>
			<div class="col">
				<a href="" style="color: white" class="btn">Forgot password? 구현중</a>
			</div>
		</div>
	</div>
</body>
</html>