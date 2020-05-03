<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
 <div>
 <span style="color: green; font-weight: bold;">이메일 인증 (이메일을 인증 받아야 다음 단계로 넘어갈 수 있습니다.)</span> <br> <br>    
	   
	<table border="1" width="300" height="300" align= "center">
	            <tr>        
	                <td>
	                    <form action="auth.do" method="post">
	      
	                        <br>
	                        <div>
	                            이메일 : <input type="email" name="e_mail"
	                                placeholder="  이메일주소를 입력하세요. ">
	                        </div>                                                    
	 
	                        <br> <br>
	                        <button type="submit" name="submit">이메일 인증받기 (이메일 보내기)</button>
	 
	                        </div>
	                    </td>
	                </tr>
	                  
	            </table>
        </form>

 </div>
</body>
</html>
