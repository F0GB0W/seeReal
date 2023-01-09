<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
<style>
    .outer{
        width:600px;
/*         margin-top: 100px;
        margin-left: 700px; */
        align: center;
    }
    .profile{
        height: 150px;
        background-color: orange;
        text-align: left;
    }

    .ratingCount{
        height: 100px;
        background-color: lightgray;
        text-align: center;
    }

    .comments{
        height: 250px;
        background-color: lightgray;
        text-align: center;
    }

    .comments>table{
        background-color: rgb(232, 232, 232);
        text-align: center;
        width: 500px;
        height: 20%;
        /* margin-left: 50px; */
    }


</style>
</head>
<body>
	
	
	<div class="outer">
		<div class="profile">
			<image></image>
			<h3>${ selectMember.memberNickname }님의 리얼피드</h3>
		</div>
		
		<div class="ratingCount">
		<!-- comments가 있으면 count 가져오고, 없으면 없다고 보여주기 -->
			<h3>평가수</h3>
			<c:choose>
				<c:when test="${ not empty comments }">
					${ count }
				</c:when>
				<c:otherwise>
					아직 남긴 리얼평이 없어요🥺
				</c:otherwise>
			</c:choose>
        </div>
            
		<div class="ratingSpread">
            <canvas id="myChart" style="width:100%;max-width:700px"></canvas>
        </div>           

		<div class="comments">
            <h3>씨리즌이 사랑한 리얼평 TOP 5</h3>
            <table>
            	<c:choose>
            	<c:when test="${ empty review }">
            		😽지금 바로 리얼평을 남겨보세요😽
            	</c:when>
            	<c:otherwise>
	                <tr>
	                    <th>영화제목</th>
	                    <th>별점</th>
	                    <th>좋아요</th>
	                </tr>
	                <c:forEach items="${ review }" var="f">
		                <tr>
		                	<%-- td onclick="location.href=''" 도 달고싶은데 url 어떻게 연결하지? --%>
		                    <td>${f.movieTitle}</td>
		                    <c:choose>
		                    	<c:when test="${f.rating == 1}">
		                    		<td>★</td>
		                    	</c:when>
		                    	<c:when test="${f.rating == 2}">
		                    		<td>★★</td>
		                    	</c:when>
		                    	<c:when test="${f.rating == 3}">
		                    		<td>★★★</td>
		                    	</c:when>
		                    	<c:when test="${f.rating == 4}">
		                    		<td>★★★★</td>
		                    	</c:when>
		                    	<c:when test="${f.rating == 5}">
		                    		<td>★★★★★</td>
		                    	</c:when>
		                    	<c:otherwise>
		                    		☆☆☆☆☆
		                    	</c:otherwise>
		                    </c:choose>
		                    <td>👍${f.commentLike}</td>
		                </tr>
					</c:forEach>
	                </c:otherwise>
                </c:choose>
            </table>
        </div>
	</div>
	
	<script>
	// chart.js
        var xValues = ["★","","★★","","★★★","","★★★★","","★★★★★"];
        var yValues = ${ratingList};

        var myChart = new Chart("myChart", {
            type: "bar",
            data: {
                labels: xValues,
                datasets: [{
                backgroundColor: 'orange',
                data: yValues
                }]
        },
        options: {
        	legend: {
        		display:false
        	}
        }
        });
	</script>
</body>
</html>