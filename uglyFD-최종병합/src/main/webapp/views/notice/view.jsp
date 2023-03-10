<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path }/resources/css/common_css/uglyFD-main.css">
<script src="${ path }/resources/js/jquery-3.6.3.js"></script>
</head>
<style>
section>div#board-write-container {
   width: 600px;
   margin: 0 auto;
   text-align: center;
}

section>div#board-write-container h2 {
   margin: 10px 0;
}

table#tbl-board {
   width: 500px;
   margin: 0 auto;
   border: 1px solid black;
   border-collapse: collapse;
   clear: both;
}

table#tbl-board th {
   width: 125px;
   border: 1px solid;
   padding: 5px 0;
   text-align: center;
}

table#tbl-board td {
   border: 1px solid;
   padding: 5px 0 5px 10px;
   text-align: left;
}

div#comment-container button#btn-insert {
   width: 60px;
   height: 50px;
   color: white;
   background-color: #3300FF;
   position: relative;
   top: -20px;
}

/*댓글테이블*/
table#tbl-comment {
   width: 580px;
   margin: 0 auto;
   border-collapse: collapse;
   clear: both;
}

table#tbl-comment tr td {
   border-bottom: 1px solid;
   border-top: 1px solid;
   padding: 5px;
   text-align: left;
   line-height: 120%;
}

table#tbl-comment tr td:first-of-type {
   padding: 5px 5px 5px 50px;
}

table#tbl-comment tr td:last-of-type {
   text-align: right;
   width: 100px;
}

table#tbl-comment button.btn-delete {
   display: none;
}

table#tbl-comment tr:hover {
   background: lightgray;
}

table#tbl-comment tr:hover button.btn-delete {
   display: inline;
}

table#tbl-comment sub.comment-writer {
   color: navy;
   font-size: 14px
}

table#tbl-comment sub.comment-date {
   color: tomato;
   font-size: 10px
}
</style>

<body>

<jsp:include page="/views/common/header.jsp" />

<section id="content">
   <div id="board-write-container">
      <h2>공지사항 게시판</h2>
      <table id="tbl-board">
         <tr>
            <th>글번호</th>
            <td>${ board.b_no }</td>
         </tr>
         <tr>
            <th>제 목</th>
            <td>${ board.bo_title }</td>
         </tr>
         <tr>
            <th>작성자</th>
            <td>${ board.bo_writer }</td>
         </tr>
         <tr>
            <th>조회수</th>
            <td>${ board.bo_hit }</td>
         </tr>
         <tr>
            <th>첨부파일</th>
            <td><c:if test="${empty board.original_filename }">
                  <span> - </span>
               </c:if> <c:if test="${not empty board.original_filename }">
                  <a href = "javascript:" id ="fileDown">
                     <span> ${board.original_filename } </span>
                  </a>
               </c:if>
            </td>
         </tr>
         <tr>
            <th>내 용</th>
            <td>${ board.bo_con }</td>
         </tr>
         <%--글작성자/관리자인경우 수정삭제 가능 --%>
         <tr>
            <th colspan="2">
               <c:if test="${ loginMember.grade == 1 }"> 
                  <button type="button" onclick="location.href='${path}/notice/update?no=${board.b_no }'">수정</button>
               	  <button type="button" id="btnDelete">삭제</button> 
               </c:if>
               <button type="button" onclick="location.href='${ path }/notice/list'">목록으로</button>
            </th>
         </tr>
      </table>
      <div id="comment-container">
         <div class="comment-editor">
            <form action="${ path }/notice/reply" method="POST">
	               <input type="hidden" name="boardNo" value="${board.b_no }">
	               <textarea name="content" id="replyContent" cols="55" rows="3" required="required"></textarea>
               <button type="submit" id="btn-insert">등록</button>
            </form>
         </div>
      </div>
      <table id="tbl-comment">
      <!-- 1개의 아이디로 여러개의 댓글을 작성할 수 있으므로 c:forEach(반복문)을 사용 -->
         <c:forEach var="reply" items="${ board.replies }">
            <tr class="level1">
               <td><sub class="comment-writer">${reply.writerId }</sub> <sub
                  class="comment-date">${reply.createDate }</sub> 
                  <br> 
                  <span>${reply.content }</span>
                  </td>
               </td>
               <td>
               <c:if test="${(not empty loginMember and loginMember.id == reply.writerId) or loginMember.grade == 1}">
                  <button>삭제</button>
               </c:if>
   
               </td>
            </tr>
         </c:forEach>
      </table>
   </div>
</section>





<jsp:include page="/views/common/footer.jsp" />

<script>
   $(document).ready(() => {
      $('#btnDelete').on('click', () => {
         if(confirm('정말로 게시글을 삭제 하시겠습니까?')) {
            location.replace('${ path }/notice/delete?no=${ board.b_no }');
         }
      });   
      
      $('#fileDown').on('click', () => {
         let oname = encodeURIComponent('${ board.original_filename }');
         let rname = encodeURIComponent('${ board.renamed_filename }');

         location.assign('${ path }/notice/fileDown?oname=' + oname + '&rname=' + rname);
      });
      
      ${'#replyContent'}.on('focus', () => {
         alert('로그인 후 이용해주세요!');
         
         ${'#userId'}.focus();
      });
   });
   
   
</script>



</body>
</html>