<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	
	
	<div class="outer">
		<div class="profile">
			<image></image>
			<%-- ${ sessionScope.loginUser.nickName } --%>
			예진 님의 리얼피드
		</div>
		
		<div class="ratingCount"></div>
			평가수 : 아직 남긴 리얼평이 없습니다.
			<%-- 
			<c:choose>
				<c:when test="${ Count(*) > 0 }">
					${ Count(*) }
				</c:when>
				<c:otherwise>
					아직 남긴 리얼평이 없습니다.
				</c:otherwise>
			</c:choose>
			 --%>
		<div class="ratingSpread"></div>
			별점을 남기고 분포도를 확인해보세요!
			<%-- 
			<c:choose>
				<c:when test="${ Count(*) > 0 }">
					<canvas id="myChart"></canvas>
				</c:when>
				<c:otherwise>
					별점을 남기고 분포도를 확인해보세요!
				</c:otherwise>
			</c:choose>
			 --%>
		<div class="comments"></div>
	</div>
	
	<script>
		var ctx = document.getElementById('myChart').getContext('2d');
			var chart = new Chart(ctx, {
				type: 'bar',
				data : {
					lables : ['1','2','3','4','5'],
					datasets: [{
						label: '별점 분포',
						backgroundColor : 'grey',
						borderColor : 'black',
						data : [2, 10, 2, 4, 5]
					}]
				}
			})
	</script>
	 -->
</body>
</html>