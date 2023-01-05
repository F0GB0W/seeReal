<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 검색?</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<style>
	a{
		text-decoration : none;
		color : black;
	}
	
</style>
</head>
<body>

	<input placeholder="영화제목을 입력하세요~" id="title" /><button onclick="movie();">이동~</button>
	
	
		<table id="result1" border="1" align="center">
		<thead>
			<tr>
				<th>영화제목(링크)</th>
				<th>이미지</th>
				<th>개봉일</th>
				<th>감독</th>
				<th>출연배우</th>
				<th>평점</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<form action="movieDetail.co" method="post" id="form1">
		<input type="hidden" id="movieDate" name="movieDate">
		<input type="hidden" id="movieTitle" name="movieTitle">
		<input type="hidden" id="movieImg" name="movieImg">
		<input type="hidden" id="movieDirector" name="movieDirector">
		
	</form>
	<input type="text" id="test1">
	
	<script>
		function movie(){
			$.ajax({
				url : 'movie.do',
				data : {title : $('#title').val()},
				success : data => {
					console.log(data.items[0]);
					//console.log(data.getFoodKr.item);
					
					
					
					const itemArr = data.items;
					
					let value = '';
					for(let i in itemArr){
						let item = itemArr[i];
						console.log(item);
						let thumb = item.image;
						
						value += '<tr>'
							   + '<td><a href="'+ item.link + '">' + item.title + '</a></td>'
							   + '<td><img src="' + thumb + '"/></td>'
							   + '<td name="movieDate">' + item.pubDate + '</td>'
							   + '<td>' + item.director + '</td>'
							   + '<td>' + item.actor + '</td>'
							   + '<td>' + item.userRating + '</td>'
							   + '</tr>' 
					}
					
					
					$('#result1 tbody').html(value);
					console.log(value);
					$('#title').val(title);
					console.log($('#result1 tbody').children())
					
				},
				error : () => {
					console.log('요건조금...');
				}
				
			});	
			console.log($('#result1 tbody'))
			console.log('---1')
			$(document).on('click','#result1 tbody>tr',function(){
				console.log($('#result1 tbody>tr'));
				console.log(this)
				console.log('--x--')
				console.log($(this).children().eq(0))
				console.log($(this).children().children().eq(1).attr('src'))
				
				$('#movieTitle').val($(this).children().eq(0).text());
				$('#movieDate').val($(this).children().eq(2).text());
				$('#movieImg').val($(this).children().children().eq(1).attr('src'));
				$('#moviemovieDirector').val($(this).children().eq(3).text());
				$('#form1').submit();
			})
		}
	</script>
	

	

</body>
</html>