<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
  src="http://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<style>
	html{
		height: 100%;
	}
	body {
		height: 100%;
		display: flex;
		flex-direction: column;
		align-items: center; 
		justify-content: center;
	}

	.btns{
		display: flex;
		justify-content: space-between;
	}

</style>

<script>

	function login(){
		
		var email = document.getElementById('email').value;
		var password = document.getElementById('password').value;
		
		$.ajax({
			url: "/myapps/access",
			type: "POST",
			data: {
				email: email,
				password: password
			},
			success: function(data){
				if(data==="success"){
					alert("로그인 성공");
					location.href="/myapps";
				} else{
					alert("로그인 실패");
				}
			},
			error: function(request, status, error){
				alert("로그인 실패");
			}
		})
	}
</script>

</head>
<body>
	<h1>로그인</h1>
	
	<div>
		<input id="email" type="email"/>
	</div>
	
	<div>
		<input id="password" type="password"/>
	</div>
	
	<div class="btns">
		<button onclick="login();">로그인</button>
		<button onclick="location.href='/myapps/signup';">회원가입</button>
	</div>
	
</body>
</html>