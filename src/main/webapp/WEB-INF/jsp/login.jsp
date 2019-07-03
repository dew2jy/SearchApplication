<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
      @import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
  width: 360px;
  padding: 8% 0 0;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #258fff;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #258fff;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}
    </style>
<script>
  window.console = window.console || function(t) {};
</script>
<script>
  if (document.location.search.match(/type=embed/gi)) {
    window.parent.postMessage("resize", "*");
  }
</script>
</head>
<body translate="no">
<div class="login-page">
<div class="form">
<form id="joinForm" class="register-form">
<input type="text" name="userId" placeholder="id" required="required"/>
<input type="password" name="userPass" placeholder="password" required="required"/>
<button type="submit">가입</button>
<p class="message">이미 계정이 있으신가요? <a href="javascript:void(0);">로그인 하기</a></p>
</form>
<form class="login-form" action="/loginProcess" method="post">
<input type="text" name="userId" placeholder="id" required="required"/>
<input type="password" name="userPass" placeholder="password" required="required"/>
<button type="submit">로그인</button>
<p class="message">계정이 없으신가요? <a href="javascript:void(0);">회원가입</a></p>
</form>
</div>
</div>
<script src="https://static.codepen.io/assets/common/stopExecutionOnTimeout-de7e2ef6bfefd24b79a3f68b414b87b8db5b08439cac3f1012092b2290c719cd.js"></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script id="rendered-js">
$('.message a').click(function () {
  $('form').animate({ height: "toggle", opacity: "toggle" }, "slow");
});
 
$('#joinForm').submit(function(e){
	e.preventDefault();
	
	$.post('/join', $('#joinForm').serialize(), function(data) {
		 if(data) {
			 alert('회원가입에 성공하였습니다. 로그인 해주세요.');
			 $("#joinForm").each(function() {  
		            this.reset();  
		         });
			 $('form').animate({ height: "toggle", opacity: "toggle" }, "slow");
		 } else {
			 alert('회원가입에 실패하였습니다. 중복된 아이디가 있습니다.');
		 }
	 });
	
	return false;
});
    </script>
</body>
</html>
