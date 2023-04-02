<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/movieMain.css">
    <title>영화 검색?</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
   
  </head>
  <body>
  	
  	<jsp:include page="/WEB-INF/views/common/menubar.jsp"/>
  
  
  	<div align="center" id="searchMovie-scope">
	    <input placeholder="영화제목을 입력하세요~" id="titleBox" />
		<button id="searchButton" onclick="movie();">이동~</button>
  	</div>

	
    <table id="result1" border="1" align="center" style="display: none;">
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
      <tbody></tbody>
    </table>
    <form action="movieDetail.co" method="post" id="form1">
      <input type="hidden" id="movieYear" name="movieYear" />
      <input type="hidden" id="movieTitle" name="movieTitle" />
      <input type="hidden" id="movieImg" name="movieImg" />
      <input type="hidden" id="movieDirector" name="movieDirector" />
      <input type="hidden" id="movieSubTitle" name="movieSubTitle" />
    </form>
    

    <script>
	    $('#titleBox').on('keyup',function(key){
				
				if(key.keyCode==13){
					
					$('#searchButton').click();
					
				}		
			})	
    
      function movie() {
    	console.log($("#titleBox").val());
    	console.log($("#titleBox"));
        $.ajax({
          url: "movie.do",
          data: { title: $("#titleBox").val() },
          success: (data) => {
            $('#result1').attr('style','display:')

            const itemArr = data.items;

            let value = "";
            for (let i in itemArr) {
              let item = itemArr[i];              
              let thumb = item.image;

			  value +='<tr>'
					+ '<td><a href="'+ item.link + '">' + item.title + '</a></td>'
					+ '<td><img src="' + thumb + '"/></td>'
					+ '<td name="movieYear">' + item.pubDate + '</td>'
					+ '<td>' + item.director + '</td>'
					+ '<td>' + item.actor + '</td>'
					+ '<td>' + item.userRating + '</td>'
					+ '<input type="hidden" value="'+item.subtitle+'">'
					+ '</tr>';
            }

            $("#result1 tbody").html(value);          
          },
          error: () => {
            console.log("영화 목록 불러오기 실패");
          },
        });

        $(document).on("click", "#result1 tbody>tr", function () {         

          $("#movieTitle").val($(this).children().eq(0).text());
          $("#movieYear").val($(this).children().eq(2).text());
          $("#movieImg").val($(this).children().children().eq(1).attr("src"));
          $("#movieDirector").val($(this).children().eq(3).text());
          $("#movieSubTitle").val($(this).children().eq(6).val());
          
          $("#form1").submit();
        });
        
        <!--임시 -->
	    $(document).on("click", "#titleBox", function () {         

	          $("#movieTitle").val("노량진 토토로");
	          $("#movieYear").val(2005);
	          $("#movieImg").val($(this).children().children().eq(1).attr("src"));
	          $("#movieDirector").val($(this).children().eq(3).text());
	          $("#movieSubTitle").val($(this).children().eq(6).val());
	          
	          $("#form1").submit();
	        });
        
        
      }
    </script>
  </body>
</html>
