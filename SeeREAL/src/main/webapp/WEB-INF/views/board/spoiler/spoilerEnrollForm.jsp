<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>

</head>
<body>

	<p>글쓰기 게시판</p>
  
<div id="wrap">
  <div id="resultWrap"></div>

  <fieldset>
    <legend>board</legend>
    <form action="insertSpoiler.bo" method="post" enctype="multipart/form-data">

      <table>
        <caption></caption>
        <colgroup>
          <col style="width:100px" />
          <col style="" />
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">제목</th>
            <td><input type="text" id="title" width="100px;" name="boardTitle" /></td>
          </tr>
          <tr>
            <th scope="row">작성자</th>
            <td><input type="text" id="writer" width="100px;" value="${loginUser.memberNo }" readonly name="boardWriter" /></td>
          </tr>
          <tr>
            <th scope="row">첨부파일</th>
            <td><input type="file" id="upfile" width="100px;" name="upfile" /></td>
          </tr>
          <tr>
            <th scope="row">내용</th>
            <td><textarea id="content" rows="10" cols="100" style="resize:none;" name="boardContent" ></textarea></td>
          </tr>
          <tr>
            <th scope="row">게시판 번호</th>
            <td><input type="hidden" id="btype" width="100px;" value="${b.boardType}" readonly name="boardType" /></td>
          </tr>
        </tbody>

      </table>

    <div class="btn-wrap">
      <button type="submit" id="btnRegist" class="btn" >글쓰기</button>
    </div>
    </form>
  </fieldset>
</div>

</body>
</html>