<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<link href="${path}/resources/css/member/enroll.css" rel="stylesheet"/> 
<link rel="stylesheet" href="${path }/resources/css/common_css/uglyFD-main.css">
<!-- uglyFD-figure / section 부분 script -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>


<body>
<jsp:include page="/views/common/header.jsp" />
<p>
    <h1 align="center">회원 가입</h1><br><hr><br><br>
</p>
<section>
<form name="f" method="post" action="${ path }/enroll">
<table width="50%" height="80" border="1" align="center" cellpadding="5" cellspacing="0" >
    <tr align="center">
        <td colspan="2" align="center" bgcolor="beige">
            <div style="font-weight: bold; font-size: 18px; padding : 10px 0;">회원 기본 정보
            </div></td>
    </tr>
    <tr>
        <td bgcolor="beige" align="center">
            <div style="font-weight: bold; padding : 10px 0;">아이디 :
            </div></td> 
        <td>&nbsp<input type="text" name="userId" id="userId" size="12" maxlength="12">
            <input type="button" id="checkDuplicate" value="중복검사" >
            <p style="margin-bottom: 0rem">&nbsp4~12자의 영문 대소문자와 숫자로만 입력</p></td>
    </tr>
    <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">비밀번호 :</div></td>
        <td>&nbsp<input type="password" id="userPwd1" name="userPwd1" size="12" maxlength="12">
            <p style="margin-bottom: 0rem">&nbsp4~12자의 영문 대소문자와 숫자로만 입력</p></td>
    </tr>
    <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">비밀번호 확인 :</div></td>
        <td>&nbsp<input type="password" id="userPwd2" name="userPwd2" size="12" maxlength="12"></td>
    </tr>
    <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">메일주소 :</div></td>
        <td>&nbsp<input type="text" name="email" id="email" size="30" maxlength="30">
           <p style="margin-bottom: 0rem">&nbspex) uglyfd@naver.com</p></td>
    </tr>
    <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">이름 :</div></td>
        <td>&nbsp<input type="text" name="userName" id="userName" size="10" maxlength="10"></td>
    </tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">생년월일 :</div></td>
        <td>&nbsp<input type="text" name="birth" id="birth" size="20" >
        <p style="margin-bottom: 0rem"> ex) 1995-09-11</p>
        </td>

    </tr>
    <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">성별 :</div></td>
        <td>&nbsp<input type="radio" name="gender" id="gender" size="10" value="남자" checked> 남자 
            <input type="radio" name="gender" id="gender" size="10" value="여자" > 여자</td>
    </tr>
    <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">전화번호 :</div></td>
        <td>&nbsp<input type="text" name="phone" id="phone" size="20" maxlength="30">
            <p style="margin-bottom: 0rem">&nbspex) 01000000000</p></td>
        </td>
    </tr>
        <tr>
        <td bgcolor="beige" align="center"><div style="font-weight: bold; padding : 10px 0;">주소 :</div></td>
        <td>&nbsp<input type="text" id="addr" name="addr" placeholder="상세주소까지 입력해주세요." style="width:300px">
&nbsp<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 API KEY를 사용하세요&libraries=services"></script>
<script>
    
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("addr").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
}
                });
            }
        }).open();
    }
</script>
        </td>
    </tr>
</table>
<br><br>
<p align="center">
    <input type="submit" name="submit" value="회원 가입" style="width: 100px; height: 35px;" id="validate" onclick="return window.validate();" >
    <input type="reset" value="다시 입력" style="width: 100px; height: 35px;">

</p>

<br><br>
</form>
</section>

<script>

function validate() {
	  var objID = document.getElementById("userId");
	  var objPwd1 = document.getElementById("userPwd1");
	  var objPwd2 = document.getElementById("userPwd2");
	  var objEmail = document.getElementById("email");
	  var objName = document.getElementById("userName");
	  var objpho = document.getElementById("phone");


	  var regul1 = /^[a-zA-Z0-9]{4,12}$/;

	  var regul2 =
	    /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;

	  var regul3 = /^[가-힝a-zA-Z]{2,}$/;

	  var regul4 = /^[0-9]{3}[0-9]{4}[0-9]{4}$/;

	  var regul5 =
	    /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;

	  if (objID.value == "") {
	    alert("아이디를 입력하지 않았습니다.");
	    objID.focus();
	    return false;
	  }
	  if (
	    !check(
	      regul1,
	      objID,
	      "아이디는 4~12자의 대소문자와 숫자로만 입력 가능합니다."
	    )
	  ) {
	    return false;
	  }
	  if (objPwd1.value == "") {
	    alert("비밀번호를 입력해 주세요");
	    objPwd1.focus();
	    return false;
	  }
	  if (objPwd2.value == "") {
	    alert("비밀번호를 입력해 주세요");
	    objPwd2.focus();
	    return false;
	  }

	  if (
	    !check(
	      regul1,
	      objPwd1,
	      "비밀번호는 4~12자의 대소문자와 숫자로만 입력 가능합니다."
	    )
	  ) {
	    return false;
	  }

	  if (objPwd1.value != objPwd2.value) {
	    alert("비밀번호가 일치 하지 않습니다.");
	    objPwd1.value = "";
	    objPwd2.value = "";
	    objPwd1.focus();
	    objPwd2.focus();
	    return false;
	  }
	  if (objEmail.value == "") {
	    alert("이메일을 입력해 주세요");
	    objEmail.focus();
	    return false;
	  }
	  if (!check(regul2, objEmail, "이메일을 잘못 입력 했습니다.")) {
	    return false;
	  }
	  if (objName.value == "") {
	    alert("이름을 입력해 주세요");
	    objName.focus();
	    return false;
	  }
	  if (!check(regul3, objName, "이름이 잘못 되었습니다.")) {
	    return false;
	  }
	  if (objpho.value == "") {
	    alert("전화번호를 입력해 주세요");
	    objName.focus();
	    return false;
	  }
	  
	  if (!check(regul4, objpho, "전화번호가 잘못 되었습니다.")) {
	    return false;
	  }

	}
	function check(re, what, message) {
	  if (re.test(what.value)) {
	    return true;
	  }
	  alert(message);
	  what.value = "";
	  what.focus();
	}


	
$(document).ready(() => {
    $('#checkDuplicate').on('click', () => {
        let userId = $('#userId').val().trim();

        $.ajax({
            type: 'POST',
            url: '${ path }/member/idCheck',
            dataType: 'json',
            data: {
                userId
            },
            success: (obj) => {
                console.log(obj);

                if(obj.duplicate) {
                    alert("이미 사용중인 아이디 입니다.");
                } else {
                    alert("사용 가능한 아이디 입니다.");
                }
            },
            error: (error) => {
                console.log(error);
            }
        });
    });
});


</script>

<jsp:include page="/views/common/footer.jsp"/>