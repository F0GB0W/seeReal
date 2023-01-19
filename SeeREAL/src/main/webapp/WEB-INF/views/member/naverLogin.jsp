<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
  	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
    
    <section class="bg-light">
        <div class="container py-4">
          <c:if test="${signIn == null}">
            <form action="${cpath}/signIn.do" method="post">
                <div class="form-group">
                    <input type="text" class="form-control" name="userId" placeholder="아이디">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" name="userPwd" placeholder="비밀번호">
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                    <label class="form-check-label text-secondary" for="flexCheckDefault">
                      	로그인 상태 유지
                    </label>
                </div>
                <div class="d-grid gap-2">
                    <button class="btn btn-primary btn-lg" type="submit">로그인</button>
                </div>
            </form>
                <div class="otherButton text-center">
                    <button type ="button" class = "btn" onclick="location.href='${urlNaver}'"><img width="150px" height="40px" src='http://static.nid.naver.com/oauth/big_g.PNG'></button>
                </div>
            </c:if>
        </div>
    </section>

</body>
</html>