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
<style>
    .outer{
        width:600px;
        align: center;
    }
    .profile{
        height: 150px;
        background-color: orange;
        text-align: center;
        margin: auto;
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
    .profile>img{
    	margin-top : 10px;
    }


</style>
</head>
<body>
	
	<div class="outer">
		<div class="profile">
			<img src="${ selectMember.memberPhoto }" height="60px" width="60px" >
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
			<%-- <input type="hidden" value="${ ratingYj }" id="ratingYj"> --%>
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
		                <c:forEach items="${ review }" var="f" varStatus="status">
			                <tr>
			                	<!-- <input type="hidden" id="realNo" value="" /> -->
			                    <td id=title>${f.movieTitle}</td>
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
	
/* 	//ajax 요청을 해서 success(result) == rating [1.5, 2,4..]
		function rating(){
			$.ajax({
				url : 'rating.yj',
				data: {
					memberNo :  $('#ratingYj').val()
				},
				success : function(reviewRating){
					console.log(${ratingYj});						
				},
				error : ()=> {
					console.log('rating.yj 실패' + rating);
				}
				
				})
			}
	
		function reviewRating(){
			for(var i = 0; i < ${ratingList}.length; i++){
				// ratingList에 rating을 []에 오름차순으로 반복해서 넣기
				let ratingArray = rating[i];
			}
		}	 */
	
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
        
/* 		$(function(){
			
/* 				
 * location.href = 'detail.mt?mtno=' + $(this).children('#realNo').val(); 
 * 원래 이렇게 쿼리스트링으로 해당 리뷰 보게 하려고 했는데.. 아직 디테일뷰는 없고... 만약 post 방식으로 넘기면.. 어떻게 가죠?
			
			$('.comments table #title').click(function(){
			})
		});
 */
	</script>
</body>
</html>