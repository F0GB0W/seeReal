<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임을합쉬당 </title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<style>
	a{
		text-decoration : none;
		color : black;
	}
	
</style>
</head>
<body>

	<input placeholder="영화제목을 입력하세요~" id="title" />
    <input number="영화 연도를 입력하세요~" id="year"/>
    <button onclick="movie();">이동~</button>
	
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
						let item = itemArr[i];
						console.log(item);
						let thumb = item.image;
						
						value += '<tr>'
							   + '<td><a href="'+ item.link + '">' + item.title + '</a></td>'
							   + '<td><img src="' + thumb + '"/></td>'
							   + '<td>' + item.pubDate + '</td>'
							   + '<td>' + item.director + '</td>'
							   + '<td>' + item.actor + '</td>'
							   + '<td>' + item.userRating + '</td>'
							   + '</tr>' 
					}
					
					
					$('#result1 tbody').html(value);
					console.log(value);
					$('#title').val(title);
					
				},
				error : () => {
					console.log('요건조금...');
				}
				
			});			
		}
	</script>
	

	

</body>
</html>