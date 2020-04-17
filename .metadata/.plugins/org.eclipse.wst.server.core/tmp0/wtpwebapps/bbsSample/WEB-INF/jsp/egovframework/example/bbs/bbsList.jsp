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
	// 글등록하기
	function insertBoard(id) {
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
	function idCheck() {
		console.log(">>>idCheck클릭")

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
				console.log('로그인한 아이디값 : ' + resultData);
				var tableDorm = document.getElementById('insertBoardTable');

				if (resultData != null) {

					// 제목
					var headTr = document.createElement('tr');
					tableDorm.appendChild(headTr);

					var headTd1 = document.createElement('td');
					headTd1.innerHTML = "제목";
					headTd1.bgColor = "orange";
					headTr.appendChild(headTd1);

					var headTd2 = document.createElement("td");
					headTd2.setAttribute("align", 'left');
					var input = document.createElement('input');
					input.setAttribute("type", "text");
					input.setAttribute("name", "title");
					input.setAttribute("id", "insertTitle");
					headTd2.appendChild(input);
					headTr.appendChild(headTd2);

					// 작성자
					var headTr2 = document.createElement('tr');
					tableDorm.appendChild(headTr2);

					var headTd21 = document.createElement('td');
					headTd21.innerHTML = "작성자";
					headTd21.bgColor = "orange";
					headTr2.appendChild(headTd21);

					var headTd22 = document.createElement("td");
					headTd22.setAttribute("align", 'left');
					headTd22.innerHTML = resultData;
					headTr2.appendChild(headTd22);

					// 내용
					var headTr3 = document.createElement('tr');
					tableDorm.appendChild(headTr3);

					var headTd31 = document.createElement('td');
					headTd31.innerHTML = "내용";
					headTd31.bgColor = "orange";
					headTr3.appendChild(headTd31);

					var headTd32 = document.createElement("td");
					headTd32.setAttribute("align", 'left');
					var textArea = document.createElement('textarea');
					textArea.setAttribute("cols", "40");
					textArea.setAttribute("rows", "10");
					textArea.setAttribute("name", "content");
					textArea.setAttribute("id", "insertContent");
					headTd32.appendChild(textArea);
					headTr3.appendChild(headTd32);

					// 글등록
					var headTr4 = document.createElement('tr');
					tableDorm.appendChild(headTr4);

					var headTd41 = document.createElement('td');
					headTd41.setAttribute('colspan', '2');
					headTd41.setAttribute('align', 'center');
					var input2 = document.createElement('input');
					input2.setAttribute("type", "button");
					input2.onclick = function() {
						insertBoard(resultData);
					}
					input2.setAttribute("id", "saveTitle");
					input2.setAttribute("value", "글등록");
					headTd41.appendChild(input2);
					headTr4.appendChild(headTd41);
					

				} else {
					console.log("데이터 로딩에 실패했습니다.")
				}
			},
			error : function(e) {
				console.log(e)
			}
		});

	}

	// 상세보기
	function getBoard(bno) {
		console.log(">>>상세보기")
		console.log("가져온 글번호값 : " + bno)

		var url = "./bbs/getBoard.do"
		$
				.ajax({
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
						$("#listTable")
								.append(
										"<tr><td>"
												+ bno
												+ "<td>"
												+ id
												+ "</td>"
												+ "</td><td><input id='inputTitle' type='text' value='" + title + "'/></td>"
												+ "<td><input id='inputContent' type='text' value='" + content + "'/></td>"
												+ "<td>"
												+ wdate
												+ "</td>"
												+ "<td><input name='modify' type='button' onclick='modifyBoard("
												+ bno
												+ ")' value='편집'/></td>"
												+ "<td><input name='delete' type='button' onclick='deleteBoard("
												+ bno
												+ ")' value='삭제'/></td></tr>");

					},
					error : function(e) {
						console.log(e)
					}
				});
	}

	// 삭제하기
	function deleteBoard(bno) {
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
				makeList();
			},
			error : function(e) {
				console.log(e)
			}
		});
	}

	// 편집하기
	function modifyBoard(bno) {
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
				makeList();
			},
			error : function(e) {
				console.log(e)
			}
		});
	}

	// 전체보기(Table List 생성)
	function makeList() {
		var tableDom = document.getElementById("bbsList");
		tableDom.innerHTML = "";

		var url = "./bbs/bbsList.do"
		$.ajax({
			type : "POST",
			url : url,
			success : function(data) {
				var resultList = data.resultList;
				if (resultList.length > 0) {

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
						console.log(resultList[i].bno);

						headTd11.setAttribute('style', 'cursor: pointer');
						headTd11.onclick = function(){
 							getBoard(this.innerHTML);
 						}
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
	
	// 회원가입
	function userInsert(){
		
	}
	
</script>
</head>
<body onload="makeList()">
	<!-- 회원가입 -->
	<table>
		<thead>
			<tr>
				<td><input type="submit" value="회원가입" onclick="userInsert()" /></td>
				<td>아이디</td>
				<td><input type="text" name="id" id="inputID" /></td>
				<td>비밀번호</td>
				<td><input type="text" name="pass" id="inputPass" /></td>
				<td><input type="button" value="로그인" onclick="idCheck()" /></td>
			</tr>
		</thead>
	</table>
	
	<br />
	
	<!-- 전체 게시글 리스트 -->
	<table id="bbsList" border="1" cellpadding="0" cellspacing="0" />

	<br />

	<!-- 글등록 -->
	<table border="1" id="insertBoardTable" />

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
</body>
</html>