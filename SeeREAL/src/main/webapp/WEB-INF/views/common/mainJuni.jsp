<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인을 만들어봐용</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/aa839e973e.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>

* {
    list-style: none;
    text-decoration: none;
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    text-align: center;
}

.collectionLike-area {
    display: flex;
    align-items: center;
    justify-content: center;
}

#meetingCount-table > tbody:hover {
    cursor: pointer;
}

.collection {
    padding: 3px;
}

.collection div p {
    margin-bottom: 1px;
}

.collection :hover {
    cursor: pointer;
    font-weight: bold;
}


</style>
</head>
<body>
    <h1>요즘 뜨는 컬렉션</h1>

    <div class="collectionLike-area">
        
    </div>


    <hr>

    <h1>요즘 뜨는 모임</h1>
    <div class="meetingCount-area">
        <table id="meetingCount-table" class="table table-hover">
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>

	<script>
        $(function() {
            collectionMain();
            meetingMain();
        });

        function collectionMain() {
            $.ajax({
            url : 'collection.main',
            success : data => {
                value = '';
                for(let i in data) {
                    value += '<div class="collection" onclick="goCollection(' + data[i].collectionNo + ')">'
                           + '<img width="400px" height="300px" src="' + data[i].changeName + '">'
                           + '<div><p>' + data[i].collectionTitle+ '</p>'
                           + '<p>' + data[i].nickName + '가 만듦</p>'
                           + '<p><i class="fa-solid fa-heart" id="heart"></i> x ' + data[i].likeCount + '</p></div>'
                           + '</div>'


                    if(i == 3) {
                        value += '<li style="display:block;"></li>';
                    }
                }

                $('.collectionLike-area').html(value);
            },
            error : () => {
                console.log('에러 발생!!');
            }
            
            });
        }
        
        function goCollection(clno) {
            location.href = 'detail.cl?clno=' + clno;
        }

        function meetingMain() {
            $.ajax({
                url : 'meeting.main',
                success : data => {
                    console.log(data);

                    let value = '';
                    for(let i in data) {
                        value += '<tr onclick="goMeeting(' + data[i].meetingNo + ')">'
                               + '<td>' + data[i].meetingNo + '</td>'
                               + '<td>' + data[i].meetingTitle + '</td>'
                               + '<td>' + data[i].meetingWriter + '</td>'
                               + '<td>' + data[i].meetingCount + '</td>'
                               + '</tr>';

                    }

                    $('#meetingCount-table > tbody').html(value);
                },
                error : () => {
                    console.log('에러 발생!!');
                }
            });
        }

        function goMeeting(mtno) {
            location.href = 'detail.mt?mtno=' + mtno;
        }
        
    </script>
</body>
</html>