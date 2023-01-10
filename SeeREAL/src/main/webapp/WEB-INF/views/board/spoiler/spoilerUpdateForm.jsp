<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>게시글 수정</p>
  
<div id="wrap">
  <div id="resultWrap"></div>

  <fieldset>
    <legend>board</legend>
    <form action="spoilerUpdate.bo" method="post" enctype="multipart/form-data">
    		<input type="hidden" name="boardNo" value="${b.boardNo}"/>

      <table align="center">
        <caption></caption>
        <colgroup>
          <col style="width:100px" />
          <col style="" />
        </colgroup>
        <tbody>
          <tr>
            <th scope="row">제목</th>
            <td><input type="text" id="title" width="100px;" name="boardTitle" value="${b.boardTitle }" required></td>
          </tr>
          <tr>
            <th scope="row">작성자</th>
            
            <td><input type="text" id="writer" width="100px;" value="${loginUser.memberNickname }" readonly></td>
            <td><input type="hidden" id="writer" width="100px;" value="${loginUser.memberNo }" readonly name="boardWriter"></td>
          </tr>
          <tr>
            <th scope="row">첨부파일</th>
            <td>
            <input type="file" id="upfile" width="100px;" name="reUpfile" />
			<c:if test="${ not empty b.originName }">
				업로드된 파일 :
			<a href="${b.changeName }" download="${b.originName }">${b.originName }</a>
			<input type="hidden" name="originName" value="${b.originName }"/>
			<input type="hidden" name="changeName" value="${b.changeName }"/>
            </c:if>
            </td>
          </tr>
          <tr>
            <th scope="row"><label for="content">내용</label></th>
            <td><textarea id="content" rows="10" cols="100" style="resize:none;" name="boardContent" >${b.boardContent }</textarea></td>
          </tr>
          <tr>
            <td><input type="hidden" id="btype" width="100px;" value="${b.boardType}" readonly name="boardType" /></td>
          </tr>
        </tbody>

      </table>

    <div class="btn-wrap">
      <button type="submit" id="btnRegist" class="btn btn-secondary" >수정완료</button>
    </div>
    </form>
  </fieldset>
</div>
	

</body>
</html>