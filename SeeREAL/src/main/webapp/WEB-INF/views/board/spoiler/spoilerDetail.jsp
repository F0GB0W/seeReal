<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        table * {margin:5px;}
        table {width:100%;}
    </style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div>
		<a class="btn btn-secondary" style="float:right;" href="spoilerList.bo">목록으로</a>
		<table id="detailView" align="center" class="table">
			<tr>
				<th width="100">제목</th>
				<td	colspan="3">${b. boardTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${b.boardWriter }</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${b.enrollDate }</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<c:choose>
				<c:when test="${empty b.originName }">
					첨부파일이 없습니다.
				</c:when>
				<c:otherwise>
					<a href="${b.changeName }" download="${b.originName }">${b.originName }</a>
				</c:otherwise>
				</c:choose>
			</tr>
			
			<tr>
				<th>내용</th>
				<td colspan="3">
			</tr>
			<tr>
				<td colspan="4"><p style="height:150px;">${b.boardContent }</p></td>
			</tr>		
		</table>
	
	
	</div>
	
	<script>
	
	</script>


</body>
</html>