<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬렉션을 만듭쉬다</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 부트스트랩에서 제공하고 있는 스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Alertify Framework -->
<!-- JavaScript -->
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/alertify.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/alertify.min.css"/>
<!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/default.min.css"/>
<!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.13.1/build/css/themes/semantic.min.css"/>
   
<style>
	a{
		text-decoration : none;
		color : black;
	}
</style>
</head>
<body>

    <form action="insert.ch" method="post" enctype="multipart/form-data">   
        
        <input type="hidden" name="memberNo" value="${ loginUser.memberNo }">

        <input type="text" name="collectionTitle" placeholder="컬렉션 제목 입력" required><br>

        <label for="upfile">썸네일 등록</label>
        <input type="file" id="upfile" class="form-control-file border" name="upfile"><br>

        <textarea name="collectionContent" placeholder="컬렉션 설명 입력" required></textarea><br>

        <input type="submit" value="만들기">
    </form>

    <script>
       function movie(){
			$.ajax({
				url : 'movie.mt',
				data : {
                    title : $('#title').val(),
                    year : $('#year').val()
                    },
				success : data => {
					console.log(data);
					//console.log(data.getFoodKr.item);
					
					const itemArr = data.items;
					
					let value = '';
					for(let i in itemArr){
						
					}
					
					
					$('#result1 tbody').html(value);
					// console.log(value);
					// $('#title').val(title);
					
				},
				error : () => {
					console.log('요건조금...');
				}
				
			});		
        }
    </script>
</body>
</html>