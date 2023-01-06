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
			<h3>user01님의 리얼피드</h3>
		</div>
		
		<div class="ratingCount">
			<h3>평가수</h3>
            <h3>10</h3>
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
        // var barColors = ["red", "green","blue","orange","brown"];

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