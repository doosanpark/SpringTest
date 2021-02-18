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

	div{
		margin: 3px;
	}
	
	button{
		margin: 3px;
	}
</style>

<script>

	function check(){
		
		var email = document.getElementById('email').value;
		
		
		$.ajax({
			url: "/myapps/idcheck",
			type: "POST",
			data: {
				email: email
			},
			success: function(data) {
				if(data==="t"){
					alert("사용 가능");	
				}else {
					alert("이메일 중복");
				}
			},
			error: function(request, status, error) {
				alert("에러");	
			}
			
		})
		
	}
	
	function signUp(){

		var email = document.getElementById('email').value;
		var password = document.getElementById('password').value;
		var phone = document.getElementById('phone').value;
		
		$.ajax({
			url: "/myapps/create",
			type: "POST",
			data: {
				email: email,
				password: password,
				phone: phone
			},
			success: function(data) {
				if(data==="s"){
					alert("회원 등록");	
				}else {
					alert("등록 실패");
				}
			},
			error: function(request, status, error) {
				alert("에러");	
			}
			
		})
		
	}
	
</script>

</head>
<body>
	<h1>회원가입</h1>
	
	<div>
		<input id="email" type="email" placeholder="Email"/>
	</div>
	
	<div>
		<input id="password" type="password" placeholder="Password"/>
	</div>
	
	<div>
		<input id="phone" type="text" placeholder="Phone"/>
	</div>
	
	<div class="btns">
		<button onclick="signUp();">회원가입</button>
		<button onclick="check();">중복 체크</button>
	</div>
	
	
</body>
</html>