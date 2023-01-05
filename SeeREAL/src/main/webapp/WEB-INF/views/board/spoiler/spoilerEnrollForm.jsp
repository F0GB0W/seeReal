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
    <form id="frm1">

      <table>
        <caption></caption>
        <colgroup>
          <col style="width:100px" />
          <col style="" />
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">작성자</th>
            <td><input type="text" id="iptName" value="" /></td>
          </tr>
          <tr>
            <th scope="row">제목</th>
            <td><input type="text" id="iptTitle" value="" /></td>
          </tr>
          <tr>
            <th scope="row">내용</th>
            <td><textarea id="iptCont" rows="10" cols="20" style="resize:none;"></textarea></td>
          </tr>
        </tbody>

      </table>

    </form>
    <div class="btn-wrap">
      <input type="button" id="btnRegist" class="btn" value="글쓰기">
    </div>
  </fieldset>
</div>

</body>
</html>