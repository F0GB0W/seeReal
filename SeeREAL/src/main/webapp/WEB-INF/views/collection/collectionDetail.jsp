<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>Insert title here</title>
</head>
<body>

    <input type="hidden" id="memberNo" value="${ collection.memberNo }">
    <input type="hidden" id="collectionNo" value="${ collection.collectionNo }">
    

    <div>
        <h1>${ collection.collectionTitle }</h1>
        <h3>${ collection.collectionContent }</h3>
        <a href="feed.me?memberNo=${ collection.memberNo }">${ collection.nickName }</a><br>
        <img src="${ collection.changeName }" width="400px" height="300px">
    </div>

    <hr>

    <div class="movieList-area">

    </div>

    <script>
        $(function() {
            $.ajax({
                url : 'movieList.cl',
                data : {
                    clno : $('#collectionNo').val()
                },
                success : list => {
                    movieSearch(list);
                },
                error : () => {
                    console.log('영화 조회 실패~~');
                }
            });

        });

        function movieSearch(list) {
            for(let i in list) {
                console.log(list[i]);
                $.ajax({
                    url : 'movie.mt',
                    data : {
                        title : list[i].movieTitle,
                        year : list[i].movieYear
                    },
                    success : data => {
                        console.log(data.items[0]);
                        const itemArr = data.items[0];
                        makeList(itemArr);
                    },
                    error : () => {
                        console.log('api오류~~~~');
                    }
                });
            }
        }

        let value = '';
        function makeList(itemArr) {
            value += '<div>'
                   + '<img src="' + itemArr.image + '">'
                   + '</div>'

            $('.movieList-area').html(value);
        }
    </script>
</body>
</html>