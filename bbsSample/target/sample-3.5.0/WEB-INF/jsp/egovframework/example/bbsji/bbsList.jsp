<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:set var="registerFlag" value="${empty sampleVO.id ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
    
    function bbsji(){
    	document.listForm.action = "<c:url value='/addSample.do'/>";
       	document.listForm.submit();
    }
    
    function showDetail(url,name,age,subject,content){
    	
    	document.ji.name.value = name;
    	document.ji.age.value = age;
    	document.ji.subject.value = subject;
    	document.ji.content.value = content;
    	
    	document.ji.action = url;
    	document.ji.submit();
    	
    }
    
    
    
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	
	<form name="ji" action ="#" method="post">
		<input type="hidden" id="name" name="name" ></input>
		<input type="hidden" name="age" ></input>
		<input type="hidden" name="subject" ></input>
		<input type="hidden" name="content" ></input>
	</form>
	
	
	<table style="border : 1px solid; border-color : #ff0000">
		<colgroup>
			<col width = "50px"/>
			<col width = "100px"/>
			<col width = "200px"/>
			<col width = "200px"/>
		</colgroup>
		
		<thead>
			<tr>
				<td>
					이름
				</td>
				<td>
					나이
				</td>
				<td>
					제목
				</td>
				<td>
					내용
				</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr class="cursor" onclick="javascript:showDetail('<c:url value="/bbsjiDetail.do"/>','<c:out value="${result.name }"/>','<c:out value="${result.age }"/>','<c:out value="${result.subject }"/>','<c:out value="${result.content }"/>');">
					<td style="border : 1px solid; border-color : #ff0000">
						<c:out value="${result.name }"/>
					</td>
					<td style="border : 1px solid; border-color : #ff0000">
						<c:out value="${result.age }"/>
					</td>
					<td style="border : 1px solid; border-color : #ff0000">
						<c:out value="${result.subject }"/>
					</td>
					<td style="border : 1px solid; border-color : #ff0000">
						<c:out value="${result.content }"/>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	
	
<%-- <form commandName="bbsVO" action ="<c:url value='/bbsji2List.do'/>" method="post"> --%>
<!-- 	<input id="" name="one"></input> -->
<!-- 	<input name="two"></input> -->
<!-- 	<input name="three"></input> -->
<!-- 	<button type="submit">정인2</button> -->
<%-- </form> --%>

<!-- <button type="button" onclick="bbsji()">정인</button> -->
</body>
</html>