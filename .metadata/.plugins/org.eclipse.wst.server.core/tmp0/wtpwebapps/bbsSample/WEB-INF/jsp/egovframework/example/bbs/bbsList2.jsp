<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<c:set var="registerFlag"
	value="${empty sampleVO.id ? 'create' : 'modify'}" />
<title>Sample <c:if test="${registerFlag == 'create'}">
		<spring:message code="button.create" />
	</c:if> <c:if test="${registerFlag == 'modify'}">
		<spring:message code="button.modify" />
	</c:if>
</title>
<link type="text/css" rel="stylesheet"
	href="<c:url value='/css/egovframework/sample.css'/>" />

<!--For Commons Validator Client Side-->
<script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
<script type="text/javascript" src="./scripts/lib/jquery-3.5.0.min.js"></script>
<validator:javascript formName="sampleVO" staticJavascript="false"
	xhtml="true" cdata="false" />

<script type="text/javascript">

	function insertBoard(id){
		var title = document.getElementById("insertTitle").value;
		var content = document.getElementById("insertContent").value;
		
		console.log("글등록하려는 아이디값 : " + id);
		console.log("글 등록 제목 : " + title);
		console.log("글 등록 내용 : " + content);
		
		var url = "./bbs/saveBoard.do"
			$.ajax({
				type : "POST",
				url : url,
				data : {
					'id' : '22',
					'title' : title,
					'content' : content
				},
				success : function(resultData) {
					console.log(resultData.resultMsg);
					makeList();
				},
				error : function(e) {
					console.log(e)
				}
			});

		
	}

	// 아이디체크&로그인
	function idCheck(id, bno) {
		console.log(">>>idCheck클릭")
		// DB에 저장된 게시글 id
		/* console.log(id); */

		// 입력된 id
		var inputID = document.getElementById("inputID");
		console.log("입력한 아이디 : " + inputID.value);

		// 입력된 password
		var inputPass = document.getElementById("inputPass");
		console.log("입력한 패스워드 : " + inputPass.value);

		// 입력된 정보 확인 
		var url = "./bbs/idCheck.do"
		$.ajax({
			type : "POST",
			url : url,
			data : {
				'id' : inputID.value,
				'pass' : inputPass.value
			},
			success : function(resultData) {
				document.getElementById('idCheckResult').innerHTML = resultData;
// 				getBoard(bno);
				getBoard(56);
			},
			error : function(e) {
				console.log(e)
			}
		});

	}
	
	// 상세보기
	function getBoard(bno){
		console.log(">>>상세보기")
		console.log("가져온 글번호값 : " + bno)
		
		var url = "./bbs/getBoard.do"
			$.ajax({
				type : "POST",
				url : url,
				data : {
					'bno' : bno
				},
				success : function(data) {
					
					var bno = data.bbsVO.bno;
					var id = data.bbsVO.id;
					var title = data.bbsVO.title;
					var content = data.bbsVO.content;
					var wdate = data.bbsVO.wdate;
					
					$("#listTable").find("tr").not(":first").remove();
					$("#listTable").append("<tr><td>" + bno
							+ "<td>" + id + "</td>"
							+ "</td><td><input id='inputTitle' type='text' value='" + title + "'/></td>" 
							+ "<td><input id='inputContent' type='text' value='" + content + "'/></td>"
							+ "<td>" + wdate + "</td>"
							+ "<td><input name='modify' type='button' onclick='modifyBoard(" + bno + ")' value='편집'/></td>"
							+ "<td><input name='delete' type='button' onclick='deleteBoard(" + bno + ")' value='삭제'/></td></tr>");
					
					
				},
				error : function(e) {
					console.log(e)
				}
			});
	}
	
	// 삭제하기
	function deleteBoard(bno){
		console.log(">>>삭제하기");
		console.log("삭제할 글번호값 : " + bno);
		
		var url = "./bbs/deleteBoard.do"
			$.ajax({
				type : "POST",
				url : url,
				data : {
					'bno' : bno
				},
				success : function(data) {
					document.getElementById('deleteBoard').innerHTML = data;
				},
				error : function(e) {
					console.log(e)
				}
			});
	}
	
	// 편집하기
	function modifyBoard(bno){
		console.log(">>>편집하기");
		var title = document.getElementById('inputTitle').value;
		var content = document.getElementById('inputContent').value;
		
		console.log("편집할 글번호값 : " + bno);
		console.log("편집할 제목값 : " + title);
		console.log("편집할 내용값 : " + content);
		
		var url = "./bbs/modifyBoard.do"
			$.ajax({
				type : "POST",
				url : url,
				data : {
					'bno' : bno,
					'title' : title,
					'content' : content
				},
				success : function(data) {
					document.getElementById('modifyBoard').innerHTML = data;
				},
				error : function(e) {
					console.log(e)
				}
			});
	}
	
	// Table List 생성
	function makeList() {
		var tableDom = document.getElementById("bbsList");
		tableDom.innerHTML = "";
		
		var url = "./bbs/bbsList.do"
		$.ajax({
			type : "POST",
			url : url,
			data : {},
			success : function(data) {
				var resultList = data.resultList;
				if (resultList.length > 0 ){
					var headTr = document.createElement("tr");
					headTr.bgColor = "orange";
					tableDom.appendChild(headTr);
					var headTd1 = document.createElement("td");
					headTd1.innerHTML = "글번호";
					headTr.appendChild(headTd1);
					var headTd2 = document.createElement("td");
					headTd2.innerHTML = "작성자";
					headTr.appendChild(headTd2);
					var headTd3 = document.createElement("td");
					headTd3.innerHTML = "제목";
					headTr.appendChild(headTd3);
					
					for (var i = 0; i < resultList.length; i++) {
						var headTr11 = document.createElement("tr");
						tableDom.appendChild(headTr11);
						var headTd11 = document.createElement("td");
						headTd11.innerHTML = resultList[i].bno;
						headTr11.appendChild(headTd11);
						var headTd21 = document.createElement("td");
						headTd21.innerHTML = resultList[i].id;
						headTr11.appendChild(headTd21);
						var headTd31 = document.createElement("td");
						headTd31.innerHTML = resultList[i].title;
						headTr11.appendChild(headTd31);
					}
				} else {
					console.log("데이터 로딩에 실패했습니다.");
				}
			},
			error : function(e) {
				console.log(e)
			}
		});
	}
	
