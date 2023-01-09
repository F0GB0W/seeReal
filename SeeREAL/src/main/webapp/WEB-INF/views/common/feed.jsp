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
        margin-top: 100px;
        margin-left: 700px;
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
        height: 200px;
        margin-left: 50px;
    }


</style>
</head>
<body>
	
	
	<div class="outer">
		<div class="profile">
			<image></image>
			<h3>${ memberNickname }님의 리얼피드</h3>
		</div>
		
		<div class="ratingCount">
		<!-- comments가 있으면 count 가져오고, 없으면 없다고 보여주기 -->
			<h3>평가수</h3>
			<c:choose>
				<c:when test="${ not empty comments }">
					${ count }
				</c:when>
				<c:otherwise>
					아직 남긴 리얼평이 없습니다.
				</c:otherwise>
			</c:choose>
        </div>
            
		<div class="ratingSpread">
            <canvas id="myChart" style="width:100%;max-width:700px"></canvas>
        </div>           

		<div class="comments">
            <h3>씨리즌이 사랑한 리얼평 TOP 5</h3>
            <table>
                <tr>
                    <th>영화제목</th>
                    <th>별점</th>
                    <th>좋아요</th>
                </tr>
                <tr>
                	<%-- td onclick="location.href=''" 도 달고싶은데 url 어떻게 연결하지? --%>
                    <td>탑건</td>
                    <td>★★★</td>
                    <td>50</td>
                </tr>
                <tr>
                    <td>헤어질결심</td>
                    <td>★★★★</td>
                    <td>30</td>
                </tr>
                <tr>
                    <td>장화신은고양이</td>
                    <td>★★★</td>
                    <td>29</td>
                </tr>
                <tr>
                    <td>영웅</td>
                    <td>★★★★★</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td>HER</td>
                    <td>★</td>
                    <td>9</td>
                </tr>
            </table>
        </div>
	</div>
	
	<script>
	// chart.js
        var xValues = ["★","","★★","","★★★","","★★★★","","★★★★★"];
        var yValues = [5, 1, 10, 2, 15, 3, 10, 4, 5];

        var myChart = new Chart("myChart", {
            type: "bar",
            data: {
                label:'별점분포',
                labels: xValues,
                datasets: [{
                backgroundColor: 'orange',
                data: yValues
                }]
        },
        options: {}
        });


	</script>
</body>
</html>