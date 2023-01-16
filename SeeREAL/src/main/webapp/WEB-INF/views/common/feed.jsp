<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>see:REAL</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <%--file:///C:/seeReal-workspace/seeReal/SeeREAL/src/main/webapp/resources/img/temporarily.png --%>
<style>

	@font-face {
	    font-family: 'IBMPlexSansKR-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
    .outer{
    	font-family: 'IBMPlexSansKR-Regular';
        width:600px; 
        align: center;
    }
    .profile{
        height: 150px;
        background-color: #ff52a0;
        text-align: center;
        margin: auto;
    	padding: 8px;
    }

    .ratingCount{
    	margin-top: 10px;
        height: 100px;
        background-color: lightgray;
        text-align: center;
    	padding: 10px;
    }

    .comments{
        height: 250px;
        background-color: lightgray;
        text-align: center;
    	padding: 8px;
		margin-top: 10px;
    }

    .comments>table{
        background-color: rgb(232, 232, 232);
        text-align: center;
        width: 500px;
        height: 20%;
        margin-left: 50px;
        
    }
    .profile>img{
    	margin-top : 10px;
    }
	.profile>h4{
		margin-top: 10px;
	}
	.ratingSpread{
		margin-top: 10px;
	}


</style>
</head>
<body>
	
	<div class="outer">
		<div class="profile">
						<c:choose>
				<c:when test="${ not empty selectMember.memberPhoto }">
					<img src="${ selectMember.memberPhoto }" height="60px" width="60px" class="rounded-circle">
				</c:when>
				<c:otherwise>
					<img src="resources/img/user.png" height="60px" width="60px" >			
				</c:otherwise>
			</c:choose>
			<h4>${ selectMember.memberNickname }님의 리얼피드</h4>
		</div>
		
		<div class="ratingCount">
		<!-- comments가 있으면 count 가져오고, 없으면 없다고 보여주기 -->
			<h4>평가수</h4>
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
			<%-- <input type="hidden" value="${ ratingYj }" id="ratingYj"> --%>
            <canvas id="myChart" style="width:100%;max-width:700px"></canvas>
        </div>           

		<div class="comments">
            <h4>씨리즌이 사랑한 리얼평 TOP 5</h4>
            <table>
            	<c:choose>
	            	<c:when test="${ empty review }">
	            		<tr>
	            			<td>😽지금 바로 리얼평을 남겨보세요😽</td>
	            		</tr>
	            	</c:when>
	            	<c:otherwise>
		                <tr>
		                    <th>영화제목</th>
		                    <th>별점</th>
		                    <th>좋아요</th>
		                </tr>
		                <c:forEach items="${ review }" var="f" varStatus="status">
			                <tr>
			                	<!-- <input type="hidden" id="realNo" value="" /> -->
			                    <td id=title onclick="location.href='movieDetail.co'" style="cursor:pointer;">${f.movieTitle}</td>
			                    <c:choose>
			                    	<c:when test="${f.rating == 0.5}">
			                    		<td>☆</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 1}">
			                    		<td>★</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 1.5}">
			                    		<td>★☆</td>
			                    	</c:when>			                    	
			                    	<c:when test="${f.rating == 2}">
			                    		<td>★★</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 2.5}">
			                    		<td>★★☆</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 3}">
			                    		<td>★★★</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 3.5}">
			                    		<td>★★★☆</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 4}">
			                    		<td>★★★★</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 4.5}">
			                    		<td>★★★★☆</td>
			                    	</c:when>
			                    	<c:when test="${f.rating == 5}">
			                    		<td>★★★★★</td>
			                    	</c:when>
			                    	<c:otherwise>
			                    		☆☆☆☆☆
			                    	</c:otherwise>
			                    </c:choose>
			                    <td>👍${status.count}</td> 
			                </tr>
						</c:forEach>
		            </c:otherwise>
                </c:choose>
            </table>
        </div>
	</div>
	
	<script>

	// chart.js
        var xValues = ["","★","","★★","","★★★","","★★★★","","★★★★★"];
        var yValues = [${star.starHalf},${star.star1},${star.star1Half},${star.star2},${star.star2Half},
        				${star.star3},${star.star3Half},${star.star4},${star.star4Half},${star.star5}
        				];

        var myChart = new Chart("myChart", {
            type: "bar",
            data: {
              labels: xValues,
              datasets: [{
	                backgroundColor: '#ff91c3',
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