</script>
</head>
<body onload="makeList()">
	<!-- 회원가입 form -->
	<input type="button" onclick="idCheck()" value="로그인" /></td>
	<form name="form" action="<c:url value='./bbs/userInsert.do'/>"
		method="post">
		<table>
			<thead>
				<tr>
					<td>사용자</td>
					<td><input type="text" name="id" id="inputID" /></td>
					<td>비밀번호</td>
					<td><input type="text" name="pass" id="inputPass" /></td>
					<td><input type="submit" value="회원가입" /></td>
				</tr>
			</thead>
		</table>
	</form>
	<h1>${message}</h1>
	<br />
	<!-- 전체 게시글 리스트 -->
	<table id="bbsList" border="1" cellpadding="0" cellspacing="0">
<!-- 		<tr bgcolor="orange"> -->
<!-- 			<td>글번호</td> -->
<!-- 			<td>작성자</td> -->
<!-- 			<td>제목</td> -->
<!-- 		</tr> -->
<%-- 		<c:forEach var="result" items="${resultList }" varStatus="status"> --%>
<!-- 			<tr> -->
<%-- 				<td><c:out value="${result.bno }" /></td> --%>
<!-- 				<td><a style="cursor: pointer" -->
<%-- 					onclick="idCheck('${result.id }', '${result.bno }')"> --%>
<%-- 						${result.id }</a></td> --%>
<%-- 				<td><c:out value="${result.title }" /></td> --%>
<%-- 				<c:set var="id" value="${result.id }" /> --%>
<!-- 			</tr> -->
<%-- 		</c:forEach> --%>
	</table>
	
	<br />

	<!-- 글등록 -->
	<form name="form">
		<table border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="orange" width="70">제목</td>
				<td align="left"><input type="text" name="title" id="insertTitle"/></td>
			</tr>
			<tr>
				<td bgcolor="orange">작성자</td>
				<td align="left"><span id="idCheckResult"></span></td>
			</tr>
			<tr>
				<td bgcolor="orange">내용</td>
				<td align="left"><textarea cols="40" rows="10" name="content" id="insertContent"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button"
				onclick="insertBoard(${id})" value="글등록" /></td>
			</tr>
		</table>
	</form>

	<br />

	<!-- 상세보기 -->
	<form>
		<table border="1" cellpadding="0" cellspacing="0" id="listTable">
			<tr>
				<td bgcolor="orange">글번호</td>
				<td bgcolor="orange">작성자</td>
				<td bgcolor="orange">제목</td>
				<td bgcolor="orange">내용</td>
				<td bgcolor="orange">등록일</td>
				<td bgcolor="orange">편집</td>
				<td bgcolor="orange">삭제</td>
			</tr>
		</table>
	</form>
	<span id="deleteBoard"></span>
	<span id="modifyBoard"></span>
</body>
</html>