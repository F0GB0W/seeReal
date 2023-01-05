<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.star-rating{width:205px;}
.star-rating,.star-rating span{display:inline-block;height:39px; overflow:hidden; background:url(star.png)no-repeat;}
.star-rating span{background-position:left bottom; line-height:0; vertical-align:top;}

</style>
</head>
<body>
	<div>
	<img src="${movieImg }">
	
	</div>
	<div>
	<p>${movieTitle }</p>
	<p>${movieDate }</p>
	<p>${movieDirector }</p>
	<p>${movieSubTitle }</p>
	</div>
	<br><br>
	
	<form name="myform" id="myform" method="post" action="./save">
    <fieldset>
        <legend>이모지 별점</legend>
        <label for="rate1">⭐</label><input type="radio" name="rating" value="1" id="rate1">
        <label for="rate1">＊ ☆ ★</label><input type="radio" name="rating" value="1" id="rate1">
        <label for="rate2">⭐</label><input type="radio" name="rating" value="2" id="rate2">
        <label for="rate3">⭐</label><input type="radio" name="rating" value="3" id="rate3">
        <label for="rate4">⭐</label><input type="radio" name="rating" value="4" id="rate4">
        <label for="rate5">⭐</label><input type="radio" name="rating" value="5" id="rate5">
    </fieldset>
</form>
	
	<span class='star-rating'>
	<span style="width:50%"></span>
	
	</span>
	
	
</body>
</html>